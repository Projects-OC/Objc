//
//  NavWechatPopAnimator.h
//  Object-CDemo
//
//  Created by Mac on 2018/3/26.
//  Copyright © 2018年 MF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NavWechatPopAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) UIImageView *transitionImgView;

@property (nonatomic, assign) CGRect transitionBeforeImgFrame;  //转场前图片的frame

@property (nonatomic, assign) CGRect transitionAfterImgFrame;   //转场后图片的frame

@end
