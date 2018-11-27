//
//  HFBaseTableViewController.m
//  HF_Client_iPhone_Application
//
//  Created by header on 2018/9/21.
//  Copyright © 2018年 HengFeng. All rights reserved.
//

#import "HFBaseTableViewController.h"
#import "HFBaseTableView.h"

@interface HFBaseTableViewController ()

@end

@implementation HFBaseTableViewController

- (void)viewWillDisappear:(BOOL)animated{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSMutableArray *)datas{
    if (!_datas) {
        _datas = [[NSMutableArray alloc] init];
    }
    return _datas;
}

- (HFBaseTableView *)plainTableView{
    if (!_plainTableView) {
        HFBaseTableView *tableView = [[HFBaseTableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
        tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        _plainTableView = tableView;
    }
    return _plainTableView;
}

- (HFBaseTableView *)groupTableView{
    if (!_groupTableView) {
        HFBaseTableView *groupView = [[HFBaseTableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        groupView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
        groupView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        groupView.separatorInset = UIEdgeInsetsZero;
        groupView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        groupView.delegate = self;
        groupView.dataSource = self;
        [self.view addSubview:groupView];
        _groupTableView = groupView;
    }
    return _groupTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [self.view endEditing:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
