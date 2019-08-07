//
//  HFPhotoAssetToolBarView.m
//  HF_Client_iPhone_Application
//
//  Created by header on 2019/8/6.
//  Copyright © 2019 HengFeng. All rights reserved.
//

#import "HFPhotoAssetToolBarView.h"

@implementation HFPhotoAssetToolBarView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        _titleBtn = [UIButton new];
        _titleBtn.backgroundColor = [UIColor redColor];
        _titleBtn.layer.cornerRadius = 5;
        _titleBtn.layer.masksToBounds = YES;
        _titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_titleBtn];
        [_titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(80, 40));
        }];
    }
    return self;
}

- (void)setSelectCount:(NSInteger)selectCount {
    _selectCount = selectCount;
    [self.titleBtn setTitle:[NSString stringWithFormat:@"确定(%ld/4)",(long)selectCount] forState:UIControlStateNormal];
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    if (self.superview) {
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 0.8;
        } completion:^(BOOL finished) {
            [super didMoveToSuperview];
        }];
    }
}

- (void)hideSelf {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
