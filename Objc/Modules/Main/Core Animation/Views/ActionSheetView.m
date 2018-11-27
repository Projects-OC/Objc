//
//  ActionSheetView.m
//  Objc
//
//  Created by mf on 2018/8/2.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "ActionSheetView.h"

static CGFloat actionSheetHeight = 300;

@interface ActionSheetView ()

@property (nonatomic,strong) UIView *backgroundControl;
@property (nonatomic,strong) UIView *actionSheetView;

@end

@implementation ActionSheetView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _backgroundControl = ({
            UIView *_view = [[UIView alloc] initWithFrame:self.bounds];
            _view.backgroundColor = [UIColor grayColor];
            [self addSubview:_view];
            _view;
        });
        
        _actionSheetView = ({
            UIView *_view = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, actionSheetHeight)];
            _view.backgroundColor = [UIColor redColor];
            [self addSubview:_view];
            _view;
        });
        
        UIButton *_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitle:@"关闭弹框" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn setFrame:CGRectMake(0, 0, 300, 50)];
        [_actionSheetView addSubview:_btn];
        @weakify(self)
        [_btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            @strongify(self)
            [self hideSelf];
        }];
    }
    return self;
}

/**
 willMoveToSuperview 和 didMoveToSuperview 这组方法
 会在 UIView 作为subView 被添加到其他 UIView 中时调用
 */
- (void)didMoveToSuperview {
    if (self.superview) {
        [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.backgroundControl.alpha = 1;
            self.actionSheetView.frame = CGRectMake(0, kScreenHeight - actionSheetHeight, kScreenWidth, actionSheetHeight);
        } completion:^(BOOL finished) {
            [super didMoveToSuperview];
        }];
    }
}

- (void)hideSelf {
    [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.backgroundControl.alpha = 0;
        self.actionSheetView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, actionSheetHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
