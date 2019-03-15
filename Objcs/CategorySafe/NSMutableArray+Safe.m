//
//  NSMutableArray+Safe.m
//  Objcs
//
//  Created by header on 2019/3/5.
//  Copyright © 2019年 mf. All rights reserved.
//

#import "NSMutableArray+Safe.h"
#import "NSObject+MethodExchange.h"

@implementation NSMutableArray (Safe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        /**
         NSArray有四种类型
         1、__NSPlaceholderArray（站位数组）
         2、__NSArray0（初始化，无数据）
         3、__NSSingleObjectArrayI（只有一个数据）
         4、__NSArrayI（两个以上数据）
         */
        
        /**
         NSMutableArray有两种类型
         1、__NSPlaceholderArray（站位数组）
         2、__NSArrayM
         */
        
        //插入数据
        [NSObject method_exchangeWithMethodClass:NSClassFromString(@"__NSArrayM")
                                          sysSEL:NSSelectorFromString(@"insertObject:atIndex:")
                                         safeSEL:@selector(safe_insertObject:atIndex:)];

        
        //存数据
        [NSObject method_exchangeWithMethodClass:NSClassFromString(@"__NSArrayM")
                                          sysSEL:NSSelectorFromString(@"addObject:")
                                         safeSEL:@selector(safe_addObject:)];

        
        //取数据
        [NSObject method_exchangeWithMethodClass:NSClassFromString(@"__NSArrayM")
                                          sysSEL:NSSelectorFromString(@"objectAtIndex:")
                                         safeSEL:@selector(safe_objectAtIndex:)];

        [NSObject method_exchangeWithMethodClass:NSClassFromString(@"__NSArrayM")
                                          sysSEL:NSSelectorFromString(@"objectAtIndexedSubscript:")
                                         safeSEL:@selector(safe_objectAtIndexedSubscript:)];
    });
}

- (void)safe_insertObject:(id)object atIndex:(NSUInteger)index {
    @try {
        [self safe_insertObject:object atIndex:index];
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
    } @finally {
    }
}

- (void)safe_addObject:(id)object {
    @try {
        [self safe_addObject:object];
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
    } @finally {
        
    }
}

- (id)safe_objectAtIndex:(NSUInteger)index {
    @try {
        return [self safe_objectAtIndex:index];
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
        return nil;
    } @finally {
    }
//    if (index >= self.count) {
//        NSLog(@"越界-NSMutableArray-objectAtIndex:%@",self);
//        return nil;
//    }
//    return [self safe_objectAtIndex:index];
}

- (id)safe_objectAtIndexedSubscript:(NSUInteger)index {
    @try {
        return [self safe_objectAtIndexedSubscript:index];
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
        return nil;
    } @finally {
    }
//    if (index >= self.count) {
//        NSLog(@"越界-NSMutableArray-objectAtIndexedSubscript:%@",self);
//        return nil;
//    }
//    return [self safe_objectAtIndex:index];
}

@end
