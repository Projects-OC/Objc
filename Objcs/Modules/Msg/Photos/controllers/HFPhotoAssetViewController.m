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
#import "HFToolBarBorderView.h"
#import "HFPhotoAssetToolBarView.h"
#import "HFPhotoAssetModel.h"

static NSInteger const maxImagesCount = 4;

@interface HFPhotoAssetViewController ()<UIPopoverPresentationControllerDelegate>

@property (nonatomic,strong) UIButton *bottomBtn;

@property (nonatomic,strong) HFTitleView *titleView;
@property (nonatomic,strong) HFPhotoAssetPopoverPrensentController *popover;
@property (nonatomic,strong) HFPhotoAssetManager *assetManager;

@property (nonatomic,strong) NSMutableArray <HFPhotoAssetModel *> *assetModels;
@property (nonatomic,strong) NSMutableArray <HFPhotoAssetModel *> *selectAssetModels;
@property (nonatomic,strong) NSMutableArray <UIImage *> *uploadImages;

@end

@implementation HFPhotoAssetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configLayout];
    [self setupView];
    [self sysfetchPhotos];
    self.navigationItem.titleView = self.titleView;
    
    [self addObserver:self forKeyPath:[self stringFromSelector] options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

/**
 KVO监听数组变化，add,remove使用此方法代替
 */
- (id)mutableValueForKey {
    return [self mutableArrayValueForKey:[self stringFromSelector]];
}

- (NSString *)stringFromSelector {
    return NSStringFromSelector(@selector(selectAssetModels));
}

- (void)configLayout{
    NSInteger num = self.assetManager.lineNum;
    CGFloat padding = 12;
    CGFloat minW=MIN(kScreenWidth, kScreenHeight);
    CGFloat itemWH = (minW - (num + 1) * padding) / num;
    [self layoutWithItemSize:CGSizeMake(itemWH, itemWH)
                       inset:UIEdgeInsetsMake(padding, padding, padding, padding)
                     spacing:padding];
    
    self.collectionView.allowsMultipleSelection = YES;
    [self.collectionView registerClass:[HFPhotoAssetCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HFPhotoAssetCollectionViewCell class])];
    [self.collectionView registerClass:[HFPhotoAssetCameraCell class]
            forCellWithReuseIdentifier:NSStringFromClass([HFPhotoAssetCameraCell class])];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 16*2 + 50, 0));
    }];
}

- (void)setupView {
    __weak typeof(self) weakself = self;
    HFToolBarBorderView *_toolBar = [[HFToolBarBorderView alloc] initWithTitles:@[@"上屏"]
                                                                     textColors:@[[UIColor whiteColor]]
                                                                     backColors:@[[UIColor redColor]]
                                                                       isBorder:YES
                                                                       tapBlock:^(NSInteger tag) {
                                                                           [weakself uploadClick];
                                                                       }];
    [self.view addSubview:_toolBar];
    [_toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(82);
        make.bottom.equalTo(self.view).offset(-10);
    }];
    _bottomBtn = _toolBar.btns.firstObject;
    [self unenableBtn];
    
    self.navigationItem.titleView = self.titleView;
}

/**
 标题
 */
- (HFTitleView *)titleView {
    if (!_titleView) {
        __weak typeof(self) weakself = self;
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

- (void)sysfetchPhotos {
    __weak typeof(self) weakself = self;
    [self.assetManager albumsAuthorizationStatus:^(BOOL status) {
        if (status) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [weakself.assetManager getPhotosWithCompletion:^{
                    [weakself recoverAssetModels];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakself.collectionView reloadData];
                        [weakself updateTitleWithAlbumIndex:0];
                    });
                }];
            });
        }}];
    self.assetManager.imagePickerFinishBlock = ^{
        [weakself.collectionView reloadData];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [weakself.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        [weakself enableBtn];
    };
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

- (void)recoverAssetModels {
    [self.selectAssetModels removeAllObjects];
    
    if (self.assetModels.count > 0) {
        [self.assetManager.albumImages enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
            HFPhotoAssetModel *model = self.assetModels[idx];
            model.isGrayImage = NO;
            self.assetModels[idx] = model;
        }];
    } else {
        [self.assetManager.albumAssets enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HFPhotoAssetModel *model = [HFPhotoAssetModel new];
            model.index = idx;
            [self.assetModels addObject:model];
        }];
    }
}

