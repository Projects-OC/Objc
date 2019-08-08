//
//  HFPhotoAssetCollectionViewCell.m
//  PhotoKit
//
//  Created by header on 2018/9/18.
//  Copyright © 2018年 header. All rights reserved.
//

#import "HFPhotoAssetCollectionViewCell.h"

@implementation HFPhotoAssetCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {        
        _imgView = [UIImageView new];
        _imgView.clipsToBounds = YES;
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        _selectImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo_def"]];
        [_imgView addSubview:_selectImg];
        [_selectImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.left.mas_equalTo(self.imgView.mas_right).offset(-20);
            make.top.mas_equalTo(self.imgView.mas_top).offset(0);
        }];
        
        /*
        UITapGestureRecognizer *_singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapClick:)];
        _singleTap.numberOfTapsRequired = 1;
        [self.contentView addGestureRecognizer:_singleTap];
        
        UITapGestureRecognizer *_doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapClick:)];
        _doubleTap.numberOfTapsRequired = 2;
        [self.contentView addGestureRecognizer:_doubleTap];
        
        //当没有检测到doubleTap 或者 检测doubleTap失败，singleTap才有效
        [_singleTap requireGestureRecognizerToFail:_doubleTap];
         */
    }

    return self;
}

//- (void)setImgView:(UIImageView *)imgView {
//    _imgView = imgView;
//    if (_isGrayImage) {
//        _imgView.image = [self grayImage:imgView.image];
//    }
//}

- (void)setIsGrayImage:(BOOL)isGrayImage {
    _isGrayImage = isGrayImage;
    if (isGrayImage) {
        _imgView.image = [self grayImage:_imgView.image];
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

- (void)singleTapClick:(UITapGestureRecognizer *)singleTapClick {
    NSLog(@"单击");
}

- (void)doubleTapClick:(UITapGestureRecognizer *)singleTapClick {
    NSLog(@"双击 %d",singleTapClick.view.tag);
    if (_doubleTapBlock) {
        _doubleTapBlock(singleTapClick.view.tag);
    }
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:0.5
          initialSpringVelocity:12
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         if (selected) {
                             _selectImg.transform = CGAffineTransformMakeScale(1.2, 1.2);
                             _selectImg.image = [UIImage imageNamed:@"photo_sel"];
                         } else {
                             _selectImg.transform = CGAffineTransformIdentity;
                             _selectImg.image = [UIImage imageNamed:@"photo_def"];
                         }
                     }
                     completion:nil];
//    if (selected) {
//        _selectImg.image = [UIImage imageNamed:@"photo_sel"];
//    } else {
//        _selectImg.image = [UIImage imageNamed:@"photo_def"];
//    }

//    if (selected) {
//        self.layer.borderColor = [UIColor greenColor].CGColor;
//        self.layer.borderWidth = 2;
//    } else {
//        if (self.tag == 0) {
//            self.layer.borderColor = [UIColor blackColor].CGColor;
//            self.layer.borderWidth = 1;
//        } else {
//            //        self.layer.borderColor = [UIColor clearColor].CGColor;
//            self.layer.borderWidth = 0;
//        }
//    }
}

@end
