//
//  HFHColorPicker.m
//  HF_Client_iPhone_Application
//
//  Created by 何景根 on 2018/6/27.
//  Copyright © 2018年 HengFeng. All rights reserved.
//

#import "HFHColorPicker.h"
#import <Masonry.h>
@implementation HFHColorPicker

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self layoutUI];
    }
    return self;
}
-(void)layoutUI{
    
    //        红
    UIButton *btnRed= [UIButton new];
    [self addSubview:btnRed];
    btnRed.backgroundColor=[UIColor redColor];
    btnRed.layer.borderColor = [UIColor whiteColor].CGColor;
    btnRed.layer.borderWidth = 0.5;
    [btnRed addTarget:self action:@selector(colorPick:) forControlEvents:UIControlEventTouchUpInside];
    [btnRed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self).insets(UIEdgeInsetsMake(10, 10, 10, 0));
        //            make.left.height.mas_equalTo(self.frame.size.height/3-10*3);
        make.width.mas_equalTo(33);
    }];
    //蓝
    UIButton *btnBlue= [UIButton new];
    btnBlue.backgroundColor=[UIColor blueColor];
    btnBlue.layer.borderColor = [UIColor whiteColor].CGColor;
    btnBlue.layer.borderWidth = 0.5;
    [self addSubview:btnBlue];
    [btnBlue addTarget:self action:@selector(colorPick:) forControlEvents:UIControlEventTouchUpInside];
    [btnBlue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnRed.mas_right).offset(10);
        make.top.bottom.equalTo(self).insets(UIEdgeInsetsMake(10, 0, 10, 0));
        //            make.left.height.mas_equalTo(self.frame.size.height/3-10*3);
        make.width.mas_equalTo(33);
    }];
    //        黑
    UIButton *btnBlack= [UIButton new];
    btnBlack.backgroundColor=[UIColor blackColor];
    btnBlack.layer.borderColor = [UIColor whiteColor].CGColor;
    btnBlack.layer.borderWidth = 0.5;
    [self addSubview:btnBlack];
    [btnBlack addTarget:self action:@selector(colorPick:) forControlEvents:UIControlEventTouchUpInside];
    [btnBlack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnBlue.mas_right).offset(10);
        make.top.bottom.equalTo(self).insets(UIEdgeInsetsMake(10, 0, 10, 0));
        //            make.left.height.mas_equalTo(self.frame.size.height/3-10*3);
        make.width.mas_equalTo(33);
    }];
    
    //        撤销
    UIButton *revokeBtn= [UIButton new];
    revokeBtn.backgroundColor=[UIColor blackColor];
    revokeBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    revokeBtn.layer.borderWidth = 0.5;
    [revokeBtn setTitle:@"撤销" forState:UIControlStateNormal];
    revokeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:revokeBtn];
    [revokeBtn addTarget:self action:@selector(colorPick:) forControlEvents:UIControlEventTouchUpInside];
    [revokeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnBlack.mas_right).offset(10);
        make.top.bottom.equalTo(self).insets(UIEdgeInsetsMake(10, 0, 10, 0));
        //            make.left.height.mas_equalTo(self.frame.size.height/3-10*3);
        make.width.mas_equalTo(33);
    }];
    _revokeBtn = revokeBtn;
}
-(void)colorPick:(UIButton*)btn{
    self.color=btn.backgroundColor;
    if([self.delegate respondsToSelector:@selector(colorDidPicked:)]){
        [self.delegate colorDidPicked:self.color];
    }
}
@end