- (NSMutableArray <HFPhotoAssetModel *> *)assetModels {
    if (!_assetModels) {
        _assetModels = [NSMutableArray new];
    }
    return _assetModels;
}

- (NSMutableArray <HFPhotoAssetModel *> *)selectAssetModels {
    if (!_selectAssetModels) {
        _selectAssetModels = [NSMutableArray new];
    }
    return _selectAssetModels;
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
        __weak typeof(self) weakself = self;
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
    if (indexPath.row == 0) {
        HFPhotoAssetCameraCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HFPhotoAssetCameraCell class]) forIndexPath:indexPath];
        return cell;
    }
    
    HFPhotoAssetCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HFPhotoAssetCollectionViewCell class]) forIndexPath:indexPath];
    [cell.imgView setImage:[UIImage imageNamed:@"rj_placeholderImage"]];
    cell.contentView.tag = indexPath.row;
    
    if (self.assetManager.albumImages.count > indexPath.row-1) {
        [cell.imgView setImage:self.assetManager.albumImages[indexPath.row -1]];
    } else if (self.assetManager.albumAssets.count > indexPath.row-1) {
        //            imgCell.asset = self.assetManager.albumAssets[indexPath.row -1];
    }
    if (self.assetModels.count == self.assetManager.albumAssets.count) {
        HFPhotoAssetModel *assetModel = self.assetModels[indexPath.row -1];
        cell.assetModel = assetModel;
    }
    
    __weak typeof(self) weakself = self;
    cell.singleTapBlock = ^(NSInteger index) {
        [weakself singleTapClickIndex:indexPath.row];
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //拍照
    if (indexPath.row == 0) {
        if (self.selectAssetModels.count == maxImagesCount) {
            return;
        }
        [self.assetManager cameraAuthorizationStatus];
        return;
    }
    HFPhotoAssetModel *model = self.assetModels[indexPath.row -1];
    if (model.isGrayImage) {
        return;
    }
    [self imageBrowserWithIndexPath:indexPath];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger items = self.collectionView.indexPathsForSelectedItems.count;
    if (items > maxImagesCount -1) {
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
        HFPhotoAssetModel *assetModel = self.assetModels[idx];
        if (isGray) {
            if (assetModel.isMarked) {
                assetModel.isGrayImage = NO;
            } else {
                assetModel.isGrayImage = YES;
            }
        } else {
            assetModel.isGrayImage = NO;
        }
        self.assetModels[idx] = assetModel;
    }];
    
    [UIView performWithoutAnimation:^{
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    }];
}

/**
 cell单击事件
 */
