//
//  HFPhotoAssetInfoViewController.h
//  PhotoKit
//
//  Created by header on 2018/9/19.
//  Copyright © 2018年 header. All rights reserved.
//

#import "HFBaseViewController.h"
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFPhotoAssetPreviewViewController : HFBaseViewController

@property (nonatomic,strong) PHAsset *asset;

@end

NS_ASSUME_NONNULL_END
