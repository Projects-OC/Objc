//
//  FloatingAnimator.m
//  Objcs
//
//  Created by wff on 2018/11/28.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "FloatingAnimator.h"
#import "FloatingAnimatorView.h"

@interface FloatingAnimator ()

@end

@implementation FloatingAnimator

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 1.f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    //fromView、fromViewController、toView、toViewController、containerView
    
    UIView *contrainerView = transitionContext.containerView;
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [contrainerView addSubview:toView];
    
    FloatingAnimatorView *animatorView = [[FloatingAnimatorView alloc] initWithFrame:toView.bounds];
    [contrainerView addSubview:animatorView];
    
    //截屏
    UIGraphicsBeginImageContext(toView.frame.size);
    [toView.layer renderInContext:UIGraphicsGetCurrentContext()];
    animatorView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    toView.hidden = YES;
    //animator是从悬浮view.frame展开到toview.frame
    [animatorView startAnimateView:toView fromeRect:_curFrame toRect:toView.frame];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //移除fromView、fromController
        [transitionContext completeTransition:YES];
    });
}


@end
