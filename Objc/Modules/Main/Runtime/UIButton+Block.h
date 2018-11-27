//
//  UIButton+Block.h
//  Object-CDemo
//
//  Created by Mac on 2018/3/27.
//  Copyright © 2018年 MF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TapBlock) (UIButton *sender);

@interface UIButton (Block)

- (void)tapEvent:(UIControlEvents)event withBlock:(TapBlock)block;

@end
