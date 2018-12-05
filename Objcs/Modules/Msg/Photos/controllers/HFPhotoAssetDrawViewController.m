//
//  HFPhotoAssetDrawViewController.m
//  Objcs
//
//  Created by wff on 2018/11/30.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "HFPhotoAssetDrawViewController.h"
#import "HFToolBarView.h"
#import "LXFDrawBoard.h"
#import "HFHColorPicker.h"
#import "HFPhotoAssetClipViewController.h"
#import "YasicClipPage.h"
#import "HFPhotoAssetCropViewController.h"

@interface HFPhotoAssetDrawViewController ()<YasicClipPageDelegate,HFColorPickerDelegate,LXFDrawBoardDelegate>

@property (nonatomic,strong) UIImageView *editedImageView;

@property(strong,nonatomic) HFHColorPicker *colorPickerView;
//批注弹窗
@property(strong,nonatomic) LXFDrawBoard* drawBoard;

@end

@implementation HFPhotoAssetDrawViewController

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
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setupBottomView];
}

- (void)setupBottomView {
    _editedImageView = [[UIImageView alloc] init];
    [self.view addSubview:_editedImageView];
    _editedImageView.image = _editedImage;
    _editedImageView.size = _clipImageSize;
    _editedImageView.center = self.view.center;

    HFWeak(self)
    HFToolBarView *shadowView = [[HFToolBarView alloc]
                                initWithFrame:CGRectMake(0, kScreenHeight-50, kScreenWidth, 50)
                                titles:@[@"取消",@"批注",@"裁剪",@"完成"]
                                touchBlock:^(NSInteger tag) {
                                    [weakself toolBarClick:tag];
                                }];
    [self.view addSubview:shadowView];
}

- (void)updateImageFrame {
}

- (void)toolBarClick:(NSInteger)tag {
    if (tag == 0) {
        //取消
        [self.navigationController popViewControllerAnimated:YES];
    } else if (tag == 1) {
        //批注
        [self drawClick];
    } else if (tag == 2) {
        //裁剪
        [self cropImage];
    } else {
        //完成
        if (_editedImageBlock) {
            _editedImageBlock(_editedImage,_editedImageView.size);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 批注画线
 */
-(void)drawClick{
    //批注
    if(!self.drawBoard){
        //着色
        self.drawBoard=[LXFDrawBoard new];
        self.drawBoard.image = _editedImageView.image;
        self.drawBoard.canRevoke = YES;
        
        self.drawBoard.brush = [LXFPencilBrush new];
        [self.view insertSubview:self.drawBoard aboveSubview:_editedImageView];
        self.drawBoard.frame=CGRectMake(round(_editedImageView.frame.origin.x), round(_editedImageView.frame.origin.y), round(_editedImageView.frame.size.width), round(_editedImageView.frame.size.height));
        self.drawBoard.style.lineColor = [UIColor redColor]; // 默认是红色
        self.drawBoard.style.lineWidth = 2;
        self.drawBoard.delegate = self;
        
        self.colorPickerView=[HFHColorPicker new];
        [self.view addSubview:self.colorPickerView];
        self.colorPickerView.delegate=self;
        HFWeak(self)
        [_colorPickerView.revokeBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [weakself.drawBoard revoke];
        }];
        [self.colorPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(200 ,55));
            make.bottom.mas_equalTo(-60);
        }];
    }
    //取消批注
    else{
        [self resetDrawBoard];
    }
}

- (void)resetDrawBoard {
    if (!self.drawBoard) {
        return;
    }
    [self.drawBoard removeFromSuperview];
    [self.colorPickerView removeFromSuperview];
    self.drawBoard=nil;
    self.colorPickerView=nil;
}

/**
 图片裁剪
 */
- (void)cropImage {
    
//    HFPhotoAssetClipViewController *ctrl = [HFPhotoAssetClipViewController new];
//    ctrl.editedImage = _editedImageView.image;
//    [self.navigationController pushViewController:ctrl animated:YES];
//    HFWeak(self)
//    ctrl.editedImageBlock = ^(UIImage *image) {
//        [weakself updateImageView:image];
//    };
    
    HFPhotoAssetCropViewController *ctrl = [HFPhotoAssetCropViewController new];
    ctrl.editedImage = self.drawBoard ? [self imageWithBoad:self.drawBoard] : [self imageWithBoad:_editedImageView];
    [self.navigationController pushViewController:ctrl animated:YES];
    HFWeak(self)
    ctrl.editedImageBlock = ^(UIImage *image) {
        [weakself resetDrawBoard];
        [weakself updateImageView:image];
    };
}

- (void)updateImageView:(UIImage *)image{
    self.editedImageView.image = image;
    _editedImageView.size = image.size;
    _editedImageView.center = self.view.center;
}

#pragma mark HFColorPickerDelegate
- (void)colorDidPicked:(UIColor *)color{
    self.drawBoard.style.lineColor=color;
}

#pragma mark LXFDrawBoardDelegate
- (void)touchesEndedWithLXFDrawBoard:(LXFDrawBoard *)drawBoard {
    _editedImageView.image = drawBoard.drawImageView.image;
    _editedImage = drawBoard.drawImageView.image;
}

- (UIImage*)imageWithBoad:(UIImageView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, [UIScreen mainScreen].scale);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:currnetContext];
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
}

//#pragma mark 图片裁剪完 YasicClipPageDelegate
//-(void)yasicClipPagedidImageOK:(UIImage *)image clipImageSize:(CGSize)clipImageSize{
//    if(self.drawBoard){
//        [self.drawBoard removeFromSuperview];
//        [self.colorPickerView removeFromSuperview];
//        self.drawBoard=nil;
//        self.colorPickerView=nil;
//    }
//
//    _clipImageSize = CGSizeMake(round(clipImageSize.width), round(clipImageSize.height));
//    _editedImage = image;
//    _editedImageView.image = image;
//    _editedImageView.size = _clipImageSize;
//    _editedImageView.center = self.view.center;
//
//}

@end
