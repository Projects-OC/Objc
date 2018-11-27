//
//  AttributeObject.h
//  Objc
//
//  Created by header on 2018/11/21.
//  Copyright © 2018年 mf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 AttributeObject 不可以子类化，被继承
 */
__attribute__((objc_runtime_visible))
__attribute__((objc_subclassing_restricted))
@interface AttributeObject : NSObject

/**
 方法过时提示
 */
- (void)funcDeprecated; __attribute__((deprecated("已经过时请用function2方法")));

/**
 子类重写 必须调用父类super方法
 */
- (void)funcRequiresSuper __attribute__((objc_requires_super));


@end

/**
 别名，
 创建AttributeObject_alias 指向 AttributeObject
 使用AttributeObject_alias 替代 AttributeObject
 AttributeObject_alias *ali = [[AttributeObject_alias alloc] init];
 但是AttributeObject_alias 是不存在的
 */
@compatibility_alias AttributeObject_alias AttributeObject;

NS_ASSUME_NONNULL_END
