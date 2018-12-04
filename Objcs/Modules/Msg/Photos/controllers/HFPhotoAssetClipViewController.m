//
//  HFPhotoAssetClipViewController.m
//  Objcs
//
//  Created by wff on 2018/11/30.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "HFPhotoAssetClipViewController.h"
#import "HFToolBarView.h"
#import "YasicClipAreaLayer.h"
#import "YasicPanGestureRecognizer.h"

@interface HFPhotoAssetClipViewController ()

@property(assign,nonatomic) UIImageOrientation orientation;
/**显示imageView*/
@property(strong,nonatomic) UIImageView *editedImageView;
/**初始frame*/
@property(assign,nonatomic) CGRect originalFrame;
@property(strong,nonatomic) UIView *cropView;

//裁剪区域
@property(assign,nonatomic) CGFloat cropAreaX;
@property(assign,nonatomic) CGFloat cropAreaY;
@property(assign,nonatomic) CGFloat cropAreaWidth;
@property(assign,nonatomic) CGFloat cropAreaHeight;

@end

@implementation HFPhotoAssetClipViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self cropViewLayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setupView];
    [self addGesture];
}

- (UIView *)cropView{
    if (!_cropView) {
        _cropView = [[UIView alloc] init];
    }
    return _cropView;
}

- (void)setupView {
    //计算裁剪区域
    self.cropAreaX = 0;
    self.cropAreaY = kScreenHeight/2 - [_editedImage imageSize].height/2;
    self.cropAreaWidth = [_editedImage imageSize].width;
    self.cropAreaHeight = [_editedImage imageSize].height;
    
    //显示imageView
    _editedImageView = [[UIImageView alloc] initWithImage:_editedImage];
    _editedImageView.size = CGSizeMake([_editedImage imageSize].width, [_editedImage imageSize].height);
    _editedImageView.center = self.view.center;
    [self.view addSubview:_editedImageView];
    _originalFrame = _editedImageView.frame;
    
    //
    [self.view addSubview:self.cropView];
    [self.cropView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.mas_equalTo(-60);
    }];
    
    HFWeak(self)
    HFToolBarView *shadowView = [[HFToolBarView alloc]
                                 initWithFrame:CGRectMake(0, kScreenHeight-50, kScreenWidth, 50)
                                 titles:@[@"取消",@"旋转",@"还原",@"完成"]
                                 touchBlock:^(NSInteger tag) {
                                     [weakself toolBarClick:tag];
                                 }];
    [self.view addSubview:shadowView];
}

/**
 手势：图片捏合手势、裁剪区域拖动手势
 */
-(void)addGesture{
    // 捏合手势
    UIPinchGestureRecognizer *pinGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    [self.view addGestureRecognizer:pinGesture];
    
    // 拖动手势
    YasicPanGestureRecognizer *panGesture = [[YasicPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:) inview:self.cropView];
    [self.cropView addGestureRecognizer:panGesture];
}

/**
 图片捏合手势
 */
- (void)handlePinchGesture:(UIPinchGestureRecognizer *)ges {
    
}

/**
 裁剪区域拖动手势
 */
- (void)handlePanGesture:(YasicPanGestureRecognizer *)ges {
    
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
        [self resetImageView];
    } else {
        //完成
        if (_editedImageBlock) {
            _editedImageBlock(_editedImageView.image);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)cropViewLayer {
    self.cropView.layer.sublayers = nil;
    YasicClipAreaLayer * layer = [[YasicClipAreaLayer alloc] init];
    
    CGRect cropframe = CGRectMake(self.cropAreaX, self.cropAreaY, self.cropAreaWidth, self.cropAreaHeight);
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.cropView.frame cornerRadius:0];
    UIBezierPath * cropPath = [UIBezierPath bezierPathWithRect:cropframe];
    [path appendPath:cropPath];
    layer.path = path.CGPath;
    
    layer.fillRule = kCAFillRuleEvenOdd;
    layer.fillColor = [[UIColor blackColor] CGColor];
    layer.opacity = 0.5;
    
    layer.frame = self.cropView.bounds;
    [layer setCropAreaLeft:self.cropAreaX CropAreaTop:self.cropAreaY CropAreaRight:self.cropAreaX + self.cropAreaWidth CropAreaBottom:self.cropAreaY + self.cropAreaHeight];
    [self.cropView.layer addSublayer:layer];
}

/**
 还原 重置
 */
- (void)resetImageView {
    self.editedImageView.image = _editedImage;
    self.editedImageView.frame = _originalFrame;
    self.editedImageView.center = self.view.center;
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
    self.editedImageView.image = [self.editedImageView.image imageRotate:UIImageOrientationLeft];
    
    //imageView更改frame
    CGRect frame = self.editedImageView.frame;
    if (_orientation ==  UIImageOrientationLeft || _orientation == UIImageOrientationRight) {
        self.editedImageView.size = CGSizeMake(frame.size.height, frame.size.width);
    } else {
        self.editedImageView.size = CGSizeMake(_originalFrame.size.width, _originalFrame.size.height);
    }
    self.editedImageView.center = self.view.center;
    
    //更新裁剪区域
    self.cropAreaX = kScreenWidth/2 - self.editedImageView.centerX/2;
    self.cropAreaY = kScreenHeight/2 - self.editedImageView.origin.y;
    self.cropAreaWidth = self.editedImageView.width;
    self.cropAreaHeight = self.editedImageView.height;
}

@end
