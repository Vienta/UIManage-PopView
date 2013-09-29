//
//  PopView.h
//  UIManageDemo
//
//  Created by 束 永兴 on 13-9-28.
//  Copyright (c) 2013年 Candy. All rights reserved.
//

typedef enum {
    kPopAnimationStyleFade = 0,     //淡入淡出
    kPopAnimationStyleBottomTop,    //自下而上
    kPopAnimationStyleBottomBottom, //自下而下
    kPopAnimationStyleTopTop,       //自上而上
    kPopAnimationStyleTopBottom,    //自上而下
    kPopAnimationStyleLeftLeft,     //自左而左
    kPopAnimationStyleLeftRight,    //自左而右
    kPopAnimationStyleRightLeft,    //自右而左
    kPopAnimationStyleRightRight,   //自右而右
}PopAnimationStyle;

#import <UIKit/UIKit.h>


@interface PopView : UIView

@property (nonatomic, assign) PopAnimationStyle popStyle;
@property (nonatomic, assign) BOOL absorb;
@property (nonatomic, strong) UIButton *absorbBtn;
@property (nonatomic, assign) CGPoint startPos;
@property (nonatomic, assign) CGPoint endPos;
- (void)hide;

- (void)dismiss;

- (void)startAnimated;

- (void)close;

- (void)show;

UIKIT_EXTERN NSString *const popViewCloseNotification;


@end


