//
//  HFBaseCollectionViewController.m
//  HF_Client_iPhone_Application
//
//  Created by header on 2018/9/25.
//  Copyright © 2018年 HengFeng. All rights reserved.
//

#import "HFBaseCollectionViewController.h"

@interface HFBaseCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation HFBaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSMutableArray *)datas{
    if (!_datas) {
        _datas = [[NSMutableArray alloc] init];
    }
    return _datas;
}

- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _layout;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
    }
    return _collectionView;
}

- (void)layoutWithItemSize:(CGSize)itemSize
                     inset:(UIEdgeInsets)inset
                   spacing:(CGFloat)spacing {
    self.layout.itemSize = itemSize;
    self.layout.sectionInset = inset;
    [self.layout setMinimumInteritemSpacing:spacing];
    [self.layout setMinimumLineSpacing:spacing];
}

- (void)deselectedItemsWithCurIndexPath:(NSIndexPath *_Nullable)indexPath {
    NSArray <NSIndexPath *> *items = self.collectionView.indexPathsForSelectedItems;
    for (NSIndexPath *sec in items) {
        if ([sec compare:indexPath] != NSOrderedSame) {
            [self.collectionView deselectItemAtIndexPath:sec animated:YES];
        }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

@end
