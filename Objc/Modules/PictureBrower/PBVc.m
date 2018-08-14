//
//  PictureBrowerVc.m
//  Object-CDemo
//
//  Created by Mac on 2018/3/26.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "PBVc.h"
#import "BCell.h"
#import "PictureBrowser.h"

#define CellImageSize (LCScreenWidth - 2 * 5)/ 3.0

@interface PBVc ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray   *imageDataArray;

@property (nonatomic, strong) NSMutableArray   *pictureImageViews;
@property (nonatomic, strong) PictureBrowserInteractiveAnimatedTransition *animatedTransition;

@end

@implementation PBVc

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.navigationController.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initImageData];
    
    [self.view addSubview:self.collectionView];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
        flowLayout.minimumLineSpacing = 5;
        flowLayout.minimumInteritemSpacing = 5;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, LCScreenWidth, kScreenHeight - 64) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        [_collectionView registerClass:[BCell class] forCellWithReuseIdentifier:NSStringFromClass([BCell class])];
    }
    return _collectionView;
}

- (void)initImageData{
    _imageDataArray = [NSMutableArray array];
    for (int i = 1; i <= 11; i ++) {
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"Expression%.2d",i] ofType:@"jpeg"];
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        NSDictionary *imgDic = @{@"image" : img,
                                 //@"imgUrl" : [NSString stringWithFormat:@"https://xxx.jpg",i],
                                 //@"imgUrl_thumb" : [NSString stringWithFormat:@"https://xxx_thumb.jpg",i]
                                 };
        [_imageDataArray addObject:imgDic];
    }
    for (int i = 1; i <= 11; i ++) {
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"Expression%.2d",i] ofType:@"jpeg"];
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        NSDictionary *imgDic = @{@"image" : img,
                                 //@"imgUrl" : [NSString stringWithFormat:@"https://xxx.jpg",i],
                                 //@"imgUrl_thumb" : [NSString stringWithFormat:@"https://xxx_thumb.jpg",i]
                                 };
        [_imageDataArray addObject:imgDic];
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageDataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = _imageDataArray[indexPath.row];
    BCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BCell class]) forIndexPath:indexPath];
    cell.imageView.image = dic[@"image"];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CellImageSize, CellImageSize);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BCell * cell = (BCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    
    NSInteger index = indexPath.row;
    
    //封装参数对象
    PictureBrowserTransitionParameter *transitionParameter = [[PictureBrowserTransitionParameter alloc] init];
    transitionParameter.transitionImage = cell.imageView.image;
    transitionParameter.firstVCImgFrames = [self firstImageViewFrames];
    transitionParameter.transitionImgIndex = index;
    self.animatedTransition = nil;
    self.animatedTransition.transitionParameter = transitionParameter;
    
    //传输必要参数
    PictureBrowserViewController *pictVC = [[PictureBrowserViewController alloc] init];
    pictVC.dataSouceArray = [self browseSouceModelItemArray];
    pictVC.animatedTransition = self.animatedTransition;
    
    //设置代理
    pictVC.transitioningDelegate = self.animatedTransition;
    [self presentViewController:pictVC animated:YES completion:nil];
    
    
    //    ///无交互动画方式
    //    LYPictureBrowseViewController *pictVC = [[LYPictureBrowseViewController alloc] init];
    //    pictVC.dataSouceArray = [self browseSouceModelItemArray];
    //    [self presentViewController:pictVC animated:YES completion:nil];
}

- (PictureBrowserInteractiveAnimatedTransition *)animatedTransition{
    if (!_animatedTransition) {
        _animatedTransition = [[PictureBrowserInteractiveAnimatedTransition alloc] init];
    }
    return _animatedTransition;
}

- (NSMutableArray *)pictureImageViews {
    if (!_pictureImageViews) {
        _pictureImageViews = [[NSMutableArray alloc] init];
    }
    return _pictureImageViews;
}

#pragma mark - Custom
//构造图片Frame数组
- (NSArray<NSValue *> *)firstImageViewFrames{
    NSMutableArray *imageFrames = [NSMutableArray new];
    for (int i = 0; i < _imageDataArray.count; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        BCell * cell = (BCell *)[_collectionView cellForItemAtIndexPath:indexPath];
        if (cell.imageView) {
            //获取当前view在Window上的frame
            CGRect frame = [self getFrameInWindow:cell.imageView];
            [imageFrames addObject:[NSValue valueWithCGRect:frame]];
        }else{//当前不可见的cell,frame设为CGRectZero添加到数组中,防止数组越界
            CGRect frame = CGRectZero;
            [imageFrames addObject:[NSValue valueWithCGRect:frame]];
        }
    }
    return imageFrames;
}

//构造图片模型数组
- (NSArray<PictureBrowserSouceModel *> *)browseSouceModelItemArray{
    NSMutableArray *models = [NSMutableArray new];
    for (NSDictionary *imgDic in self.imageDataArray) {
        PictureBrowserSouceModel *model = [[PictureBrowserSouceModel alloc] init];
        model.imgUrl = imgDic[@"imgUrl"];
        model.imgUrl_thumb = imgDic[@"imgUrl_thumb"];
        model.image = imgDic[@"image"];
        [models addObject:model];
    }
    return models;
}

// 获取指定视图在window中的位置
- (CGRect)getFrameInWindow:(UIView *)view{
    return [view.superview convertRect:view.frame toView:nil];
}

@end
