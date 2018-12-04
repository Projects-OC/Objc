//
//  HFDrawBoardColors.h
//  HF_Client_iPhone_Application
//
//  Created by header on 2018/11/6.
//  Copyright © 2018年 HengFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 列表
 */
@interface HFDrawBoardColors : UIView

@property (nonatomic,copy) NSArray *colors;

@property (nonatomic,strong) UICollectionView *collection;

@property (nonatomic,copy) void (^ selectIndexBlock)(NSInteger);

@end


/**
 cell
 */
@interface HFDrawBoardColorsCell : UICollectionViewCell

@property (nonatomic,strong) UIView *colorView;
@property (nonatomic,strong) UIButton *revokeBtn;

@end

NS_ASSUME_NONNULL_END




