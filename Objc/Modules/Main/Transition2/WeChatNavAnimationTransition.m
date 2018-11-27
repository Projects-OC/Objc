//
//  WeChatNavAnimationTransition.m
//  Object-CDemo
//
//  Created by Mac on 2018/3/26.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "WeChatNavAnimationTransition.h"
#import "NavWechatPopAnimator.h"
#import "NavWechatPushAnimator.h"

@interface WeChatNavAnimationTransition()

@property (nonatomic, strong) NavWechatPushAnimator *customPush;
@property (nonatomic, strong) NavWechatPopAnimator  *customPop;


@end

@implementation WeChatNavAnimationTransition

/** 转场过渡的图片 */
- (void)setTransitionImgView:(UIImageView *)transitionImgView{
    self.customPush.transitionImgView = transitionImgView;
    self.customPop.transitionImgView = transitionImgView;
}

/** 转场前的图片frame */
- (void)setTransitionBeforeImgFrame:(CGRect)frame{
    self.customPop.transitionBeforeImgFrame = frame;
    self.customPush.transitionBeforeImgFrame = frame;
}

/** 转场后的图片frame */
- (void)setTransitionAfterImgFrame:(CGRect)frame{
    self.customPush.transitionAfterImgFrame = frame;
    self.customPop.transitionAfterImgFrame = frame;
}


- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        return self.customPush;
        
    }else if (operation == UINavigationControllerOperationPop){
        return self.customPop;
    }
    return nil;
}

- (NavWechatPushAnimator *)customPush{
    if (_customPush == nil) {
        _customPush = [[NavWechatPushAnimator alloc]init];
    }
    return _customPush;
}

- (NavWechatPopAnimator *)customPop{
    if (!_customPop) {
        _customPop = [[NavWechatPopAnimator alloc] init];
    }
    return _customPop;
}

@end
