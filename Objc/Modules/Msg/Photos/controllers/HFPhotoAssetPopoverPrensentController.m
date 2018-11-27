//
//  HFPhotoAssetPopoverPrensentController.m
//  PhotoKit
//
//  Created by header on 2018/9/18.
//  Copyright © 2018年 header. All rights reserved.
//

#import "HFPhotoAssetPopoverPrensentController.h"
#import <Photos/Photos.h>

typedef void (^AlbumClickBlock) (NSInteger index);

@interface HFPhotoAssetPopoverPrensentController ()

@property (nonatomic,copy) NSArray *albums;
@property (nonatomic,copy) AlbumClickBlock clickBlock;

@end

@implementation HFPhotoAssetPopoverPrensentController

- (instancetype)initWithAlbums:(NSArray *)albums
                    clickBlock:(void (^)(NSInteger index))block {
    self = [super init];
    if (self) {
        _albums = albums;
        _clickBlock = block;
    }
    return self;
}

- (void)updateAlbums:(NSArray *)albums {
    _albums = albums;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorInset = UIEdgeInsetsZero;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (void)setSelectTitle:(NSString *)selectTitle {
    _selectTitle = selectTitle;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _albums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    
    NSDictionary *albumDic = _albums[indexPath.row];
    NSArray *photos = [[albumDic allValues] lastObject];//图片个数
    NSString *title = [[albumDic allKeys] lastObject];//相册名称

    cell.textLabel.text = [NSString stringWithFormat:@"%@（%lu）",title,(unsigned long)photos.count];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    if (_selectTitle && [_selectTitle isEqualToString:title]) {
        cell.textLabel.textColor = [UIColor greenColor];
    } else {
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_clickBlock) {
        _clickBlock(indexPath.row);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
