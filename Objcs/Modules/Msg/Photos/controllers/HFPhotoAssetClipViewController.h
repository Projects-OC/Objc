//
//  HFPhotoAssetClipViewController.h
//  Objcs
//
//  Created by wff on 2018/11/30.
//  Copyright © 2018年 mf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFPhotoAssetClipViewController : UIViewController

@property (nonatomic,strong) UIImage *editedImage;

@property (nonatomic,copy) void (^ editedImageBlock) (UIImage *);

@end
