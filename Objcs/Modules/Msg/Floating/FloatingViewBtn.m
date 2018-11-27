//
//  FloatingViewBtn.m
//  Objcs
//
//  Created by wff on 2018/11/27.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "FloatingViewBtn.h"
#import "SemiCircleView.h"

@interface FloatingViewBtn ()

@property (nonatomic,assign) CGPoint lastPoint;
@property (nonatomic,assign) CGPoint pointInSelf;

@end

@implementation FloatingViewBtn

static CGFloat floatingW = 60;
static CGFloat circleW = 160;
static CGRect  circleNormalRect;

static FloatingViewBtn *floatingView;
static SemiCircleView *circleView;

+ (void)showFloating {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        floatingView = [[FloatingViewBtn alloc] initWithFrame:CGRectMake(10, 200, floatingW, floatingW)];
        circleNormalRect = CGRectMake(kScreenWidth, kScreenHeight, circleW, circleW);
        circleView = [[SemiCircleView alloc] initWithFrame:circleNormalRect];
    });
    
    //添加半圆
    if (!circleView.superview) {
        [UIApplication.sharedApplication.keyWindow addSubview:circleView];
        [UIApplication.sharedApplication.keyWindow bringSubviewToFront:circleView];
    }
    //添加浮窗
    if (!floatingView.superview) {
        [UIApplication.sharedApplication.keyWindow addSubview:floatingView];
        [UIApplication.sharedApplication.keyWindow bringSubviewToFront:floatingView];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"phil"].CGImage);
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    _lastPoint = [touch locationInView:self.superview];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.superview];
   
    if (CGPointEqualToPoint(_lastPoint, currentPoint)) {
    
        return;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        circleView.frame = circleNormalRect;
    }];
    
    CGFloat leftMargin = self.center.x;
    CGFloat rightMargin = kScreenWidth - leftMargin;
    if (leftMargin < rightMargin) {
        [UIView animateWithDuration:0.2 animations:^{
            self.center = CGPointMake(floatingW/2 + 10, self.center.y);
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.center = CGPointMake(kScreenWidth-floatingW/2 + 10, self.center.y);
        }];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.superview];
    
    
    
    //计算出floatingBtn的center坐标
    CGFloat centerx = currentPoint.x + (self.width/2 - _pointInSelf.x);
    CGFloat centery = currentPoint.y + (self.height/2 - _pointInSelf.y);
    
    //限制center坐标值
    CGFloat x = MAX(floatingW/2, MIN(kScreenWidth-floatingW/2, centerx));
    CGFloat y = MAX(floatingW/2, MIN(kScreenHeight-floatingW/2, centery));
    self.center = CGPointMake(x, y);
}

@end

