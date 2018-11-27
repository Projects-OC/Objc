//
//  RuntimeViewController+Addtion.m
//  Object-CDemo
//
//  Created by Mac on 2018/3/27.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "RuntimeViewController+Addtion.h"
#import <objc/runtime.h>

@implementation RuntimeViewController (Addtion)
//告诉系统 不自动生成的get和set方法
@dynamic age;
@dynamic sex;

-(void)age:(NSString *)age sex:(NSString *)sex{
    self.sex = sex;
    self.age = age;
}

//添加属性扩展set方法
static const void *SexKey = &SexKey;
static const void *AgeKey = &AgeKey;

-(void)setAge:(NSString *)age{
    objc_setAssociatedObject(self,AgeKey,age,OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)setSex:(NSString *)sex{
    objc_setAssociatedObject(self,SexKey,sex,OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//添加属性扩展get方法
-(NSString *)age{
    return objc_getAssociatedObject(self,AgeKey);
}
-(NSString *)sex{
    return objc_getAssociatedObject(self,SexKey);
}




+ (BOOL)resolveInstanceMethod:(SEL)selector{
    NSString *selectorString = NSStringFromSelector(selector);
    if ([selectorString hasPrefix:@"sex"]) {
        class_addMethod(self,
                        selector,
                        (IMP)autoDictionarySetter,
                        "v@:@");
    }else{
        class_addMethod(self,
                        selector,
                        (IMP)autoDictionaryGetter,
                        "@@:");
    }
    
    return YES;
}

id autoDictionaryGetter(id self,SEL _cmd){
    NSString *key = NSStringFromSelector(_cmd);
    
    return key;
}

void autoDictionarySetter(id self, SEL _cmd, id value){
    NSString *selectorString = NSStringFromSelector(_cmd);

}

@end
