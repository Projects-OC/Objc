//
//  InkeViewController.m
//  Objcs
//
//  Created by header on 2018/12/7.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "InkeViewController.h"
#import "InkeCollectionViewCell.h"
#import "InkePlayViewController.h"
#import "PlayerViewController.h"
#import "InkeModel.h"

@class InkeListModel;

@interface InkeViewController ()

@property(nonatomic,strong) InkeModel *model;

@end

@implementation InkeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configLayout];
    [self loadData];
}

- (void)configLayout{
    NSInteger num = 2;
    CGFloat padding = 12;
    CGFloat itemWH = (self.view.frame.size.width - (num + 1) * padding) / num;
    [self layoutWithItemSize:CGSizeMake(itemWH, itemWH)
                       inset:UIEdgeInsetsMake(padding, padding, padding, padding)
                     spacing:padding];
    
    self.collectionView.allowsMultipleSelection = YES;
    [self.collectionView registerClass:InkeCollectionViewCell.class forCellWithReuseIdentifier:InkeCollectionViewCell.className];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)loadData {
    //@"http://live.9158.com/Room/GetNewRoomOnline?page=%ld"
    NSString *url = @"http://live.9158.com/Room/GetNewRoomOnline";
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    req.HTTPMethod = @"GET";
    NSURLSession *session = [NSURLSession sharedSession];
    HFWeak(self)
    NSURLSessionTask *task = [session dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        weakself.model = [InkeModel modelWithJSON:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself.collectionView reloadData];
        });
    }];
    [task resume];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    InkeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:InkeCollectionViewCell.className forIndexPath:indexPath];
    cell.model = self.model.data.list[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.data.list.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PlayerViewController *ctrl = [PlayerViewController new];
    ctrl.model = self.model.data.list[indexPath.row];
    [self.navigationController pushViewController:ctrl animated:YES];
}


@end
