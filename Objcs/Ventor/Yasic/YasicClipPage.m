//
//  YasicClipPage.m
//  DynamicClipImage
//
//  Created by yasic on 2017/11/29.
//  Copyright © 2017年 yasic. All rights reserved.
//

#import "YasicClipPage.h"
#import <Masonry.h>
#import "YasicClipAreaLayer.h"
#import "YasicPanGestureRecognizer.h"
//#import "ImageViewController.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

typedef NS_ENUM(NSInteger, ACTIVEGESTUREVIEW) {
    CROPVIEWLEFT,
    CROPVIEWRIGHT,
    CROPVIEWTOP,
    CROPVIEWBOTTOM,
    BIGIMAGEVIEW
};

@interface YasicClipPage ()

@property (strong, nonatomic) UIImage *targetImage;
@property (strong, nonatomic) UIImage *orginalImage;
@property(strong, nonatomic) UIImageView *bigImageView;
@property(strong, nonatomic) UIView *cropView;
@property(strong,nonatomic)UIButton *btnCancel;
@property(strong,nonatomic)UIButton *btnOK;
@property(strong,nonatomic)UIButton *btnRotate;
@property(strong,nonatomic)UIButton *btnRestore;
@property(assign, nonatomic) ACTIVEGESTUREVIEW activeGestureView;
//bottom背景View
@property(strong,nonatomic) UIView *shadowView;
// 图片 view 原始 frame
@property(assign, nonatomic) CGRect originalFrame;

// 裁剪区域属性
@property(assign, nonatomic) CGFloat cropAreaX;
@property(assign, nonatomic) CGFloat cropAreaY;
@property(assign, nonatomic) CGFloat cropAreaWidth;
@property(assign, nonatomic) CGFloat cropAreaHeight;

@property(nonatomic, assign) CGFloat clipHeight;
@property(nonatomic, assign) CGFloat clipWidth;
//何景根
@property(nonatomic,assign)bool hasBringSubViewsToTop;
@property(nonatomic,assign)CGRect beforePinchFrame;
@end

@implementation YasicClipPage

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setUpCropLayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hasBringSubViewsToTop=false;
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.view.backgroundColor = [UIColor blackColor];

    self.orginalImage= self.bigImageView.image = self.targetImage;
    [self initSubViews];

    //UI初始化
    [self initUI];
    //手势
    [self addAllGesture];
}

-(instancetype)initWithImage:(UIImage*)image{
    self=[super init];
    if(self){
        self.targetImage=image;
    }
    return self;
}

