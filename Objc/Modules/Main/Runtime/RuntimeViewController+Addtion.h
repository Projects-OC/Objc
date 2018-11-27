//
//  RuntimeViewController+Addtion.h
//  Object-CDemo
//
//  Created by Mac on 2018/3/27.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "RuntimeViewController.h"

@interface RuntimeViewController (Addtion)

//新增属性
@property (nonatomic,copy) NSString *age;
//新增属性
@property (nonatomic,copy) NSString *sex;

-(void)age:(NSString *)age sex:(NSString *)sex;

@end
