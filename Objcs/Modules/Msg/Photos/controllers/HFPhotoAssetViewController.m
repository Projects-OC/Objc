//
//  HFPhotoAssetViewController.m
//  PhotoKit
//
//  Created by header on 2018/9/18.
//  Copyright © 2018年 header. All rights reserved.
//

#import "HFPhotoAssetViewController.h"
#import "HFPhotoAssetCollectionViewCell.h"
#import "HFPhotoAssetManager.h"
#import "HFPhotoAssetPopoverPrensentController.h"
#import "HFPhotoAssetPreviewViewController.h"
#import <Photos/Photos.h>
#import "HFTitleView.h"
#import "HFPhotoAssetToolBarView.h"
#import "HFPhotoAssetModel.h"

static NSInteger const selectedMax = 4;

@interface HFPhotoAssetViewController ()<UIPopoverPresentationControllerDelegate>

@property (nonatomic,strong) HFTitleView *titleView;

@property (nonatomic,strong) HFPhotoAssetPopoverPrensentController *popover;
@property (nonatomic,strong) HFPhotoAssetManager *assetManager;
@property (nonatomic,strong) HFPhotoAssetToolBarView *toolBarView;

@property (nonatomic,strong) NSMutableArray <HFPhotoAssetModel *> *assetModels;

@end

@implementation HFPhotoAssetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configLayout];
    [self sysfetchResult];
    self.navigationItem.titleView = self.titleView;
}


/**
 标题
 */
- (HFTitleView *)titleView {
    if (!_titleView) {
        HFWeak(self)
        _titleView = [[HFTitleView alloc] initWithTitle:@"最近添加"];
        _titleView.intrinsicContentSize = CGSizeMake(kScreenWidth/2, 40);
//        [_titleView addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
//            [weakself titleBtnClick:weakself.titleView.titleBtn];
//        }];
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            [weakself titleBtnClick:weakself.titleView.titleBtn];
        }];
        [_titleView addGestureRecognizer:ges];
    }
    return _titleView;
}

- (void)sysfetchResult {
    HFWeak(self)
    [self.assetManager albumsAuthorizationStatus:^(BOOL power) {
        if (power) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [weakself.assetManager getPhotosWithCompletion:^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakself.collectionView reloadData];
                        [weakself updateTitleWithAlbumIndex:0];
                    });
                }];
            });
        }
    }];
    self.assetManager.imagePickerFinishBlock = ^{
        [weakself.collectionView reloadData];
    };
}

- (void)configLayout{
    NSInteger num = self.assetManager.lineNum;
    CGFloat padding = 12;
    CGFloat itemWH = (self.view.frame.size.width - (num + 1) * padding) / num;
    [self layoutWithItemSize:CGSizeMake(itemWH, itemWH)
                       inset:UIEdgeInsetsMake(padding, padding, padding, padding)
                     spacing:padding];
    
    self.collectionView.allowsMultipleSelection = YES;
    [self.collectionView registerClass:[HFPhotoAssetCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HFPhotoAssetCollectionViewCell class])];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

//更新标题
- (void)updateTitleWithAlbumIndex:(NSInteger)index {
    if (self.assetManager.albums.count == 0) {
        return;
    }
    NSDictionary *albumDic = self.assetManager.albums[index];
    NSString *title = [[albumDic allKeys] lastObject];//相册名称
    [self.titleView.titleBtn setTitle:title forState:UIControlStateNormal];
}

- (UIView *)toolBarView {
    if (!_toolBarView) {
        _toolBarView = [HFPhotoAssetToolBarView new];
        [self.view addSubview:_toolBarView];
        [_toolBarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            if (@available(iOS 11.0,*)) {
                make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            } else {
                make.bottom.equalTo(self.view);
            }
            make.height.mas_equalTo(50);
        }];
    }
    return _toolBarView;
}

- (NSMutableArray *)assetModels {
    if (!_assetModels) {
        _assetModels = [NSMutableArray new];
        [_assetManager.albumImages enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HFPhotoAssetModel *model = [HFPhotoAssetModel new];
            [self.assetModels addObject:model];
        }];
    }
    return _assetModels;
}

- (HFPhotoAssetManager *)assetManager {
    if (!_assetManager) {
        _assetManager = [[HFPhotoAssetManager alloc] init];
        _assetManager.lineNum = 4;
    }
    return _assetManager;
}

/**
 弹出框
 */
