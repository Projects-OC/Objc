//
//  TabBar.m
//  Objcs
//
//  Created by header on 2019/3/14.
//  Copyright © 2019年 mf. All rights reserved.
//

#import "TabBar.h"

static float btnw = 50;

@interface TabBar ()

@property (nonatomic,strong) UIButton *appleBtn;

@end

@implementation TabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.appleBtn];
    }
    return self;
}

- (UIButton *)appleBtn {
    if (!_appleBtn) {
        _appleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _appleBtn.backgroundColor = [UIColor blackColor];
        [_appleBtn setTitle:@"Apple" forState:UIControlStateNormal];
        [_appleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_appleBtn addTarget:self action:@selector(appleClick) forControlEvents:UIControlEventTouchUpInside];
        _appleBtn.layer.cornerRadius = btnw/2;
        _appleBtn.layer.masksToBounds = YES;
    }
    return _appleBtn;
}

- (void)appleClick {
    if (_appleHandle) {
        _appleHandle();
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSInteger centerX = CGRectGetWidth(self.bounds) / 2;
    NSInteger cenyerY = CGRectGetHeight(self.bounds) / 2;
    self.appleBtn.frame = CGRectMake(centerX - btnw/2, cenyerY - btnw/2, btnw, btnw);
    
    NSInteger index = 0;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            //减去_UIBarBackground 和 UIButton
            NSInteger subViews = self.subviews.count - 2;
            if (index == ceil(subViews/2)) {
                view.hidden = YES;
            }
            index ++;
        }
    }
    [self bringSubviewToFront:self.appleBtn];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    /*
     判断self.hidden是防止push到其它页面后 点击roundButton的位置依旧响应roundButton点击事件
     判断当前点击是否落在roundButton上 YES:响应roundButton事件  NO:系统处理
     */
    if (self.hidden == NO) {
        // 将相对于tabBar触摸点位置转为相对于roundButton的坐标位置
        CGPoint newPoint = [self convertPoint:point toView:self.appleBtn];
        // 如果在roundButton内 响应roundButton点击事件
        if ([self.appleBtn pointInside:newPoint withEvent:event]) {
            return self.appleBtn;
        } else {
            return [super hitTest:point withEvent:event];
        }
    }
    else {
        return [super hitTest:point withEvent:event];
    }
}

@end
