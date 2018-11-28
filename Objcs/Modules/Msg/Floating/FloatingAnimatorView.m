//
//  FloatingAnimatorView.m
//  Objcs
//
//  Created by wff on 2018/11/28.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "FloatingAnimatorView.h"

@interface FloatingAnimatorView()<CAAnimationDelegate>

@property (nonatomic,strong) CAShapeLayer *shapeLayer;
@property (nonatomic,strong) UIView *toView;

@end

@implementation FloatingAnimatorView

- (void)startAnimateView:(UIView *)view fromeRect:(CGRect)fromRect toRect:(CGRect)toRect {
    _toView = view;
    //定义圆形mask和浮窗大小相同
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:fromRect cornerRadius:30].CGPath;
    self.layer.mask = _shapeLayer;
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    anim.toValue = (__bridge id _Nullable)([UIBezierPath bezierPathWithRoundedRect:toRect cornerRadius:30].CGPath);
    anim.duration = 0.5;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    anim.delegate = self;
    [_shapeLayer addAnimation:anim forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    _toView.hidden = NO;
    [_shapeLayer removeAllAnimations];
    [self removeFromSuperview];
}

@end
