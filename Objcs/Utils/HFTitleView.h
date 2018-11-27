//
//  HFTitleView.h
//  HF_Client_iPhone_Application
//
//  Created by header on 2018/9/29.
//  Copyright © 2018年 HengFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFTitleView : UIView

- (instancetype)initWithTitle:(NSString *)title;

@property (nonatomic,strong) UIButton *titleBtn;

/**
 重写intrinsicContentSize
 */
@property(nonatomic,assign) CGSize intrinsicContentSize;

@end

NS_ASSUME_NONNULL_END