- (HFPhotoAssetPopoverPrensentController *)popover {
    if (!_popover) {
        HFWeak(self)
        _popover = [[HFPhotoAssetPopoverPrensentController alloc]
                    initWithAlbums:self.assetManager.albums
                    clickBlock:^(NSInteger index) {
                        //切换相册回调
                        [weakself updateAlbumsWithIndex:index];
                        //更新标题
                        [weakself updateTitleWithAlbumIndex:index];
                    }];
    }
    return _popover;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HFPhotoAssetCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HFPhotoAssetCollectionViewCell class]) forIndexPath:indexPath];
    [cell.imgView setImage:[UIImage imageNamed:@"rj_placeholderImage"]];
    cell.contentView.tag = indexPath.row;
    
    HFWeak(self)
    cell.doubleTapBlock = ^(NSInteger index) {
        [weakself doubleTapClickWithIndex:index];
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(HFPhotoAssetCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        cell.imgView.image = [UIImage imageNamed:@"拍照"];
        cell.imgView.contentMode = UIViewContentModeCenter;
        cell.layer.borderColor = [UIColor greenColor].CGColor;
        cell.layer.borderWidth = 0.5;
    } else {
        HFPhotoAssetModel *model = self.assetModels[indexPath.row -1];
        if (self.assetManager.albumImages.count > indexPath.row-1) {
            [cell.imgView setImage:self.assetManager.albumImages[indexPath.row -1]];
        } else if (self.assetManager.albumAssets.count > indexPath.row-1) {
//            imgCell.asset = self.assetManager.albumAssets[indexPath.row -1];
        }
        NSLog(@"indexrow:%d,isgray:%d",indexPath.row,model.isGrayImage);
        cell.isGrayImage = model.isGrayImage;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //拍照
    if (indexPath.row == 0) {
        [self deselectedItemsWithCurIndexPath:nil];
        [self.assetManager cameraAuthorizationStatus];
    }
    
    //选择图片
    else {
        NSInteger items = self.collectionView.indexPathsForSelectedItems.count;
        self.toolBarView.selectCount = items;
        if (items == selectedMax) {
            [self imageIsGray:YES];
        }
//        [self deselectedItemsWithCurIndexPath:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger items = self.collectionView.indexPathsForSelectedItems.count;
    if (items == 0) {
        [self.toolBarView hideSelf];
        self.toolBarView = nil;
    } else {
        if (items == selectedMax -1) {
            // 恢复灰度图片
            [self imageIsGray:NO];
        }
        self.toolBarView.selectCount = items;
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.collectionView.indexPathsForSelectedItems.count > selectedMax -1) {
        return NO;
    } else {
        return YES;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //新增拍照站位
    return self.assetManager.albumAssets.count + 1;
}

/**
 图片灰度
 */
- (void)imageIsGray:(BOOL)isGray {
    [self.assetManager.albumImages enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
        // +1拍照站位
        NSInteger row = idx +1;
        HFPhotoAssetCollectionViewCell *cell = (HFPhotoAssetCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
        if (!cell.isSelected) {
            cell.imgView.image = image;
            cell.isGrayImage = isGray;
        }
        HFPhotoAssetModel *model = self.assetModels[row -1];
        model.isGrayImage = isGray;
        model.index = row-1;
        self.assetModels[row -1] = model;
        NSLog(@"-----%d",model.index);
    }];
}

/**
 cell双击事件
 */
- (void)doubleTapClickWithIndex:(NSInteger)index {
    if (index == 0) {
        return;
    }
    PHAsset *asset = self.assetManager.albumAssets[index - 1];
    HFPhotoAssetPreviewViewController *info = [HFPhotoAssetPreviewViewController new];
    info.asset = asset;
    [self.navigationController pushViewController:info animated:YES];
}

/**
 切换相册的图片
 */
- (void)updateAlbumsWithIndex:(NSInteger)index {
    if (self.assetManager.currentAlbumsIndex == index) {
        return;
    }
    HFWeak(self)
    [self.assetManager updateAlbumsWithIndex:index completion:^{
        [weakself.collectionView reloadData];
    }];
    
    [self.assetManager.albumImages enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
        HFPhotoAssetModel *model = self.assetModels[idx];
        model.isGrayImage = NO;
        self.assetModels[idx] = model;
    }];
}


#pragma mark popoverPrensentaion⤵️
/**
 pop弹窗
 */
- (void)titleBtnClick:(UIButton *)sender {
    self.popover.selectTitle = self.titleView.titleBtn.titleLabel.text;
    HFWeak(self)
    [self.assetManager getAlbumsComletion:^{
        [weakself.popover updateAlbums:weakself.assetManager.albums];
    }];

    self.popover.preferredContentSize = CGSizeMake(200, 200);
    self.popover.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController *popoverPrensent = self.popover.popoverPresentationController;
    popoverPrensent.sourceView = sender;
    popoverPrensent.sourceRect = sender.bounds;
    popoverPrensent.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popoverPrensent.delegate = self;
    [self presentViewController:self.popover animated:YES completion:nil];
}

//点击蒙版是否消失，默认为yes；
- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    return YES;
}

//弹框消失时调用的方法
- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    NSLog(@"弹框已经消失");
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}
#pragma mark popoverPrensentaion⬆️

- (void)dealloc {

}

@end
