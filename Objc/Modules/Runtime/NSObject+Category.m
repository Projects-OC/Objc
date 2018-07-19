//
//  NSObject+Category.m
//  Object-CDemo
//
//  Created by Mac on 2018/3/27.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "NSObject+Category.h"
#import <objc/runtime.h>

@implementation NSObject (Category)

/**
 *  判断类中是否有该属性
 *
 *  @param property 属性名称
 *
 *  @return 判断结果
 */
-(BOOL)hasProperty:(NSString *)property {
    BOOL flag = NO;
    u_int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        const char *propertyName = ivar_getName(ivars[i]);
        NSString *propertyString = [NSString stringWithUTF8String:propertyName];
        if ([propertyString isEqualToString:property]){
            flag = YES;
        }
    }
    return flag;
}

@end
