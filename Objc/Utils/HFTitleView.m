//
//  HFTitleView.m
//  HF_Client_iPhone_Application
//
//  Created by header on 2018/9/29.
//  Copyright © 2018年 HengFeng. All rights reserved.
//

#import "HFTitleView.h"

@implementation HFTitleView

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        self.frame = CGRectMake(0, 0, kScreenWidth/2, 40);
        
        UIView *_backView = [UIView new];
        _backView.userInteractionEnabled = YES;
        _backView.backgroundColor = [UIColor redColor];
        [self addSubview:_backView];
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
        _titleBtn = ({
            UIButton *_btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [_btn setTitle:title forState:UIControlStateNormal];
            [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            _btn.titleLabel.font = [UIFont systemFontOfSize:18];
            [_backView addSubview:_btn];
            _btn;
        });
        [_titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_backView);
            make.centerY.equalTo(_backView);
        }];
        
        UIImageView *_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"展开"]];
        [_backView addSubview:_img];
        [_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleBtn.mas_right).offset(4);
            make.centerY.equalTo(_backView);
            make.right.equalTo(_backView);
            make.size.mas_equalTo(CGSizeMake(12, 6));
        }];
    }
    return self;
}


@end
