//
//  UIButton+Block.m
//  Object-CDemo
//
//  Created by Mac on 2018/3/27.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "UIButton+Block.h"
#import <objc/runtime.h>

static const void *ButtonKey = &ButtonKey;

@implementation UIButton (Block)

- (void)tapEvent:(UIControlEvents)event withBlock:(TapBlock)block{
    objc_setAssociatedObject(self, ButtonKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(btnClick:) forControlEvents:event];
}

- (void)btnClick:(UIButton *)sender{
    TapBlock block = objc_getAssociatedObject(sender, ButtonKey);
    if (block) {
        block(sender);
    }
}

@end
