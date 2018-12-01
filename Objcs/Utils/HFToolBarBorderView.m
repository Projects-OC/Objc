//
//  HFToolBarBorderView.m
//  HF_Client_iPhone_Application
//
//  Created by header on 2018/9/21.
//  Copyright © 2018年 HengFeng. All rights reserved.
//

#import "HFToolBarBorderView.h"

@implementation HFToolBarBorderView

- (instancetype)initWithTitles:(NSArray <NSString *> *)titles
                    textColors:(NSArray <UIColor *> *)textColors
                    backColors:(NSArray <UIColor *> *)backColors
                      isBorder:(BOOL)isBorder
                      tapBlock:(void (^)(NSInteger tag))tapBlock {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _btns = [NSMutableArray arrayWithCapacity:titles.count];
        
        CGFloat padding = 16;
        CGFloat btnWidth = (kScreenWidth - (titles.count+1)*padding)/titles.count;
        for (int i=0; i<titles.count; i++) {
            UIButton *_btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [_btn setTitle:titles[i] forState:UIControlStateNormal];
            [_btn setTitleColor:textColors[i] forState:UIControlStateNormal];
            _btn.backgroundColor = backColors[i];
            _btn.titleLabel.font = [UIFont systemFontOfSize:16];
            if (isBorder) {
                _btn.layer.borderColor = [UIColor grayColor].CGColor;
                _btn.layer.borderWidth = 0.5;
            }
            _btn.layer.masksToBounds = YES;
            _btn.layer.cornerRadius = 5;
            _btn.tag = i;
            [self addSubview:_btn];
            [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(btnWidth, 50));
                make.centerY.equalTo(self);
                make.left.mas_equalTo(padding+(btnWidth+padding)*i);
            }];
            HFWeak(_btn)
            [_btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                if (tapBlock) {
                    tapBlock(weak_btn.tag);
                }
            }];
            [_btns addObject:_btn];
        }
    }
    return self;
}

- (void)addLayer {
    if (_layers.count > 0) {
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
}

- (void)removeSelfLayers {
    [_layers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    [_layers removeAllObjects];
}

@end
