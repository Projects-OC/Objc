//
//  PictureBrowseTransitionParameter.m
//  Object-CDemo
//
//  Created by Mac on 2018/3/27.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "PictureBrowserTransitionParameter.h"

@implementation PictureBrowserTransitionParameter

- (void)setTransitionImage:(UIImage *)transitionImage{
    _transitionImage = transitionImage;
    
    _secondVCImgFrame = [self backScreenImageViewRectWithImage:transitionImage];
}
- (void)setTransitionImgIndex:(NSInteger)transitionImgIndex{
    _transitionImgIndex = transitionImgIndex;
    
    _firstVCImgFrame = [_firstVCImgFrames[transitionImgIndex] CGRectValue];
}

//返回imageView在window上全屏显示时的frame
- (CGRect)backScreenImageViewRectWithImage:(UIImage *)image{
    
    CGSize size = image.size;
    CGSize newSize;
    newSize.width = kScreenWidth;
    newSize.height = newSize.width / size.width * size.height;
    
    CGFloat imageY = (kScreenHeight - newSize.height) * 0.5;
    
    if (imageY < 0) {
        imageY = 0;
    }
    CGRect rect =  CGRectMake(0, imageY, newSize.width, newSize.height);
    
    return rect;
}

@end
