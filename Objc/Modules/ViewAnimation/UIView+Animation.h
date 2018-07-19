//
//  UIView+Animation.h
//  Object-CDemo
//
//  Created by Mac on 2018/3/24.
//  Copyright © 2018年 MF. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 View动画
 UIViewAnimation
 UIViewAnimationWithBlocks
 UIViewKeyframeAnimations
 */

/**
 UIViewAnimationOptionRepeat 动画循环执行
 UIViewAnimationOptionAutoreverse 动画在执行完毕后会反方向再执行一次
 UIViewAnimationOptionTransitionNone //没有效果，默认
 UIViewAnimationOptionTransitionFlipFromLeft //从左翻转效果
 UIViewAnimationOptionTransitionFlipFromRight //从右翻转效果
 UIViewAnimationOptionTransitionCurlUp //从上往下翻页
 UIViewAnimationOptionTransitionCurlDown //从下往上翻页
 UIViewAnimationOptionTransitionCrossDissolve //旧视图溶解过渡到下一个视图
 UIViewAnimationOptionTransitionFlipFromTop //从上翻转效果
 UIViewAnimationOptionTransitionFlipFromBottom //从下翻转效果
 */

/**
 UIViewKeyframeAnimationOptionCalculationModeLinear  连续运算模式，线性
 UIViewKeyframeAnimationOptionCalculationModeDiscrete   离散运算模式，只显示关键帧
 UIViewKeyframeAnimationOptionCalculationModePaced  均匀执行运算模式，线性
 UIViewKeyframeAnimationOptionCalculationModeCubic  平滑运算模式
 UIViewKeyframeAnimationOptionCalculationModeCubicPaced 平滑均匀运算模式
 */


/**
 UIViewAnimationCurveEaseInOut 开始和结束时较慢
 UIViewAnimationCurveEase  开始时较慢
 UIViewAnimationCurveEaseOut 结束时较慢
 UIViewAnimationCurveLinear 整个过程匀速进行
 */

/**
 CGAffineTransformMakeTranslation   平移
 CGAffineTransformMakeScale 缩放
 CGAffineTransformMakeRotation  设置角度来生成矩阵
 CGAffineTransformRotate    旋转
 CGAffineTransformInvert    反向旋转
 CGAffineTransformConcat    合并Transform
 CGAffineTransformIdentity  恢复
 */
@interface UIView (Animation)

/**
 block动画，可以设置动画时长、动画延迟、动画选项、动画结束状态、动画完成后最终状态，
 可根据自己实际需要选择下面3种实现方式
 **/
+ (void)animateWithDuration:(NSTimeInterval)duration
                      delay:(NSTimeInterval)delay
                    options:(UIViewAnimationOptions)options
                 animations:(void (^ __nullable)(void))animations
                 completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(4_0);

+ (void)animateWithDuration:(NSTimeInterval)duration
                 animations:(void (^ __nullable)(void))animations
                 completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(4_0); // delay = 0.0, options = 0


//视图过渡动画
+ (void)transitionWithView:(UIView *)view
                  duration:(NSTimeInterval)duration
                   options:(UIViewAnimationOptions)options
                animations:(void (^ __nullable)(void))animations
                completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(4_0);

//视图间过渡动画
+ (void)transitionFromView:(UIView *)fromView
                    toView:(UIView *)toView
                  duration:(NSTimeInterval)duration
                   options:(UIViewAnimationOptions)options
                completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(4_0); // toView added to fromView.superview, fromView removed from its superview

//弹簧动画
+ (void)animateWithDuration:(NSTimeInterval)duration
                      delay:(NSTimeInterval)delay
     usingSpringWithDamping:(CGFloat)dampingRatio
      initialSpringVelocity:(CGFloat)velocity
                    options:(UIViewAnimationOptions)options
                 animations:(void (^ __nullable)(void))animations
                 completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(7_0);

//删除视图动画
+ (void)performSystemAnimation:(UISystemAnimation)animation
                       onViews:(NSArray<__kindof UIView *> *)views
                       options:(UIViewAnimationOptions)options
                    animations:(void (^ __nullable)(void))parallelAnimations
                    completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(7_0);

@end
