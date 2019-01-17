//
//  NSString+Size.h
//  Objcs
//
//  Created by wff on 2019/1/17.
//  Copyright © 2019 mf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Size)

/**
 *  给定宽度，字体，返回高度
 *
 *  @param width PreferWidth
 *  @param font  字体
 */
- (CGSize)sizeWithPreferWidth:(CGFloat)width font:(UIFont *)font;

/**
 *  给定高度，字体，返回宽度
 *
 *  @param height 固定高度
 *  @param font  字体
 */
- (CGSize)sizeWithpreferHeight:(CGFloat)height font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
