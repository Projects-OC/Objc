//
//  HFPhotoAssetInfoViewController.m
//  PhotoKit
//
//  Created by header on 2018/9/19.
//  Copyright © 2018年 header. All rights reserved.
//

#import "HFPhotoAssetPreviewViewController.h"
#import "HFPhotoAssetManager.h"
#import "HFPhotoAssetViewController.h"
#import "UIImage+HF.h"
#import "HFToolBarBorderView.h"
#import "HFPhotoAssetDrawViewController.h"

@interface HFPhotoAssetPreviewViewController ()

@property (nonatomic,strong) UIImage *image;//原始图
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,assign) CGSize clipImageSize;

@end

@implementation HFPhotoAssetPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"查看照片";
    [self.view addSubview:self.imageView];

    HFWeak(self)
    [[HFPhotoAssetManager sharedInstance]
     getPhotoWithAsset:_asset
     completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
         if (!isDegraded) {
             weakself.image = photo;
             weakself.clipImageSize = CGSizeMake([photo imageSize].width, [photo imageSize].height);
             [weakself updateImageSize];
         }
     }];
    
    HFToolBarBorderView *_toolBar = [[HFToolBarBorderView alloc]
                               initWithTitles:@[@"编辑照片",@"上屏"]
                               textColors:@[[UIColor greenColor],[UIColor whiteColor]]
                               backColors:@[[UIColor whiteColor],[UIColor greenColor]]
                               isBorder:YES
                               tapBlock:^(NSInteger tag) {
                                   if (tag == 0) {
                                       [weakself pushCtrl];
                                   }
                               }];
    [self.view addSubview:_toolBar];
    [_toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(82);
        make.bottom.mas_equalTo(0);
    }];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.backgroundColor = [UIColor blackColor];
        _imageView.center = self.view.center;
    }
    return _imageView;
}

- (void)updateImageSize{
    self.imageView.image = _image;
    self.imageView.size = _clipImageSize;
    self.imageView.center = self.view.center;
}

- (void)pushCtrl {
    HFPhotoAssetDrawViewController *ctrl = [HFPhotoAssetDrawViewController new];
    ctrl.editedImage = _image;
    ctrl.clipImageSize = _clipImageSize;
    [self.navigationController pushViewController:ctrl animated:YES];
    HFWeak(self)
    ctrl.editedImageBlock = ^(UIImage *image,CGSize clipImageSize) {
        weakself.image = image;
        weakself.clipImageSize = clipImageSize;
        [weakself updateImageSize];
    };
}

- (void)dealloc {
    
}

@end
