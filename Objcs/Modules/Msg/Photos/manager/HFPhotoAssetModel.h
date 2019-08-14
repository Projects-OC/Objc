//
//  HFPhotoAssetModel.h
//  Objcs
//
//  Created by header on 2019/8/7.
//  Copyright © 2019 mf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFPhotoAssetModel : NSObject

/**
 序号id
 */
@property (nonatomic,assign) NSInteger id;

/**
 是否灰度处理图片
 */
@property (nonatomic,assign) BOOL isGrayImage;

/**
 是否标记
 */
@property (nonatomic,assign) BOOL isMarked;

/**
 下标 NSIndexPath.row
 */
@property (nonatomic,assign) NSInteger index;

@end

NS_ASSUME_NONNULL_END
