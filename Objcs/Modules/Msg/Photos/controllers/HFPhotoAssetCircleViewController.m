//
//  HFPhotoAssetCircleViewController.m
//  Objcs
//
//  Created by wff on 2018/11/30.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "HFPhotoAssetClipViewController.h"
#import "HFToolBarView.h"

@interface HFPhotoAssetClipViewController ()

@property (nonatomic,strong) UIImageView *editedImageView;

@end

@implementation HFPhotoAssetClipViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setupBottomView];
}

- (void)setupBottomView {
    _editedImageView = [[UIImageView alloc] initWithImage:_editedImage];
    _editedImageView.size = CGSizeMake([_editedImage imageSize].width, [_editedImage imageSize].height);
    _editedImageView.center = self.view.center;
    [self.view addSubview:_editedImageView];
    
    HFWeak(self)
    HFToolBarView *shadowView = [[HFToolBarView alloc]
                                 initWithFrame:CGRectMake(0, kScreenHeight-50, kScreenWidth, 50)
                                 titles:@[@"取消",@"旋转",@"裁剪",@"完成"]
                                 touchBlock:^(NSInteger tag) {
                                     [weakself toolBarClick:tag];
                                 }];
    [self.view addSubview:shadowView];
}

- (void)toolBarClick:(NSInteger)tag {
    if (tag == 0) {
        //取消
        [self.navigationController popViewControllerAnimated:YES];
    } else if (tag == 1) {
        //旋转

    } else if (tag == 2) {
        //裁剪
       
    } else {
        //完成
        if (_editedImageBlock) {
            _editedImageBlock(_editedImageView.image);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 图片旋转
 */
- (void)rotatingImage {
    
}

@end
