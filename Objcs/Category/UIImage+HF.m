//
//  UIImage+HF.m
//  HF_Client_iPhone_Application
//
//  Created by header on 2018/11/5.
//  Copyright © 2018年 HengFeng. All rights reserved.
//

#import "UIImage+HF.h"

@implementation UIImage (HF)

- (CGSize)imageSize {
    CGSize size;
    
    CGSize imgSize = self.size;
    if (imgSize.width > kScreenWidth) {
        size.width = kScreenWidth;
        size.height = kScreenWidth*imgSize.height/imgSize.width;
    } else {
        size.width = imgSize.width;
        size.height = imgSize.height;
    }
    return size;
}

@end
