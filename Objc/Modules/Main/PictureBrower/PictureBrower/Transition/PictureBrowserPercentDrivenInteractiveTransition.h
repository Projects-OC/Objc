//
//  PictureBrowserPercentDrivenInteractiveTransition.h
//  Object-CDemo
//
//  Created by Mac on 2018/3/27.
//  Copyright © 2018年 MF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PictureBrowserTransitionParameter;

@interface PictureBrowserPercentDrivenInteractiveTransition : UIPercentDrivenInteractiveTransition

- (instancetype)initWithTransitionParameter:(PictureBrowserTransitionParameter *)transitionParameter;

@end
