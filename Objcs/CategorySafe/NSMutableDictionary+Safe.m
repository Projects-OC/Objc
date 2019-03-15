//
//  NSMutableDictionary+Safe.m
//  Objcs
//
//  Created by header on 2019/3/5.
//  Copyright © 2019年 mf. All rights reserved.
//

#import "NSMutableDictionary+Safe.h"
#import "NSObject+MethodExchange.h"

@implementation NSMutableDictionary (Safe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /**
         NSDictionary
         1、__NSPlaceholderDictionary（站位）
         2、__NSDictionary0（初始化，无数据）
         3、__NSSingleEntryDictionaryI（只有一个数据）
         4、__NSDictionaryI（两个以上数据）
         
         NSMutableDictionary
         1、__NSPlaceholderDictionary
         2、__NSDictionaryM
         */
        
        //初始化
        [NSObject method_exchangeWithMethodClass:NSClassFromString(@"__NSPlaceholderDictionary")
                                          sysSEL:NSSelectorFromString(@"initWithObjects:forKeys:count:")
                                         safeSEL:@selector(safe_initWithObjects:forKeys:count:)];

        //存数据
        [NSObject method_exchangeWithMethodClass:NSClassFromString(@"__NSDictionaryM")
                                          sysSEL:NSSelectorFromString(@"setObject:forKey:")
                                         safeSEL:@selector(safe_setObject:key:)];
    });
}

- (void)safe_setObject:(id)object key:(NSString *)key {
    @try {
        [self safe_setObject:object key:key];
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
    } @finally {
    }
}

- (instancetype)safe_initWithObjects:(id *)objects forKeys:(id *)keys count:(NSUInteger)cnt {
    @try {
        return [self safe_initWithObjects:objects forKeys:keys count:cnt];
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
        return nil;
    } @finally {
    }
//    for (int i=0; i<cnt; i++) {
//        if (!objects[i]) {
//            return nil;
//        }
//    }
//    return [self safe_initWithObjects:objects forKeys:keys count:cnt];
}

@end
