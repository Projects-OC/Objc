//
//  HFPhotoAssetCollectionViewCell.m
//  PhotoKit
//
//  Created by header on 2018/9/18.
//  Copyright © 2018年 header. All rights reserved.
//

#import "HFPhotoAssetCollectionViewCell.h"
#import "HFPhotoAssetModel.h"

@interface HFPhotoAssetCollectionViewCell ()

//@property (nonatomic,strong) UITapGestureRecognizer *singleTap;

@end

@implementation HFPhotoAssetCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {        
        self.contentView.userInteractionEnabled = YES;
        
        _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rj_placeholderImage"]];
        _imgView.clipsToBounds = YES;
        _imgView.userInteractionEnabled = YES;
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.8].CGColor;
        [self.contentView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
//        UIView *markView = [UIView new];
//        markView.userInteractionEnabled = YES;
//        [_imgView addSubview:markView];
//        [markView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.right.equalTo(self.imgView);
//            make.size.mas_equalTo(CGSizeMake(35, 35));
//        }];
//        self.markView = markView;
        
        UIImageView *markImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo_def"]];
        markImg.backgroundColor = [UIColor blueColor];
        markImg.userInteractionEnabled = YES;
        markImg.contentMode = UIViewContentModeScaleAspectFit;
        [_imgView addSubview:markImg];
        [markImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.top.right.equalTo(self.imgView);
//            make.center.equalTo(self.markView);
        }];
        self.markImg = markImg;
        
        UILabel *markLb = [UILabel new];
        markLb.textAlignment = NSTextAlignmentCenter;
        [_imgView addSubview:markLb];
        [markLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.markImg);
        }];
        self.markLb = markLb;
        
        _blurView = [UIView new];
        _blurView.hidden = YES;
        _blurView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.8].CGColor;
        [self.contentView addSubview:_blurView];
        [_blurView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.imgView);
        }];
        
        UITapGestureRecognizer *_singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapClick:)];
        _singleTap.numberOfTapsRequired = 1;
        [self.markImg addGestureRecognizer:_singleTap];
        
        /*
        UITapGestureRecognizer *_doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapClick:)];
        _doubleTap.numberOfTapsRequired = 2;
        [self.contentView addGestureRecognizer:_doubleTap];
        
        //当没有检测到doubleTap 或者 检测doubleTap失败，singleTap才有效
        [_singleTap requireGestureRecognizerToFail:_doubleTap];
         */
    }
    
    return self;
}

- (void)setAssetModel:(HFPhotoAssetModel *)assetModel {
    _assetModel = assetModel;
    // 图片标记选中
    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:0.5
          initialSpringVelocity:12
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         if (assetModel.isMarked) {
                             self.markImg.image = [UIImage imageNamed:@"photo_sel"];
                             self.markImg.transform = CGAffineTransformMakeScale(1.2, 1.2);
                             
                             self.markLb.hidden = NO;
                             self.markLb.text = [NSString stringWithFormat:@"%ld",assetModel.id +1];
                         } else {
                             self.markImg.image = [UIImage imageNamed:@"photo_def"];
                             self.markImg.transform = CGAffineTransformIdentity;
                             
                             self.markLb.hidden = YES;
                         }
                     }
                     completion:nil];
    
    // 图片灰度处理
    if (_assetModel.isGrayImage) {
        self.blurView.hidden = NO;
//        self.imgView.image = [self grayImage:_imgView.image];
    } else {
        self.blurView.hidden = YES;
    }
}

-(UIImage *)grayImage:(UIImage *)originImage {
    UIImage *image = originImage;

    int width = image.size.width;
    int height = image.size.height;
    //第一步:创建颜色空间(说白了就是 开辟一块颜色内存空间)
    //图片灰度处理(创建灰度空间)
    
    CGColorSpaceRef colorRef = CGColorSpaceCreateDeviceGray();
    
    //第二步:颜色空间的上下文(保存图像数据信息)
    //参数1:内存大小(指向这块内存区域的地址)(内存地址)
    //参数2:图片宽
    //参数3:图片高
    //参数4:像素位数(颜色空间,例如:32位像素格式和RGB颜色空间,8位)
    //参数5:图片每一行占用的内存比特数
    //参数6:颜色空间
    //参数7:图片是否包含A通道(ARGB通道)
    CGContextRef context = CGBitmapContextCreate(nil, width, height, 8, 0, colorRef, kCGImageAlphaNone);
    
    //释放内存
    CGColorSpaceRelease(colorRef);
    
    if (context == nil) {
        return nil;
    }
    //第三步:渲染图片(绘制图片)
    //参数1:上下文
    //参数2:渲染区域
    //参数3:源文件(原图片)(说白了现在是一个C/C++的内存区域)
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), image.CGImage);
    
    //第四步:将绘制颜色空间转成CGImage(转成可识别图片类型)
    CGImageRef grayImageRef = CGBitmapContextCreateImage(context);
    
    //第五步:将C/C++ 的图片CGImage转成面向对象的UIImage(转成iOS程序认识的图片类型)
    UIImage* dstImage = [UIImage imageWithCGImage:grayImageRef];
    
    //释放内存
    CGContextRelease(context);
    CGImageRelease(grayImageRef);
    return dstImage;
    /*
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *superImage = [CIImage imageWithCGImage:originImage.CGImage];
    CIFilter *lighten = [CIFilter filterWithName:@"CIColorControls"];
    [lighten setValue:superImage forKey:kCIInputImageKey];
    //    // 修改亮度   -1---1   数越大越亮
    [lighten setValue:@(0) forKey:@"inputBrightness"];
    
    // 修改饱和度  0---2
    [lighten setValue:@(0) forKey:@"inputSaturation"];
    
    //    // 修改对比度  0---4
    [lighten setValue:@(0.5) forKey:@"inputContrast"];
    CIImage *result = [lighten valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[superImage extent]];
    // 得到修改后的图片
    UIImage *newImage =  [UIImage imageWithCGImage:cgImage];
    // 释放对象
    CGImageRelease(cgImage);
    return newImage;
     */
}

- (void)singleTapClick:(UITapGestureRecognizer *)tapClick {
    if (_singleTapBlock) {
        _singleTapBlock(tapClick.view.tag);
    }
}

- (void)doubleTapClick:(UITapGestureRecognizer *)tapClick {
    if (_doubleTapBlock) {
        _doubleTapBlock(tapClick.view.tag);
    }
}

/*
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        _markImg.image = [UIImage imageNamed:@"photo_sel"];
    } else {
        _markImg.image = [UIImage imageNamed:@"photo_def"];
    }
}
 */

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(nonnull UITouch *)touch {
//    if([NSStringFromClass(touch.view.class) isEqualToString:@"UICollectionViewCellContentView"]) {
//        return NO;
//    }
//    return YES;
//}

@end


@implementation HFPhotoAssetCameraCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {

        _imgView = [UIImageView new];
        _imgView.image = [UIImage imageNamed:@"拍照"];
        _imgView.clipsToBounds = YES;
        _imgView.contentMode = UIViewContentModeCenter;
        _imgView.layer.borderColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0].CGColor;
        _imgView.layer.borderWidth = 0.5;
        [self.contentView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

@end
