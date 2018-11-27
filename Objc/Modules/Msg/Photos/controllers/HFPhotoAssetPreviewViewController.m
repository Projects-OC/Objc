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
#import "HFToolBarView.h"

@interface HFPhotoAssetPreviewViewController ()

@property (nonatomic,strong) UIImage *photo;//原始图
@property (nonatomic,strong) UIImageView *imageView;

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
             weakself.photo = photo;
             [weakself updateImageViewWithImage:photo];
         }
     }];
    
    HFToolBarView *_toolBar = [[HFToolBarView alloc] initWithTitles:@[@"编辑照片",@"上屏"]
                                                         textColors:@[[UIColor greenColor],[UIColor whiteColor]]
                                                         backColors:@[[UIColor whiteColor],[UIColor greenColor]]
                                                           isBorder:YES
                                                           tapBlock:^(NSInteger tag) {

                                                           }];
    [self.view addSubview:_toolBar];
    [_toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(82);
        make.bottom.mas_equalTo(-LCSafeBottomMargin);
    }];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.center = self.view.center;
    }
    return _imageView;
}

- (void)updateImageViewWithImage:(UIImage *)image {
    self.imageView.image = image;
    CGFloat y = (self.view.frame.size.height - [image imageSize].height)/2;
    self.imageView.frame = CGRectMake(0, y, [image imageSize].width, [image imageSize].height);
    self.imageView.center = CGPointMake(kScreenWidth/2, (CGRectGetHeight(self.view.frame)-64)/2);
}

- (void)dealloc {
    
}

@end
