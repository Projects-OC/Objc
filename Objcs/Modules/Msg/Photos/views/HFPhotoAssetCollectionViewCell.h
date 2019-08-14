//
//  HFPhotoAssetCollectionViewCell.h
//  PhotoKit
//
//  Created by header on 2018/9/18.
//  Copyright © 2018年 header. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
@class HFPhotoAssetModel;

@interface HFPhotoAssetCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UIImageView *markImg;
//@property (nonatomic,strong) UIView *markView;
@property (nonatomic,strong) UIView *blurView;
@property (nonatomic,strong) UILabel *markLb;

@property (nonatomic,strong) HFPhotoAssetModel *assetModel;

/**
 是否灰度处理
 */
@property (nonatomic,assign) BOOL isGrayImage;

@property (nonatomic,strong) PHAsset * asset;

@property (nonatomic,copy) void (^ singleTapBlock) (NSInteger index);
@property (nonatomic,copy) void (^ doubleTapBlock) (NSInteger index);

//-(UIImage *)grayImage:(UIImage*)originImage;

@end


@interface HFPhotoAssetCameraCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *imgView;

@end
