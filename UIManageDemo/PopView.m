//
//  PopView.m
//  UIManageDemo
//
//  Created by 束 永兴 on 13-9-28.
//  Copyright (c) 2013年 Candy. All rights reserved.
//



#import "PopView.h"


NSString *const popViewCloseNotification = @"kPopViewCloseNotification";

@implementation PopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)hide
{
    self.hidden = YES;
    if (self.absorbBtn) {
        self.absorbBtn.hidden = YES;
    }
}

- (void)show
{
    self.hidden = NO;
    if (self.absorbBtn) {
        self.absorbBtn.hidden = NO;
    }
}

- (void)dismiss
{
    if (self.absorbBtn) {
        [self.absorbBtn removeFromSuperview];
    }
    [self removeFromSuperview];
}

- (void)startAnimated
{
    [UIView animateWithDuration:.3 animations:^{
        self.alpha = 1;
    }];
    self.alpha = 0;
    
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, .4, .4);
    
    [UIView animateWithDuration:.2 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.1 animations:^{
            self.alpha = 1;
            self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
        }];
    }];
}

- (void)close
{
    [[NSNotificationCenter defaultCenter] postNotificationName:popViewCloseNotification object:self];
    [self removeFromSuperview];
}


@end
