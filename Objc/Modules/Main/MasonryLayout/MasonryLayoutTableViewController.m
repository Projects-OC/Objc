//
//  MasonryLayoutTableViewController.m
//  Objc
//
//  Created by mf on 2018/7/25.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "MasonryLayoutTableViewController.h"
#import "MasonryLayoutTableViewCell.h"
#import "MasonryLayoutModel.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface MasonryLayoutTableViewController ()
@property (nonatomic,copy) NSMutableArray <MasonryLayoutModel *>*datas;
@end

@implementation MasonryLayoutTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[MasonryLayoutTableViewCell class]
           forCellReuseIdentifier:NSStringFromClass([MasonryLayoutTableViewCell class])];
}

- (NSMutableArray <MasonryLayoutModel *>*)datas {
    if (!_datas) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *feeds = dic[@"feed"];
        _datas = [NSMutableArray arrayWithCapacity:feeds.count];
        [feeds enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.datas addObject:[[MasonryLayoutModel alloc] initWithDictionary:obj]];
        }];
    }
    return _datas;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MasonryLayoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MasonryLayoutTableViewCell class]) forIndexPath:indexPath];
    cell.entityModel = self.datas[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    @weakify(self)
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([MasonryLayoutTableViewCell class])
                                    cacheByIndexPath:indexPath
                                       configuration:^(MasonryLayoutTableViewCell *cell) {
                                           @strongify(self)
                                           cell.entityModel = self.datas[indexPath.row];
                                       }];
}


@end
