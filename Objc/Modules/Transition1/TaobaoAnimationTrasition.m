//
//  TaobaoAnimationTrasition.m
//  Object-CDemo
//
//  Created by Mac on 2018/3/26.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "TaobaoAnimationTrasition.h"
#import "TaobaoPushAnimator.h"
#import "TaobaoPopAnimator.h"

@interface TaobaoAnimationTrasition()

@property (nonatomic, strong) TaobaoPushAnimator *customPush;
@property (nonatomic, strong) TaobaoPopAnimator *customPop;

@end

@implementation TaobaoAnimationTrasition
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

- (TaobaoPushAnimator *)customPush{
    if (_customPush == nil) {
        _customPush = [[TaobaoPushAnimator alloc]init];
    }
    return _customPush;
}

- (TaobaoPopAnimator *)customPop{
    if (!_customPop) {
        _customPop = [[TaobaoPopAnimator alloc] init];
    }
    return _customPop;
}

@end
