//
//  HFToolBarView.m
//  Objcs
//
//  Created by wff on 2018/11/30.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "HFToolBarView.h"

@implementation HFToolBarView

- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray *)titles
                   touchBlock:(void (^)(NSInteger tag))touchBlock {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        for (int i = 0; i < titles.count ; i ++) {
            UIView *shadow = [[UIView alloc]init];
            shadow.frame = CGRectMake(i*kScreenWidth/titles.count, 0, kScreenWidth/titles.count, 50);
            [self addSubview:shadow];
            
            UIButton *_btn = [[UIButton alloc]init];
            [_btn setTag:i];
            [_btn setTitle:titles[i] forState:UIControlStateNormal];
            [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [shadow addSubview:_btn];
            [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(0);
                make.width.mas_equalTo(kScreenWidth/titles.count);
                make.height.mas_equalTo(50);
            }];
            HFWeak(_btn)
            [_btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                if (touchBlock) {
                    touchBlock(weak_btn.tag);
                }
            }];
        }
    }
    return self;
}

@end
