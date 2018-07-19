//
//  PictureBrowserScrollView.m
//  Object-CDemo
//
//  Created by Mac on 2018/3/27.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "PictureBrowserZoomScrollView.h"

@interface PictureBrowserZoomScrollView()

@property (nonatomic,assign) BOOL isSingleTap;

@end

@implementation PictureBrowserZoomScrollView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createZoomScrollView];
    }
    return self;
}

- (void)createZoomScrollView{
    self.delegate = self;
    _isSingleTap = NO;
    self.minimumZoomScale = 1.0f;
    self.maximumZoomScale = 3.0f;
    
    _zoomImageView = [[UIImageView alloc]init];
    _zoomImageView.userInteractionEnabled = YES;
    _zoomImageView.contentMode = UIViewContentModeScaleAspectFit;
    _zoomImageView.clipsToBounds = YES;
    [self addSubview:_zoomImageView];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _zoomImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    // 延中心点缩放
    CGRect rect = _zoomImageView.frame;
    rect.origin.x = 0;
    rect.origin.y = 0;
    if (rect.size.width < self.frame.size.width) {
        rect.origin.x = floorf((self.frame.size.width - rect.size.width) / 2.0);
    }
    if (rect.size.height < self.frame.size.height) {
        rect.origin.y = floorf((self.frame.size.height - rect.size.height) / 2.0);
    }
    _zoomImageView.frame = rect;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    if(touch.tapCount == 1){
        [self performSelector:@selector(singleTapClick) withObject:nil afterDelay:0.2];
    }
    else if(touch.tapCount == 2){
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        // 防止先执行单击手势后还执行下面双击手势动画异常问题
        if(!_isSingleTap){
            CGPoint touchPoint = [touch locationInView:_zoomImageView];
            [self zoomDoubleTapWithPoint:touchPoint];
        }
    }
}

- (void)singleTapClick{
    _isSingleTap = YES;
    if (_tapBlock) {
        _tapBlock();
    }
}

- (void)zoomDoubleTapWithPoint:(CGPoint)touchPoint{
    if(self.zoomScale > self.minimumZoomScale){
        [self setZoomScale:self.minimumZoomScale animated:YES];
    }
    else{
        CGFloat width = self.bounds.size.width / self.maximumZoomScale;
        CGFloat height = self.bounds.size.height / self.maximumZoomScale;
        [self zoomToRect:CGRectMake(touchPoint.x - width / 2, touchPoint.y - height / 2, width, height) animated:YES];
    }
}

@end
