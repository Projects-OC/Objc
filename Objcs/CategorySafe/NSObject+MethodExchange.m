//
//  NSObject+MethodExchange.m
//  Objcs
//
//  Created by header on 2019/3/5.
//  Copyright © 2019年 mf. All rights reserved.
//

#import "NSObject+MethodExchange.h"

@implementation NSObject (MethodExchange)

+ (void)method_exchangeWithMethodClass:(Class)methodClass
                                sysSEL:(SEL)sysSEL
                               safeSEL:(SEL)safeSEL {
    Method sys = class_getInstanceMethod(methodClass, sysSEL);
    Method safe = class_getInstanceMethod(methodClass, safeSEL);
    method_exchangeImplementations(sys, safe);
}

@end
