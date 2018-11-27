//
//  UIView+HF.h
//  Objc
//
//  Created by header on 2018/11/27.
//  Copyright © 2018年 mf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    BorderTop = 0,
    BorderLeft,
    BorderBottom,
    BorderRight,
} BorderPostion;

@interface UIView (HF)

+ (NSMutableArray *)layerBorderPostions:(NSMutableArray *)postions
                            borderColor:(UIColor *)borderColor
                           cornerRadius:(CGFloat)cornerRadius
                            borderWidth:(CGFloat)borderWidth;

+ (void)layerCorners:(NSMutableArray*)corners
        cornerRadius:(CGFloat)cornerRadius;


@end

NS_ASSUME_NONNULL_END
