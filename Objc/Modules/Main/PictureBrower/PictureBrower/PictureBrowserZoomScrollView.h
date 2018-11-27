//
//  PictureBrowserScrollView.h
//  Object-CDemo
//
//  Created by Mac on 2018/3/27.
//  Copyright © 2018年 MF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureBrowserZoomScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic,strong) UIImageView *zoomImageView;
@property (nonatomic,copy)   void (^tapBlock)(void);

@end
