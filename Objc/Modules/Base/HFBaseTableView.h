//
//  HFBaseTableView.h
//  HF_Client_iPhone_Application
//
//  Created by header on 2018/9/21.
//  Copyright © 2018年 HengFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"

NS_ASSUME_NONNULL_BEGIN

@interface HFBaseTableView : UITableView<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

/**空数据背景图竖直方向偏移*/
@property(nonatomic,assign)CGFloat verticalOffset;

/**空数据提示信息*/
@property (nonatomic,copy) NSString * _Nullable emptyTitle;

/**空数据提示图片*/
@property (nonatomic,copy) NSString * _Nullable emptyImage;

@property (nonatomic,copy) void (^ _Nullable tapViewBlock)(void);

/**
 注册cell
 */
- (void)registerClassCells:(NSArray <Class>*_Nullable)cells;

/**
 注册header footer
 */
- (void)registerClassHeaderFooters:(NSArray <Class>*_Nullable)headerFooters;

@end

NS_ASSUME_NONNULL_END
