//
//  PictureBrowserPercentDrivenInteractiveTransition.m
//  Object-CDemo
//
//  Created by Mac on 2018/3/27.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "PictureBrowserPercentDrivenInteractiveTransition.h"
#import "PictureBrowserTransitionParameter.h"

@interface PictureBrowserPercentDrivenInteractiveTransition ()

@property (nonatomic, strong) PictureBrowserTransitionParameter *transitionParameter;

@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *gestureRecognizer;

@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIView *fromView;

@property(nonatomic, strong) UIView *firstVCImgWhiteView;
@property(nonatomic, strong) UIView *blackBgView;

@end

@implementation PictureBrowserPercentDrivenInteractiveTransition

- (void)dealloc{
    [self.gestureRecognizer removeTarget:self action:@selector(gestureRecognizeDidUpdate:)];
}

#pragma delegate
- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.transitionContext = transitionContext;
    NSLog(@"--------startInteractiveTransition--------");
    [self beginInterPercent];
}

-(instancetype)initWithTransitionParameter:(PictureBrowserTransitionParameter *)transitionParameter{
    self = [super init];
    if (self){
        _transitionParameter = transitionParameter;
        _gestureRecognizer = transitionParameter.gestureRecognizer;
        [_gestureRecognizer addTarget:self action:@selector(gestureRecognizeDidUpdate:)];
    }
    return self;
}

- (void)gestureRecognizeDidUpdate:(UIPanGestureRecognizer *)gestureRecognizer{
    CGFloat scrale = [self percentForGesture:gestureRecognizer];
    switch (gestureRecognizer.state){
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateChanged:
            [self updateInteractiveTransition:[self percentForGesture:gestureRecognizer]];
            [self updateInterPercent:[self percentForGesture:gestureRecognizer]];
            break;
        case UIGestureRecognizerStateEnded:
            if (scrale > 0.95f){
                [self cancelInteractiveTransition];
                [self interPercentCancel];
            }
            else{
                [self finishInteractiveTransition];
                [self interPercentFinish:scrale];
            }
            break;
        default:
            [self cancelInteractiveTransition];
            [self interPercentCancel];
            break;
    }
}

- (CGFloat)percentForGesture:(UIPanGestureRecognizer *)gesture{
    CGPoint translation = [gesture translationInView:gesture.view];
    CGFloat scale = 1 - (translation.y / kScreenWidth);
    scale = scale < 0 ? 0 : scale;
    scale = scale > 1 ? 1 : scale;
    return scale;
}

//开始
- (void)beginInterPercent{
    id<UIViewControllerContextTransitioning> transitionContext = self.transitionContext;
    //转场过渡的容器view
    UIView *containerView = [transitionContext containerView];
    
    //ToVC
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    [containerView addSubview:toView];
    
    //图片背景白色的空白view
    _firstVCImgWhiteView = [[UIView alloc] initWithFrame:self.transitionParameter.firstVCImgFrame];
    _firstVCImgWhiteView.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:_firstVCImgWhiteView];
    
    //有渐变的黑色背景
    _blackBgView = [[UIView alloc] initWithFrame:containerView.bounds];
    _blackBgView.backgroundColor = [UIColor blackColor];
    [containerView addSubview:_blackBgView];
    
    //FromVC
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromViewController.view;
    fromView.backgroundColor = [UIColor clearColor];
    [containerView addSubview:fromView];
}

//改变
- (void)updateInterPercent:(CGFloat)scale{
    _blackBgView.alpha = scale * scale * scale;
}

//取消
- (void)interPercentCancel{
    id<UIViewControllerContextTransitioning> transitionContext = self.transitionContext;
    
    //转场过渡的容器view
    UIView *containerView = [transitionContext containerView];
    
    //FromVC
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromViewController.view;
    fromView.backgroundColor = [UIColor blackColor];
    [containerView addSubview:fromView];
    
    [_blackBgView removeFromSuperview];
    [_firstVCImgWhiteView removeFromSuperview];
    _blackBgView = nil;
    _firstVCImgWhiteView = nil;
    
    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
}

//完成
- (void)interPercentFinish:(CGFloat)scale{
    id<UIViewControllerContextTransitioning> transitionContext = self.transitionContext;
    
    //转场过渡的容器view
    UIView *containerView = [transitionContext containerView];
    
    //ToVC
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    [containerView addSubview:toView];
    
    //图片背景白色的空白view
    UIView *imgBgWhiteView = [[UIView alloc] initWithFrame:self.transitionParameter.firstVCImgFrame];
    imgBgWhiteView.backgroundColor =[UIColor whiteColor];
    [containerView addSubview:imgBgWhiteView];
    
    //有渐变的黑色背景
    UIView *bgView = [[UIView alloc] initWithFrame:containerView.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = scale;
    [containerView addSubview:bgView];
    
    //过渡的图片
    UIImageView *transitionImgView = [[UIImageView alloc] initWithImage:self.transitionParameter.transitionImage];
    transitionImgView.clipsToBounds = YES;
    transitionImgView.frame = self.transitionParameter.currentPanGestImgFrame;
    [containerView addSubview:transitionImgView];
    
    [UIView animateWithDuration:0.4
                          delay:0.0
         usingSpringWithDamping:0.8
          initialSpringVelocity:0.1
                        options:UIViewAnimationOptionCurveLinear animations:^{
                            transitionImgView.frame = self.transitionParameter.firstVCImgFrame;
                            bgView.alpha = 0;
                        }completion:^(BOOL finished) {
                            [_blackBgView removeFromSuperview];
                            [_firstVCImgWhiteView removeFromSuperview];
                            _blackBgView = nil;
                            _firstVCImgWhiteView = nil;
                            
                            [bgView removeFromSuperview];
                            [imgBgWhiteView removeFromSuperview];
                            [transitionImgView removeFromSuperview];
                            
                            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                        }];
}



@end
