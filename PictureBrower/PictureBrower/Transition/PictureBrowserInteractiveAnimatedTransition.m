//
//  PictureBrowserInteractiveAnimatedTransition.m
//  Object-CDemo
//
//  Created by Mac on 2018/3/27.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "PictureBrowserInteractiveAnimatedTransition.h"
#import "PictureBrowserPercentDrivenInteractiveTransition.h"
#import "PictureBrowserPushAnimator.h"
#import "PictureBrowserPopAnimator.h"

@interface PictureBrowserInteractiveAnimatedTransition ()

@property (nonatomic, strong) PictureBrowserPushAnimator *customPush;
@property (nonatomic, strong) PictureBrowserPopAnimator  *customPop;
@property (nonatomic, strong) PictureBrowserPercentDrivenInteractiveTransition *percentIntractive;

@end

@implementation PictureBrowserInteractiveAnimatedTransition
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self.customPush;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self.customPop;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
    
    return nil;//push时不加手势交互
}
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    if (self.transitionParameter.gestureRecognizer)
        return self.percentIntractive;
    else
        return nil;
    
}

-(PictureBrowserPushAnimator *)customPush{
    if (!_customPush) {
        _customPush = [[PictureBrowserPushAnimator alloc]init];
    }
    return _customPush;
}

- (PictureBrowserPopAnimator *)customPop {
    if (!_customPop) {
        _customPop = [[PictureBrowserPopAnimator alloc] init];
    }
    return _customPop;
}
- (PictureBrowserPercentDrivenInteractiveTransition *)percentIntractive{
    if (!_percentIntractive) {
        _percentIntractive = [[PictureBrowserPercentDrivenInteractiveTransition alloc] initWithTransitionParameter:self.transitionParameter];
    }
    return _percentIntractive;
}

-(void)setTransitionParameter:(PictureBrowserTransitionParameter *)transitionParameter{
    _transitionParameter = transitionParameter;
    self.customPush.transitionParameter = transitionParameter;
    self.customPop.transitionParameter = transitionParameter;
}

@end
