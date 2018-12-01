//
//  UIImage+HF.h
//  HF_Client_iPhone_Application
//
//  Created by header on 2018/11/5.
//  Copyright © 2018年 HengFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (HF)

/**
 计算图片尺寸
 */
- (CGSize)imageSize;

/**
 按给定的方向旋转图片
 */
- (UIImage*)rotate:(UIImageOrientation)orient;


@end

NS_ASSUME_NONNULL_END
