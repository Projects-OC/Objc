//
//  HFPhotoAssetDrawViewController.h
//  Objcs
//
//  Created by wff on 2018/11/30.
//  Copyright © 2018年 mf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFPhotoAssetDrawViewController : UIViewController

@property (nonatomic,strong) UIImage *editedImage;

@property (nonatomic,assign) CGSize clipImageSize;

@property (nonatomic,copy) void (^ editedImageBlock) (UIImage *image,CGSize clipImageSize);

@end
