//
//  FloatingViewBtn.m
//  Objcs
//
//  Created by wff on 2018/11/27.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "FloatingViewBtn.h"
#import "SemiCircleView.h"
#import "FloatingViewController.h"
#import "FloatingAnimator.h"

@interface FloatingViewBtn ()<UINavigationControllerDelegate>

@property (nonatomic,assign) CGPoint lastPoint;
@property (nonatomic,assign) CGPoint pointInSelf;

@end

@implementation FloatingViewBtn

static CGFloat floatingW = 60;
static CGFloat circleW = 160;

static FloatingViewBtn *floatingView;
static SemiCircleView *circleView;

+ (void)showFloating {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        floatingView = [[FloatingViewBtn alloc] initWithFrame:CGRectMake(10, 200, floatingW, floatingW)];
        circleView = [[SemiCircleView alloc] initWithFrame:CGRectMake(kScreenWidth, kScreenHeight, circleW, circleW)];
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
    _pointInSelf = [touch locationInView:self];
    
//    [UIView animateWithDuration:0.2 animations:^{
//        circleView.frame = CGRectMake(kScreenWidth-circleW, kScreenHeight-circleW, circleW, circleW);
//    }];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.superview];
    
    if (CGRectEqualToRect(circleView.frame, CGRectMake(kScreenWidth, kScreenHeight, circleW, circleW))) {
        [UIView animateWithDuration:0.2 animations:^{
            circleView.frame = CGRectMake(kScreenWidth-circleW, kScreenHeight-circleW, circleW, circleW);
        }];
    }
    
    //计算出floatingBtn的center坐标
    CGFloat centerx = currentPoint.x + (self.width/2 - _pointInSelf.x);
    CGFloat centery = currentPoint.y + (self.height/2 - _pointInSelf.y);
    
    //限制center坐标值
    CGFloat x = MAX(floatingW/2, MIN(kScreenWidth-floatingW/2, centerx));
    CGFloat y = MAX(floatingW/2, MIN(kScreenHeight-floatingW/2, centery));
    self.center = CGPointMake(x, y);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.superview];
   
    //点击浮窗
    if (CGPointEqualToPoint(_lastPoint, currentPoint)) {
        AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UITabBarController *tab = (UITabBarController *)del.window.rootViewController;
        UINavigationController *ctrl = tab.selectedViewController;
        ctrl.delegate = self;
        FloatingViewController *fctrl = [FloatingViewController new];
        [ctrl pushViewController:fctrl animated:YES];
        
        return;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        circleView.frame = CGRectMake(kScreenWidth, kScreenHeight, circleW, circleW);
        
        CGFloat distance = sqrt(pow(kScreenWidth - self.centerX, 2) + pow(kScreenHeight - self.centerY, 2));
        if (distance <= circleW-30) {
            [self removeFromSuperview];
        }
    }];
    
    //左右两边距离
    CGFloat leftMargin = self.center.x;
    CGFloat rightMargin = kScreenWidth - leftMargin;
    if (leftMargin < rightMargin) {
        [UIView animateWithDuration:0.2 animations:^{
            self.center = CGPointMake(floatingW/2 + 10, self.center.y);
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.center = CGPointMake(kScreenWidth-floatingW/2 - 10, self.center.y);
        }];
    }
}

#pragma mark navigationDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0) {
    if (operation == UINavigationControllerOperationPush) {
        FloatingAnimator *animator = [FloatingAnimator new];
        animator.curFrame = self.frame;
        return animator;
    }
    return nil;
}


@end

