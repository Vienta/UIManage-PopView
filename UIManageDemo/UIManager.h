//
//  UIManager.h
//  UIManageDemo
//
//  Created by 束 永兴 on 13-9-28.
//  Copyright (c) 2013年 Candy. All rights reserved.
//

typedef enum {
    kLastPopOptionHidden = 0,
    kLastPopOptionDelete,
}kLastPopOption;

#import <Foundation/Foundation.h>
#import "PopView.h"


@interface UIManager : NSObject
{
    NSMutableArray *_popviewStack;
    PopView *_curView;
    UIView *_navView;
}

@property (nonatomic, strong) UIView *curView;
@property (nonatomic, strong) UIView *nextView;

+ (UIManager *)shareUIManger;

/**
 *  popview创建方法
 *
 *  @param pop    需要弹出的popview
 *  @param pos    位置
 *  @param style  动画类型
 *  @param ab     点击弹框外的空旷处时候能够吸收 YES:吸收(即点击之后弹框关闭) NO:不吸收(即点击之后弹框没有变化)
 *  @param bk     背景button是否阻断
 *  @param rb     背景罩是否加黑透明
 *  @param option 对上个popview的处理
 */
- (void)popView:(PopView *)pop
             center:(CGPoint)pos
     animationStyle:(PopAnimationStyle)style
             absorb:(BOOL)ab
              block:(BOOL)bk
   renderBackground:(BOOL)rb
      lastPopOption:(kLastPopOption)option;

//无阻断 中间出 有背景
- (void)popView:(PopView *)pop;
//无阻断 中间出 无背景
- (void)popViewClear:(PopView *)pop;
//能够透 中间出 无背景
- (void)popViewAbsorb:(PopView *)pop;
//能够透 中间出 lastPopview隐藏
- (void)popViewAbsorbLastPopHidden:(PopView *)pop;

/**
 *  创建popview
 *
 *  @param pop   popView
 *  @param pos   popView所要定的位置
 *  @param style popView弹出动画类型
 */
- (void)popView:(PopView *)pop
             center:(CGPoint)pos
     animationStyle:(PopAnimationStyle)style;
/**
 *  查找popview
 *
 *  @param idx 序列
 *
 *  @return popview
 */
- (id)popViewAtIndex:(NSUInteger)idx;


- (void)dismissCurPopView;


@end
