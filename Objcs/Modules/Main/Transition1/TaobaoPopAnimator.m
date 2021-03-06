//
//  TaobaoSecondPopAnimator.m
//  Object-CDemo
//
//  Created by Mac on 2018/3/26.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "TaobaoPopAnimator.h"

@implementation TaobaoPopAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    //转场过渡的容器view
    UIView *containerView = [transitionContext containerView];
    
    //ToVC
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    [containerView addSubview:toView];
    
    //图片背景的空白view (设置和控制器的背景颜色一样，给人一种图片被调走的假象)
    UIView *imgBgWhiteView = [[UIView alloc] initWithFrame:self.transitionBeforeImgFrame];
    imgBgWhiteView.backgroundColor = [UIColor grayColor];
    [containerView addSubview:imgBgWhiteView];
    
    //有渐变的白色背景
    UIView *bgView = [[UIView alloc] initWithFrame:containerView.bounds];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.alpha = 1;
    [containerView addSubview:bgView];
    
    //过渡的图片
    UIImageView *transitionImgView = [[UIImageView alloc] initWithImage:self.transitionImgView.image];
    transitionImgView.frame = self.transitionAfterImgFrame;
    [transitionContext.containerView addSubview:transitionImgView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.3
                        options:UIViewAnimationOptionCurveLinear animations:^{
        
                            transitionImgView.frame = self.transitionBeforeImgFrame;
                            bgView.alpha = 0;
                            
                        } completion:^(BOOL finished) {
                            
                            BOOL wasCancelled = [transitionContext transitionWasCancelled];
                            
                            [imgBgWhiteView removeFromSuperview];
                            [bgView removeFromSuperview];
                            [transitionImgView removeFromSuperview];
                            
                            //设置transitionContext通知系统动画执行完毕
                            [transitionContext completeTransition:!wasCancelled];
                        }];
    
}

@end
