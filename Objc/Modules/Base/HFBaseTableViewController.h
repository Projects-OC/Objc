//
//  HFBaseTableViewController.h
//  HF_Client_iPhone_Application
//
//  Created by header on 2018/9/21.
//  Copyright © 2018年 HengFeng. All rights reserved.
//

#import "HFBaseViewController.h"
#import "HFBaseTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HFBaseTableViewController : HFBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *datas;

@property(nonatomic,weak) HFBaseTableView *plainTableView;
@property(nonatomic,weak) HFBaseTableView *groupTableView;

@end

NS_ASSUME_NONNULL_END
