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
#import "LFPhotoEditingController.h"

@interface HFPhotoAssetPreviewViewController ()<LFPhotoEditingControllerDelegate>

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,assign) CGSize clipImageSize;

@end

@implementation HFPhotoAssetPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"查看照片";
    [self.view addSubview:self.imageView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(pushCtrl)];

    HFWeak(self)
    [[HFPhotoAssetManager sharedInstance]
     getPhotoWithAsset:_asset
     completion:^(UIImage *image, NSDictionary *info, BOOL isDegraded) {
         if (!isDegraded) {
             [weakself setupViewImage:image];
         }
     }];
}

- (void)setupViewImage:(UIImage *)image {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage imageWithCGImage:image.CGImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    [self.view addSubview:imageView];
    [imageView startAnimating];
    
    _imageView = imageView;
}

- (void)pushCtrl {
    LFPhotoEditingController *lfPhotoEditVC = [[LFPhotoEditingController alloc] init];
    lfPhotoEditVC.operationType = LFPhotoEditOperationType_draw | LFPhotoEditOperationType_crop;
    lfPhotoEditVC.delegate = self;
    lfPhotoEditVC.editImage = self.imageView.image;
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:lfPhotoEditVC animated:NO];
}

-  (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
}

#pragma mark - LFPhotoEditingControllerDelegate
- (void)lf_PhotoEditingController:(LFPhotoEditingController *)photoEditingVC didCancelPhotoEdit:(LFPhotoEdit *)photoEdit
{
    [self.navigationController popViewControllerAnimated:NO];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)lf_PhotoEditingController:(LFPhotoEditingController *)photoEditingVC didFinishPhotoEdit:(LFPhotoEdit *)photoEdit
{
    [self.navigationController popViewControllerAnimated:NO];
    [self.navigationController setNavigationBarHidden:NO];
    if (!photoEdit) {
        return;
    }
    self.imageView.image = photoEdit.editPreviewImage;
}

@end
