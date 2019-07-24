//
//  InputKeyboardTextView.h
//  Objcs
//
//  Created by header on 2019/7/23.
//  Copyright © 2019 mf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InputKeyboardTextView : UITextView

/**
 *  textView最大行数，默认为4行
 */
@property (nonatomic, assign) NSUInteger maxNumberOfLines;

/**
 *  文字高度改变block → 文字高度改变会自动调用
 *  block参数(text) → 文字内容
 *  block参数(textHeight) → 文字高度
 */
@property (nonatomic,copy) void (^ inputBlock)(CGFloat height);
@property (nonatomic,copy) void (^ textBlock)(NSString *);

@end

NS_ASSUME_NONNULL_END