-(void)initSubViews{
    [self.view addSubview:self.bigImageView];
    [self.view addSubview:self.shadowView];
    [self.view addSubview:self.cropView];
    [self.view addSubview:self.btnOK];
    [self.view addSubview:self.btnCancel];
    [self.view addSubview:self.btnRotate];
    [self.view addSubview:self.btnRestore];
    
    [_shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    [self.cropView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.mas_equalTo(-50);
    }];
    
    [self.btnOK mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
    }];
    [self.btnOK setTitle:@"完成" forState:UIControlStateNormal];
    [self.btnOK setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnOK addTarget:self action:@selector(btnOKClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnRotate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
        make.centerX.equalTo(self.view.mas_centerX).offset(-40);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
    }];
    [self.btnRotate setTitle:@"旋转" forState:UIControlStateNormal];
    [self.btnRotate setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnRotate addTarget:self action:@selector(btnRotateClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnRestore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
        make.centerX.equalTo(self.view.mas_centerX).offset(40);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
    }];
    [self.btnRestore setTitle:@"还原" forState:UIControlStateNormal];
    [self.btnRestore setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnRestore addTarget:self action:@selector(btnRestoreClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
    }];
    [self.btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [self.btnCancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnCancel addTarget:self action:@selector(btnCancelClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)initUI{
    self.clipWidth = SCREEN_WIDTH;
    self.clipHeight = self.clipWidth * 9/16;
    
    self.cropAreaX = (SCREEN_WIDTH - self.clipWidth)/2;
    self.cropAreaY = (SCREEN_HEIGHT - self.clipHeight)/2;
    self.cropAreaWidth = self.clipWidth;
    self.cropAreaHeight = self.clipHeight;
    
    [self updateBigImageViewConstant];
    [self setUpCropLayer];
}

- (CGRect)updateFrame {
    CGFloat tempWidth = 0.0;
    CGFloat tempHeight = 0.0;
    //图片自适应
    if (self.targetImage.size.width/self.cropAreaWidth <= self.targetImage.size.height/self.cropAreaHeight) {
        tempWidth = self.cropAreaWidth;
        tempHeight = (tempWidth/self.targetImage.size.width) * self.targetImage.size.height;
    } else if (self.targetImage.size.width/self.cropAreaWidth > self.targetImage.size.height/self.cropAreaHeight) {
        tempHeight = self.cropAreaHeight;
        tempWidth = (tempHeight/self.targetImage.size.height) * self.targetImage.size.width;
    }
    CGRect frame = CGRectMake(self.cropAreaX - (tempWidth - self.cropAreaWidth)/2, self.cropAreaY - (tempHeight - self.cropAreaHeight)/2, tempWidth, tempHeight);
    return frame;
}

-(void)updateBigImageViewConstant{
    self.bigImageView.frame = self.originalFrame = [self updateFrame];
}

-(void)updataOriginalFrame{
    self.originalFrame = [self updateFrame];
}

-(void)addAllGesture{
    // 捏合手势
    UIPinchGestureRecognizer *pinGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handleCenterPinGesture:)];
    [self.view addGestureRecognizer:pinGesture];
    // 拖动手势
    YasicPanGestureRecognizer *panGesture = [[YasicPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDynamicPanGesture:) inview:self.cropView];
    [self.cropView addGestureRecognizer:panGesture];
}
#pragma mark 移动手势
-(void)handleDynamicPanGesture:(YasicPanGestureRecognizer *)panGesture{
    UIView * view = self.bigImageView;
    CGPoint translation = [panGesture translationInView:view.superview];
    //防止跑到导航栏上
    CGFloat nvch=  self.navigationController.navigationBar.frame.size.height+30;
    CGFloat btnBaseLine=[UIScreen mainScreen].bounds.size.height-self.btnOK.frame.size.height-30;
    
    CGPoint beginPoint = panGesture.beginPoint;
    CGPoint movePoint = panGesture.movePoint;
    //四方框额外点击判断
    CGFloat judgeWidth = 20;
    
    // 开始滑动时判断滑动对象是 ImageView 还是 Layer 上的 Line
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        if (beginPoint.x >= self.cropAreaX - judgeWidth && beginPoint.x <= self.cropAreaX + judgeWidth && beginPoint.y >= self.cropAreaY && beginPoint.y <= self.cropAreaY + self.cropAreaHeight && self.cropAreaWidth >= 50) {
            self.activeGestureView = CROPVIEWLEFT;
        } else if (beginPoint.x >= self.cropAreaX + self.cropAreaWidth - judgeWidth && beginPoint.x <= self.cropAreaX + self.cropAreaWidth + judgeWidth && beginPoint.y >= self.cropAreaY && beginPoint.y <= self.cropAreaY + self.cropAreaHeight &&  self.cropAreaWidth >= 50) {
            self.activeGestureView = CROPVIEWRIGHT;
        } else if (beginPoint.y >= self.cropAreaY - judgeWidth && beginPoint.y <= self.cropAreaY + judgeWidth && beginPoint.x >= self.cropAreaX && beginPoint.x <= self.cropAreaX + self.cropAreaWidth && self.cropAreaHeight >= 50) {
            self.activeGestureView = CROPVIEWTOP;
        } else if (beginPoint.y >= self.cropAreaY + self.cropAreaHeight - judgeWidth && beginPoint.y <= self.cropAreaY + self.cropAreaHeight + judgeWidth && beginPoint.x >= self.cropAreaX && beginPoint.x <= self.cropAreaX + self.cropAreaWidth && self.cropAreaHeight >= 50) {
            self.activeGestureView = CROPVIEWBOTTOM;
        } else {
            self.activeGestureView = BIGIMAGEVIEW;
            [view setCenter:CGPointMake(view.center.x + translation.x, view.center.y + translation.y)];
            [panGesture setTranslation:CGPointZero inView:view.superview];
        }
    }
    
    // 滑动过程中进行位置改变
    if (panGesture.state == UIGestureRecognizerStateChanged) {
        CGFloat diff = 0;
        switch (self.activeGestureView) {
            case CROPVIEWLEFT: {
                diff = movePoint.x - self.cropAreaX;
                if (diff >= 0 && self.cropAreaWidth > 50) {
                    self.cropAreaWidth -= diff;
                    self.cropAreaX += diff;
                } else if (diff < 0 && self.cropAreaX > self.bigImageView.frame.origin.x && self.cropAreaX >= 15) {
                    self.cropAreaWidth -= diff;
                    self.cropAreaX += diff;
                }
                [self setUpCropLayer];
//                [self updataOriginalFrame];
                break;
            }
            case CROPVIEWRIGHT: {
                diff = movePoint.x - self.cropAreaX - self.cropAreaWidth;
                if (diff >= 0 && (self.cropAreaX + self.cropAreaWidth) < MIN(self.bigImageView.frame.origin.x + self.bigImageView.frame.size.width, self.cropView.frame.origin.x + self.cropView.frame.size.width - 15)){
                    self.cropAreaWidth += diff;
                } else if (diff < 0 && self.cropAreaWidth >= 50) {
                    self.cropAreaWidth += diff;
                }
                [self setUpCropLayer];
                [self updataOriginalFrame];
                break;
            }
            case CROPVIEWTOP: {
                diff = movePoint.y - self.cropAreaY;
                if (diff >= 0 && self.cropAreaHeight > 50) {
                    self.cropAreaHeight -= diff;
                    self.cropAreaY += diff;
                }
                else if (diff < 0 && self.cropAreaY > self.bigImageView.frame.origin.y && self.cropAreaY >= 15) {
                    self.cropAreaHeight -= diff;
                    self.cropAreaY += diff;
                }
                //如果顶到导航栏上就还原
                if(self.cropAreaY<=nvch){
                    self.cropAreaHeight += diff;
                    self.cropAreaY -= diff;
                }
                [self setUpCropLayer];
                [self updataOriginalFrame];
                break;
            }
            case CROPVIEWBOTTOM: {
                diff = movePoint.y - self.cropAreaY - self.cropAreaHeight;
                if (diff >= 0 && (self.cropAreaY + self.cropAreaHeight) < MIN(self.bigImageView.frame.origin.y + self.bigImageView.frame.size.height, self.cropView.frame.origin.y + self.cropView.frame.size.height - 15)){
                    self.cropAreaHeight += diff;
                } else if (diff < 0 && self.cropAreaHeight >= 50) {
                    self.cropAreaHeight += diff;
                }
                //如果顶到下面就不原
                if((self.cropAreaY+self.cropAreaHeight)>=btnBaseLine){
                    self.cropAreaHeight-=diff;
                }
               [self setUpCropLayer];
               [self updataOriginalFrame];
                break;
            }
            case BIGIMAGEVIEW: {
                NSLog(@"case BIGIMAGEVIEW: ");
                [view setCenter:CGPointMake(view.center.x + translation.x, view.center.y + translation.y)];
                [panGesture setTranslation:CGPointZero inView:view.superview];
                break;
            }
            default:
                break;
        }
    }
    // 滑动结束后进行位置修正
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        switch (self.activeGestureView) {
            case CROPVIEWLEFT: {
                if (self.cropAreaWidth < 50) {
                    self.cropAreaX -= 50 - self.cropAreaWidth;
                    self.cropAreaWidth = 50;
                }
                if (self.cropAreaX < MAX(self.bigImageView.frame.origin.x, 15)) {
                    CGFloat temp = self.cropAreaX + self.cropAreaWidth;
                    self.cropAreaX = MAX(self.bigImageView.frame.origin.x, 15);
                    self.cropAreaWidth = temp - self.cropAreaX;
                }
                
                [self setUpCropLayer];
                 [self updataOriginalFrame];
                break;
            }
            case CROPVIEWRIGHT: {
                if (self.cropAreaWidth < 50) {
                    self.cropAreaWidth = 50;
                }
                if (self.cropAreaX + self.cropAreaWidth > MIN(self.bigImageView.frame.origin.x + self.bigImageView.frame.size.width, self.cropView.frame.origin.x + self.cropView.frame.size.width - 15)) {
                    self.cropAreaWidth = MIN(self.bigImageView.frame.origin.x + self.bigImageView.frame.size.width, self.cropView.frame.origin.x + self.cropView.frame.size.width - 15) - self.cropAreaX;
                }
                [self setUpCropLayer];
                 [self updataOriginalFrame];
                break;
            }
            case CROPVIEWTOP: {
                if (self.cropAreaHeight < 50) {
                    self.cropAreaY -= 50 - self.cropAreaHeight;
                    self.cropAreaHeight = 50;
                }
                if (self.cropAreaY < MAX(self.bigImageView.frame.origin.y, 15)) {
                    CGFloat temp = self.cropAreaY + self.cropAreaHeight;
                    self.cropAreaY = MAX(self.bigImageView.frame.origin.y, 15);
                    self.cropAreaHeight = temp - self.cropAreaY;
                }
                [self setUpCropLayer];
                 [self updataOriginalFrame];
                break;
            }
            case CROPVIEWBOTTOM: {
                if (self.cropAreaHeight < 50) {
                    self.cropAreaHeight = 50;
                }
                if (self.cropAreaY + self.cropAreaHeight > MIN(self.bigImageView.frame.origin.y + self.bigImageView.frame.size.height, self.cropView.frame.origin.y + self.cropView.frame.size.height - 15)) {
                    self.cropAreaHeight = MIN(self.bigImageView.frame.origin.y + self.bigImageView.frame.size.height, self.cropView.frame.origin.y + self.cropView.frame.size.height - 15) - self.cropAreaY;
                }
                [self setUpCropLayer];
                [self updataOriginalFrame];
                break;
            }
            case BIGIMAGEVIEW: {
                NSLog(@"END----case BIGIMAGEVIEW: ");
                CGRect currentFrame = view.frame;
                
                if (currentFrame.origin.x >= self.cropAreaX) {
                    currentFrame.origin.x = self.cropAreaX;
                }
                if (currentFrame.origin.y >= self.cropAreaY) {
                    currentFrame.origin.y = self.cropAreaY;
                }
                if (currentFrame.size.width + currentFrame.origin.x < self.cropAreaX + self.cropAreaWidth) {
                    CGFloat movedLeftX = fabs(currentFrame.size.width + currentFrame.origin.x - (self.cropAreaX + self.cropAreaWidth));
                    currentFrame.origin.x += movedLeftX;
                }
                if (currentFrame.size.height + currentFrame.origin.y < self.cropAreaY + self.cropAreaHeight) {
                    CGFloat moveUpY = fabs(currentFrame.size.height + currentFrame.origin.y - (self.cropAreaY + self.cropAreaHeight));
                    currentFrame.origin.y += moveUpY;
                }
                [UIView animateWithDuration:0.3 animations:^{
                    
                    [view setFrame:currentFrame];
                }];
                break;
            }
            default:
                break;
        }
    }
}
#pragma mark 捏合手势
-(void)handleCenterPinGesture:(UIPinchGestureRecognizer *)pinGesture{
    CGFloat scaleRation = 3;
    UIView * view = self.bigImageView;
//    何景根
    if(pinGesture.state == UIGestureRecognizerStateBegan){
        self.beforePinchFrame=self.bigImageView.frame;
    }
    // 缩放开始与缩放中
    if (pinGesture.state == UIGestureRecognizerStateBegan || pinGesture.state == UIGestureRecognizerStateChanged) {
        // 移动缩放中心到手指中心
        CGPoint pinchCenter = [pinGesture locationInView:view.superview];
        CGFloat distanceX = view.frame.origin.x - pinchCenter.x;
        CGFloat distanceY = view.frame.origin.y - pinchCenter.y;
        CGFloat scaledDistanceX = distanceX * pinGesture.scale;
        CGFloat scaledDistanceY = distanceY * pinGesture.scale;
        CGRect newFrame = CGRectMake(view.frame.origin.x + scaledDistanceX - distanceX, view.frame.origin.y + scaledDistanceY - distanceY, view.frame.size.width * pinGesture.scale, view.frame.size.height * pinGesture.scale);
        view.frame = newFrame;
        pinGesture.scale = 1;
    }
    
    // 缩放结束
    if (pinGesture.state == UIGestureRecognizerStateEnded) {
        CGFloat ration =  view.frame.size.width / self.originalFrame.size.width;
        
        // 缩放过大
        if (ration > 5) {
            //何景根
//            CGRect newFrame = CGRectMake(0, 0, self.originalFrame.size.width * scaleRation, self.originalFrame.size.height * scaleRation);
//            view.frame = newFrame;
            view.frame=self.beforePinchFrame;
        }
        
        // 缩放过小
        if (ration < 0.25) {
            view.frame = self.originalFrame;
        }
        // 对图片进行位置修正
        CGRect resetPosition = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
        
        if (resetPosition.origin.x >= self.cropAreaX) {
            resetPosition.origin.x = self.cropAreaX;
        }
        if (resetPosition.origin.y >= self.cropAreaY) {
            resetPosition.origin.y = self.cropAreaY;
        }
        if (resetPosition.size.width + resetPosition.origin.x < self.cropAreaX + self.cropAreaWidth) {
            CGFloat movedLeftX = fabs(resetPosition.size.width + resetPosition.origin.x - (self.cropAreaX + self.cropAreaWidth));
            resetPosition.origin.x += movedLeftX;
        }
        if (resetPosition.size.height + resetPosition.origin.y < self.cropAreaY + self.cropAreaHeight) {
            CGFloat moveUpY = fabs(resetPosition.size.height + resetPosition.origin.y - (self.cropAreaY + self.cropAreaHeight));
            resetPosition.origin.y += moveUpY;
        }
        view.frame = resetPosition;
        
        // 对图片缩放进行比例修正，防止过小
        if (self.cropAreaX < self.bigImageView.frame.origin.x
            || ((self.cropAreaX + self.cropAreaWidth) > self.bigImageView.frame.origin.x + self.bigImageView.frame.size.width)
            || self.cropAreaY < self.bigImageView.frame.origin.y
            || ((self.cropAreaY + self.cropAreaHeight) > self.bigImageView.frame.origin.y + self.bigImageView.frame.size.height)) {
            view.frame = self.originalFrame;

        }
    }
}

