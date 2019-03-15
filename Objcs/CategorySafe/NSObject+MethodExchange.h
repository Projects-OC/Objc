//
//  NSObject+MethodExchange.h
//  Objcs
//
//  Created by header on 2019/3/5.
//  Copyright © 2019年 mf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (MethodExchange)

/**
 方法交换

 @param methodClass 交换的类
 @param sysSEL 系统SEL
 @param safeSEL 安全的SEL
 */
+ (void)method_exchangeWithMethodClass:(Class)methodClass
                                sysSEL:(SEL)sysSEL
                               safeSEL:(SEL)safeSEL;

@end

NS_ASSUME_NONNULL_END
