//
//  HFBaseCollectionViewController.h
//  HF_Client_iPhone_Application
//
//  Created by header on 2018/9/25.
//  Copyright © 2018年 HengFeng. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HFBaseCollectionViewController : BaseViewController

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) UICollectionViewFlowLayout *layout;

/**
 Layout设置

 @param itemSize   cell Size
 @param inset 上下左右边距
 @param spacing cell边距
 */
- (void)layoutWithItemSize:(CGSize)itemSize
                     inset:(UIEdgeInsets)inset
                   spacing:(CGFloat)spacing;

/**
 取消选中的items

 @param indexPath 当前选中的index
 */
- (void)deselectedItemsWithCurIndexPath:(NSIndexPath *_Nullable)indexPath;

@end

NS_ASSUME_NONNULL_END
