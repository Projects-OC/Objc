//
//  HFPhotoAssetCollectionViewCell.h
//  PhotoKit
//
//  Created by header on 2018/9/18.
//  Copyright © 2018年 header. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface HFPhotoAssetCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *img;

@property (nonatomic,strong) PHAsset * asset;

@property (nonatomic,copy) void (^ doubleTapBlock) (NSInteger index);

@end
