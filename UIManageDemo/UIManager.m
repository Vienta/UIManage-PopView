//
//  UIManager.m
//  UIManageDemo
//
//  Created by 束 永兴 on 13-9-28.
//  Copyright (c) 2013年 Candy. All rights reserved.
//

#import "UIManager.h"
#import "AppDelegate.h"
#import "PopView.h"

#define WINDOW_FRAME CGRectMake(0, 0, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT)
#define MAINSCREEN_WIDTH    [UIScreen mainScreen].bounds.size.height
#define MAINSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.width
#define PopupDuration .3

@implementation UIManager

+ (UIManager *)shareUIManger
{
    static UIManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

- (id)init
{
    if (self = [super init]) {
        _popviewStack = [NSMutableArray arrayWithCapacity:10];
        _curView = nil;
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        NSAssert(app.navController != nil, @"app.navControllor can not been nil. Suggest push uiviewControllers into navgationController");
        _navView = app.navController.view;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popViewClose:) name:popViewCloseNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:popViewCloseNotification object:nil];
}

- (void)popViewClose:(NSNotification *)noti
{
    PopView *pop = noti.object;
    [pop.absorbBtn removeFromSuperview];
    [_popviewStack removeObject:pop];
    if (_popviewStack && [_popviewStack lastObject]) {
        PopView *lpop = [_popviewStack lastObject];
        NSAssert(lpop != nil, @"last Popview can not been nil");
        [lpop show];
        [lpop startAnimated];
    }
    _curView = [_popviewStack lastObject];
    NSLog(@"_popStack : %@", _popviewStack);
}

- (void)tapAbsorbBtn:(id)sender
{
    [_popviewStack enumerateObjectsUsingBlock:^(PopView *pop, NSUInteger idx, BOOL *stop) {
        if([pop.absorbBtn isEqual:sender]) {
            
            CGPoint endPos;
            
            switch (pop.popStyle) {
                case kPopAnimationStyleBottomTop:
                case kPopAnimationStyleTopBottom:{
                    //向下消失
                    endPos = CGPointMake(pop.startPos.x, MAINSCREEN_HEIGHT - pop.startPos.y);
                }
                    break;
               
                case kPopAnimationStyleRightLeft:
                case kPopAnimationStyleLeftRight:{
                    endPos = CGPointMake(MAINSCREEN_WIDTH-pop.startPos.x, pop.startPos.y);
                }
                    break;
                    
                case kPopAnimationStyleLeftLeft:
                case kPopAnimationStyleTopTop:
                case kPopAnimationStyleBottomBottom:
                case kPopAnimationStyleRightRight:
                case kPopAnimationStyleFade:
                default:
                    endPos = pop.startPos;
                    break;
            }
            [UIView animateWithDuration:PopupDuration animations:^{
                pop.center = endPos;
            } completion:^(BOOL finished) {
                [pop close];
            }];
            *stop = YES;
        }
    }];
    NSLog(@"_popStack : %@", _popviewStack);
}

- (void)popView:(PopView *)pop
{
    [self popView:pop
               center:CGPointMake(MAINSCREEN_WIDTH/2, MAINSCREEN_HEIGHT/2)
       animationStyle:kPopAnimationStyleFade
               absorb:YES
                block:NO
     renderBackground:YES
        lastPopOption:kLastPopOptionDelete];
}

- (void)popViewClear:(PopView *)pop
{
    [self popView:pop
               center:CGPointMake(MAINSCREEN_WIDTH/2, MAINSCREEN_HEIGHT/2)
       animationStyle:kPopAnimationStyleFade
               absorb:YES
                block:NO
     renderBackground:NO
        lastPopOption:kLastPopOptionDelete];
}

- (void)popViewAbsorb:(PopView *)pop
{
    [self popView:pop
               center:CGPointMake(MAINSCREEN_WIDTH/2, MAINSCREEN_HEIGHT/2)
       animationStyle:kPopAnimationStyleFade
               absorb:NO
                block:NO
     renderBackground:NO
        lastPopOption:kLastPopOptionDelete];
}