#pragma mark 设置裁剪区域
- (void)setUpCropLayer{
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
    //将栽剪视图带到前面
    if(!self.hasBringSubViewsToTop)
    {
        [self.view bringSubviewToFront:self.cropView];
        [self.view bringSubviewToFront:self.btnOK];
        [self.view bringSubviewToFront:self.btnRotate];
        [self.view bringSubviewToFront:self.btnCancel];
        [self.view bringSubviewToFront:self.btnRestore];
        self.hasBringSubViewsToTop=true;
    }
}

- (UIImageView *)bigImageView{
    if (!_bigImageView) {
        _bigImageView = [[UIImageView alloc] init];
    }
    return _bigImageView;
}

- (UIView *)cropView{
    if (!_cropView) {
        _cropView = [[UIView alloc] init];
    }
    return _cropView;
}
-(UIButton*)btnCancel{
    if(!_btnCancel){
        _btnCancel=[UIButton new];
    }
    return _btnCancel;
}
-(UIButton*)btnOK{
    if(!_btnOK){
        _btnOK=[UIButton new];
    }
    return _btnOK;
}
-(UIButton*)btnRotate{
    if(!_btnRotate){
        _btnRotate=[UIButton new];
    }
    return _btnRotate;
}
-(UIButton*)btnRestore{
    if(!_btnRestore){
        _btnRestore=[UIButton new];
    }
    return _btnRestore;
}
-(UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [UIView new];
        _shadowView.backgroundColor = [UIColor whiteColor];
    }
    return _shadowView;
}

