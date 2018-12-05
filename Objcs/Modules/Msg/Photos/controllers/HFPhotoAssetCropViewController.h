//
//  HFPhotoAssetCropViewController.h
//  Objcs
//
//  Created by wff on 2018/12/5.
//  Copyright © 2018 mf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFPhotoAssetCropViewController : UIViewController

@property (nonatomic,strong) UIImage *editedImage;

@property (nonatomic,copy) void (^ editedImageBlock) (UIImage *);

@end

NS_ASSUME_NONNULL_END