- (void)popViewAbsorbLastPopHidden:(PopView *)pop
{
    [self popView:pop
           center:CGPointMake(MAINSCREEN_WIDTH/2, MAINSCREEN_HEIGHT/2)
   animationStyle:kPopAnimationStyleFade
           absorb:NO
            block:NO
 renderBackground:NO
    lastPopOption:kLastPopOptionHidden];
}

- (void)popView:(PopView *)pop center:(CGPoint)pos animationStyle:(PopAnimationStyle)style
{
    [self popView:pop
               center:pos
       animationStyle:style
               absorb:YES
                block:NO
     renderBackground:YES
        lastPopOption:kLastPopOptionDelete];
}

- (void)popView:(PopView *)pop
             center:(CGPoint)pos
     animationStyle:(PopAnimationStyle)style
             absorb:(BOOL)ab
              block:(BOOL)bk
   renderBackground:(BOOL)rb
      lastPopOption:(kLastPopOption)option
{
    NSAssert(pop != nil, @"PopView can not been nil");
    if (_popviewStack && [_popviewStack lastObject]) {
        PopView *lastPop = [_popviewStack lastObject];
        switch (option) {
            case kLastPopOptionHidden:
                [lastPop hide];
                break;
            case kLastPopOptionDelete:
            default:{
                [lastPop performSelector:@selector(dismiss)];
                [_popviewStack removeObject:lastPop];
            }
                break;
        }
    }
    [_popviewStack addObject:pop];
    
    _curView = [_popviewStack lastObject];
    
    if (ab) {
        //点击之后弹框关闭 加背景button
        pop.absorbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_navView addSubview:pop.absorbBtn];
        pop.absorbBtn.frame = CGRectMake(0, 0, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT);
        if (bk) {
            [pop.absorbBtn removeTarget:self action:@selector(tapAbsorbBtn:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [pop.absorbBtn addTarget:self action:@selector(tapAbsorbBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
        if (rb) {
            //加透明黑遮罩
            pop.absorbBtn.alpha = .5;
            pop.absorbBtn.layer.opacity = .5;
            pop.absorbBtn.backgroundColor = [UIColor blackColor];
        } else {
            //不加透明遮罩
        }
    } else {
        //不加背景button
        pop.absorbBtn = nil;
    }
    pop.absorb = ab;
    
    if (!style) {
        style = kPopAnimationStyleFade;
    }
    
    pop.popStyle = style;
    CGFloat pContentWidth = pop.bounds.size.width;
    CGFloat pContentHeight = pop.bounds.size.height;
    CGPoint startPos;

    switch (style) {
        case kPopAnimationStyleFade:{
            startPos = pos;
        }
            break;
        case kPopAnimationStyleBottomBottom:
        case kPopAnimationStyleBottomTop:{
            //起点在下
            startPos = CGPointMake(pos.x, MAINSCREEN_HEIGHT+pContentHeight/2);
        }
            break;
        case kPopAnimationStyleTopBottom:
        case kPopAnimationStyleTopTop:{
            //起点在上
            startPos = CGPointMake(pos.x, -pContentHeight/2);
        }
            break;
        case kPopAnimationStyleLeftLeft:
        case kPopAnimationStyleLeftRight:{
            //起点在左
            startPos = CGPointMake(-pContentWidth/2, pos.y);
        }
            break;
        case kPopAnimationStyleRightLeft:
        case kPopAnimationStyleRightRight:{
            //起点在右边
            startPos = CGPointMake(MAINSCREEN_WIDTH+pContentWidth/2, pos.y);
        }
            break;
            
        default:
            break;
    }
    if (style == kPopAnimationStyleFade) {
        pop.startPos = pop.endPos = pos;
        pop.center = pos;
        [pop startAnimated];
    } else {
        pop.center = startPos;
        pop.startPos = startPos;
        [UIView animateWithDuration:PopupDuration animations:^{
            pop.center = pos;
            pop.endPos = pos;
        }];
    }

    [_navView addSubview:pop];
    NSLog(@"点击 POpStack = %@", _popviewStack);
}

- (id)popViewAtIndex:(NSUInteger)idx
{
    return [_popviewStack objectAtIndex:idx];
}

- (void)dismissCurPopView
{
    if (_curView) {
        [_curView close];
    }
}

@end
