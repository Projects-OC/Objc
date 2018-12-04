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
- (UIImage*)imageRotateOrientation:(UIImageOrientation)orientation;

/**
 图片裁剪

 @param rect 裁剪范围
 */
- (UIImage *)imageCropRect:(CGRect)rect superViewRect:(CGRect)superViewRect;


@end

NS_ASSUME_NONNULL_END
