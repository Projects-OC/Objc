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

@interface HFPhotoAssetViewController ()<UIPopoverPresentationControllerDelegate>

@property (nonatomic,strong) HFTitleView *titleView;

@property (nonatomic,strong) HFPhotoAssetPopoverPrensentController *popover;
@property (nonatomic,strong) HFPhotoAssetManager *assetManager;

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
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, LCSafeBottomMargin + 70 ,0));
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //拍照
    if (indexPath.row == 0) {
        [self deselectedItemsWithCurIndexPath:nil];
        [self.assetManager cameraAuthorizationStatus];
    }
    
    //选择图片
    else {
        [self deselectedItemsWithCurIndexPath:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.collectionView.indexPathsForSelectedItems.count == 0) {
    }
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //新增拍照站位
    return self.assetManager.albumAssets.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HFPhotoAssetCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HFPhotoAssetCollectionViewCell class]) forIndexPath:indexPath];
    [cell.img setImage:[UIImage imageNamed:@"rj_placeholderImage"]];
    cell.contentView.tag = indexPath.row;
    
    HFWeak(self)
    cell.doubleTapBlock = ^(NSInteger index) {
        [weakself doubleTapClickWithIndex:index];
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    HFPhotoAssetCollectionViewCell *imgCell = (HFPhotoAssetCollectionViewCell *)cell;
    if (indexPath.row == 0) {
        imgCell.img.image = [UIImage imageNamed:@"拍照"];
        imgCell.img.contentMode = UIViewContentModeCenter;
        imgCell.layer.borderColor = [UIColor greenColor].CGColor;
        imgCell.layer.borderWidth = 0.5;
    } else {
        if (self.assetManager.albumImages.count > indexPath.row-1) {
            [imgCell.img setImage:self.assetManager.albumImages[indexPath.row -1]];
        } else if (self.assetManager.albumAssets.count > indexPath.row-1) {
            imgCell.asset = self.assetManager.albumAssets[indexPath.row -1];
        }
        imgCell.img.contentMode = UIViewContentModeScaleAspectFill;
    }
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
