//
//  HFToolBarBorderView.h
//  HF_Client_iPhone_Application
//
//  Created by header on 2018/9/21.
//  Copyright © 2018年 HengFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFToolBarBorderView : UIView

/**
 bottomView

 @param titles 标题
 @param textColors 字体颜色
 @param backColors 背景色
 @param isBorder 是否需要边框
 @param tapBlock 点击回调
 */
- (instancetype)initWithTitles:(NSArray <NSString *> *)titles
                    textColors:(NSArray <UIColor *> *)textColors
                    backColors:(NSArray <UIColor *> *)backColors
                      isBorder:(BOOL)isBorder
                      tapBlock:(void (^)(NSInteger tag))tapBlock;

/**
 btn数组
 */
@property (nonatomic,strong) NSMutableArray <UIButton *> *btns;

/**
 layer边框数组
 */
@property (nonatomic,strong) NSMutableArray <CALayer *> *layers;

/**
 画线
 */
- (void)addLayer;

/**
 删除画线
 */
- (void)removeSelfLayers;

@end

NS_ASSUME_NONNULL_END
