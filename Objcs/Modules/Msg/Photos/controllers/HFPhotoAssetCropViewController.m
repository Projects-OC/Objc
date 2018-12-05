//
//  HFPhotoAssetCropViewController.m
//  Objcs
//
//  Created by wff on 2018/12/5.
//  Copyright © 2018 mf. All rights reserved.
//

#import "HFPhotoAssetCropViewController.h"
#import "TKImageView.h"
#import "HFToolBarView.h"

@interface HFPhotoAssetCropViewController ()

@property (nonatomic,strong) TKImageView *tkImageView;

@property(assign,nonatomic) UIImageOrientation orientation;

/**裁剪区域*/
@property(assign,nonatomic) CGRect cropRect;
/**初始frame*/
@property(assign,nonatomic) CGRect originalFrame;

@end

@implementation HFPhotoAssetCropViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //计算裁剪区域
    self.cropRect = CGRectMake(kScreenWidth/2 - [_editedImage imageSize].width/2,
                               kScreenHeight/2 - [_editedImage imageSize].height/2,
                               [_editedImage imageSize].width,
                               [_editedImage imageSize].height);
    self.originalFrame = self.cropRect;
    
    [self setupTKImageView];
    [self setupToolBarView];
}

- (void)setupToolBarView {
    HFWeak(self)
    HFToolBarView *shadowView = [[HFToolBarView alloc]
                                 initWithFrame:CGRectMake(0, kScreenHeight-50, kScreenWidth, 50)
                                 titles:@[@"取消",@"旋转",@"还原",@"完成"]
                                 touchBlock:^(NSInteger tag) {
                                     [weakself toolBarClick:tag];
                                 }];
    [self.view addSubview:shadowView];
}

- (void)setupTKImageView {
    _tkImageView = [[TKImageView alloc] initWithFrame:self.view.bounds];
    _tkImageView.contentMode = UIViewContentModeScaleToFill;
    _tkImageView.toCropImage = self.editedImage;
    _tkImageView.showMidLines = NO;
    _tkImageView.needScaleCrop = YES;
    _tkImageView.showCrossLines = YES;
    _tkImageView.cornerBorderInImage = NO;
    _tkImageView.cropAreaCornerWidth = 44;
    _tkImageView.cropAreaCornerHeight = 44;
    _tkImageView.minSpace = 30;
    _tkImageView.cropAreaCornerLineColor = [UIColor whiteColor];
    _tkImageView.cropAreaBorderLineColor = [UIColor whiteColor];
    _tkImageView.cropAreaCornerLineWidth = 6;
    _tkImageView.cropAreaBorderLineWidth = 4;
    _tkImageView.cropAreaMidLineWidth = 20;
    _tkImageView.cropAreaMidLineHeight = 6;
    _tkImageView.cropAreaMidLineColor = [UIColor whiteColor];
    _tkImageView.cropAreaCrossLineColor = [UIColor whiteColor];
    _tkImageView.cropAreaCrossLineWidth = 4;
    _tkImageView.initialScaleFactor = .8f;
    _tkImageView.cropAspectRatio = self.cropRect.size.width/self.cropRect.size.height;
    [self.view addSubview:_tkImageView];
}

- (void)toolBarClick:(NSInteger)tag {
    if (tag == 0) {
        //取消
        [self.navigationController popViewControllerAnimated:YES];
    } else if (tag == 1) {
        //旋转
        [self rotatingImage];
    } else if (tag == 2) {
        //还原
//        [self resetImageView];
    } else {
        //完成
        if (_editedImageBlock) {
            _editedImageBlock([_tkImageView currentCroppedImage]);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 图片旋转
 */
- (void)rotatingImage {
    if (_orientation == UIImageOrientationUp) {
        // 图片向 左 旋转 ⬅️
        _orientation = UIImageOrientationLeft;
    }
    else if (_orientation == UIImageOrientationLeft) {
        // 下 ⤵️
        _orientation = UIImageOrientationDown;
    }
    else if (_orientation == UIImageOrientationDown) {
        // 右 ➡️
        _orientation = UIImageOrientationRight;
    }
    else if (_orientation == UIImageOrientationRight) {
        // 恢复到 原位置 上 ⬆️
        _orientation = UIImageOrientationUp;
    }
    //image旋转方向
    _tkImageView.toCropImage = [_tkImageView.toCropImage imageRotateOrientation:UIImageOrientationLeft];
    
    //imageView更改frame
    CGRect frame = _tkImageView.frame;
    if (_orientation ==  UIImageOrientationLeft || _orientation == UIImageOrientationRight) {
        _tkImageView.size = CGSizeMake(frame.size.height, frame.size.width);
    } else {
        _tkImageView.size = CGSizeMake(_originalFrame.size.width, _originalFrame.size.height);
    }
    _tkImageView.center = self.view.center;
    
    //更新裁剪区域
    self.cropRect = _tkImageView.frame;
    _tkImageView.cropAspectRatio = self.cropRect.size.width/self.cropRect.size.height;
}

@end
