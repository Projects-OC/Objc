//
//  PictureBrowserPushAnimator.h
//  Object-CDemo
//
//  Created by Mac on 2018/3/27.
//  Copyright © 2018年 MF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PictureBrowserTransitionParameter;

@interface PictureBrowserPushAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) PictureBrowserTransitionParameter *transitionParameter;

@end