- (void)singleTapClickIndex:(NSInteger)index {
    if (index == 0) {
        return;
    }
    
    // 最多选4个，筛选出当前index，是否在选中的图片中（当选中4个后，其他没选中的不能点击）
    NSArray *isContainSelected = [self.selectAssetModels filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"index == %ld",index -1]];
    if (self.selectAssetModels.count == maxImagesCount && isContainSelected.count == 0) {
        return;
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    HFPhotoAssetCollectionViewCell *cell = (HFPhotoAssetCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    HFPhotoAssetModel *assetModel = self.assetModels[index -1];
    assetModel.isMarked = !assetModel.isMarked;
    self.assetModels[index -1] = assetModel;
    // mf
    if ([self.selectAssetModels containsObject:assetModel]) {
        [[self mutableValueForKey] removeObject:assetModel];
        if (self.selectAssetModels.count == 3) {
            [self imageIsGray:NO];
        }
    } else {
        [[self mutableValueForKey] addObject:assetModel];
    }
    
    cell.assetModel = assetModel;
    
    [self.assetModels enumerateObjectsUsingBlock:^(HFPhotoAssetModel * _Nonnull model, NSUInteger i, BOOL * _Nonnull stop) {
        [self.selectAssetModels enumerateObjectsUsingBlock:^(HFPhotoAssetModel * _Nonnull selectModel, NSUInteger j, BOOL * _Nonnull selectStop) {
            if (model.index == selectModel.index) {
                model.id = j;
            }
        }];
    }];
    if (self.selectAssetModels.count == 4) {
        [self imageIsGray:YES];
    } else {
        [UIView performWithoutAnimation:^{
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        }];
    }
    
    
    return;
    
    NSArray *filters = [self.assetModels filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"isMarked == YES"]];
    if (filters.count == maxImagesCount) {
        // 选择了四个选项
        [self imageIsGray:YES];
    }
    else if (self.selectAssetModels.count -1 == maxImagesCount -1) {
        // 从四个减少到3个
        [self imageIsGray:NO];
    }
    else {
        cell.assetModel = assetModel;
    }
    self.selectAssetModels = filters;
    
    [self.assetModels enumerateObjectsUsingBlock:^(HFPhotoAssetModel * _Nonnull model, NSUInteger i, BOOL * _Nonnull stop) {
        
        [self.selectAssetModels enumerateObjectsUsingBlock:^(HFPhotoAssetModel * _Nonnull selectModel, NSUInteger j, BOOL * _Nonnull selectStop) {
            if (model.index == selectModel.index) {
                
            }
        }];
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
}

/**
 切换相册的图片
 */
- (void)updateAlbumsWithIndex:(NSInteger)index {
    if (self.assetManager.currentAlbumsIndex == index) {
        return;
    }
    __weak typeof(self) weakself = self;
    [self.assetManager updateAlbumsWithIndex:index completion:^{
        [weakself.collectionView reloadData];
    }];
    
    [self recoverAssetModels];
}
// mf
- (void)observeSelectAssetModels {
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *title = [NSString stringWithFormat:@"确定（%ld/4）",weakself.selectAssetModels.count];
        [weakself.bottomBtn setTitle:title forState:UIControlStateNormal];
        if (weakself.selectAssetModels.count == 0) {
            [weakself unenableBtn];
        } else {
            [weakself enableBtn];
        }
    });
}

- (void)enableBtn {
    _bottomBtn.backgroundColor = [UIColor greenColor];
    _bottomBtn.enabled = YES;
}

- (void)unenableBtn {
    _bottomBtn.backgroundColor = [UIColor grayColor];
    _bottomBtn.enabled = NO;
}

/**
 及时展示-图片浏览逻辑
 */
- (void)imageBrowserWithIndexPath:(NSIndexPath *)indexPath {
    PHAsset *asset = self.assetManager.albumAssets[indexPath.row -1];
    // PHAsset转IMAGE，已修改为同步获取
    [[HFPhotoAssetManager sharedInstance] getPhotoWithAsset:asset
                                                 completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
                                                     if (!isDegraded) {
                                                     }
                                                 }];
}

/**
 上屏
 */
- (void)uploadClick {
    //    NSArray <NSIndexPath *> *items = self.collectionView.indexPathsForSelectedItems;
    //    NSIndexPath *indexPath = items.firstObject;
    //    if (items.count == 0 || indexPath.row == 0) {
    //        return;
    //    }
    NSArray *items = self.selectAssetModels;
    if (items.count == 0) {
        return;
    }
    
   
    __weak typeof(self) weakself = self;

    _uploadImages = [NSMutableArray arrayWithCapacity:4];
    for (HFPhotoAssetModel *model in items) {
        PHAsset *asset = self.assetManager.albumAssets[model.index];
        // PHAsset转IMAGE，已修改为同步获取
        [[HFPhotoAssetManager sharedInstance] getPhotoWithAsset:asset
                                                     completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
                                                         if (!isDegraded) {
                                                             [weakself.uploadImages addObject:photo];
                                                         }
                                                     }];
    }
    
    if (self.uploadImages.count == 0) {
        return;
    }
 
    NSLog(@"文件都已上传完成");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:[self stringFromSelector]]) {
        [self observeSelectAssetModels];
    }
}


#pragma mark popoverPrensentaion⤵️
/**
 pop弹窗
 */
- (void)titleBtnClick:(UIButton *)sender {
    self.popover.selectTitle = self.titleView.titleBtn.titleLabel.text;
    __weak typeof(self) weakself = self;
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
    // mf
    [self removeObserver:self forKeyPath:[self stringFromSelector]];
}

@end