// 裁剪图片并调用返回Block
- (UIImage *)cropImage{
    //    CGFloat imageScale = MIN(self.bigImageView.frame.size.width/self.targetImage.size.width, self.bigImageView.frame.size.height/self.targetImage.size.height);
    //    CGFloat cropX = (self.cropAreaX - self.bigImageView.frame.origin.x)/imageScale;
    //    CGFloat cropY = (self.cropAreaY - self.bigImageView.frame.origin.y)/imageScale;
    //    CGFloat cropWidth = self.cropAreaWidth/imageScale;
    //    CGFloat cropHeight = self.cropAreaHeight/imageScale;
    //    CGRect cropRect = CGRectMake(cropX, cropY, cropWidth, cropHeight);
    
    CGFloat scale = self.bigImageView.image.scale;
    if (scale == 1) {
       scale = [UIScreen mainScreen].scale;
    }
    CGRect cropRect = CGRectMake((self.cropAreaX - self.bigImageView.frame.origin.x)*scale,
                                 (self.cropAreaY - self.bigImageView.frame.origin.y)*scale,
                                 self.cropAreaWidth*scale,
                                 self.cropAreaHeight*scale);
    
    
    CGImageRef sourceImageRef = [self.targetImage CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, cropRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    if(newImageRef)
        CFRelease(newImageRef);
    return newImage;
}

#pragma mark 完成事件
-(void)btnOKClick:(UIButton*)btn{
    UIImage *img=[self cropImage];
    if([self.delegate respondsToSelector:@selector(yasicClipPagedidImageOK:clipImageSize:)]){
        [self.delegate yasicClipPagedidImageOK:img clipImageSize:CGSizeMake(self.cropAreaWidth, self.cropAreaHeight)];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 旋转事件
-(void)btnRotateClick:(UIButton*)btn{
    UIImage *img=self.bigImageView.image;
    NSLog(@"imgsize:%f,%f",img.size.width,img.size.height);
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform =CGAffineTransformMake(0, 1, -1, 0, img.size.height,0);
    CGContextRef ctx = CGBitmapContextCreate(NULL, img.size.height, img.size.width,
                                             CGImageGetBitsPerComponent(img.CGImage), 0,
                                             CGImageGetColorSpace(img.CGImage),
                                             CGImageGetBitmapInfo(img.CGImage));
    CGContextConcatCTM(ctx, transform);
    CGContextDrawImage(ctx, CGRectMake(0,0,img.size.width,img.size.height), img.CGImage);
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img1 = [UIImage imageWithCGImage:cgimg];
    self.bigImageView.image=img1;
    self.targetImage=img1;
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    NSLog(@"img1size:%f,%f",img1.size.width,img1.size.height);
    [self initUI];
  
}
#pragma mark 取消事件
-(void)btnCancelClick:(UIButton*)btn{
    NSLog(@"取消");
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 还原事件
-(void)btnRestoreClick:(UIButton*)btn{
    NSLog(@"还原");
    self.bigImageView.image = self.targetImage=self.orginalImage;
    [self initUI];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}

@end
