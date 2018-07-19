//
//  PictureBrowserViewController.h
//  Object-CDemo
//
//  Created by Mac on 2018/3/27.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "BaseViewController.h"
#import "PictureBrowserInteractiveAnimatedTransition.h"

//图片浏览器中图片之间的水平间距
#define kBrowseSpace 50.0f

@class PictureBrowserSouceModel;

@interface PictureBrowserViewController : BaseViewController

@property (nonatomic, strong) PictureBrowserInteractiveAnimatedTransition *animatedTransition;

@property (nonatomic, strong) NSArray<PictureBrowserSouceModel *> *dataSouceArray;

@end
