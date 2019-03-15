//
//  NSArray+Safe.m
//  Objcs
//
//  Created by header on 2019/3/5.
//  Copyright © 2019年 mf. All rights reserved.
//

#import "NSArray+Safe.h"
#import "NSObject+MethodExchange.h"

/**
 __NSArrayI
 NSArray *a1 = @[@"1",@"2"];
 
 __NSArray0（仅仅初始化后不含有元素的数组）
 NSArray *a2 =  [[NSArray alloc] init];
 
 __NSSingleObjectArrayI（只有一个元素的数组）
 NSArray *a3 =  [[NSArray alloc] initWithObjects: @"1",nil];
 
 __NSPlaceholderArray（占位数组）
 NSArray *a4 =  [NSArray alloc];
 
 __NSArrayM（可变数组）
 NSMutableArray *a5 = [NSMutableArray array];
 */
@implementation NSArray (Safe)

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
        
        
        //初始化 存数据@[@""];
        //或[NSArray arrayWithObjects:@"", nil];
        [NSObject method_exchangeWithMethodClass:NSClassFromString(@"__NSPlaceholderArray")
                                          sysSEL:NSSelectorFromString(@"initWithObjects:count:")
                                         safeSEL:@selector(safe_initWithObjects:count:)];
        
        
        
        //取数据[a objectAtIndex:1];
        [NSObject method_exchangeWithMethodClass:NSClassFromString(@"__NSArrayI")
                                          sysSEL:NSSelectorFromString(@"objectAtIndex:")
                                         safeSEL:@selector(safeI_objectAtIndex:)];
        [NSObject method_exchangeWithMethodClass:NSClassFromString(@"__NSArray0")
                                          sysSEL:NSSelectorFromString(@"objectAtIndex:")
                                         safeSEL:@selector(safe0_objectAtIndex:)];
        [NSObject method_exchangeWithMethodClass:NSClassFromString(@"__NSSingleObjectArrayI")
                                          sysSEL:NSSelectorFromString(@"objectAtIndex:")
                                         safeSEL:@selector(safeSingle_objectAtIndex:)];

        //取数据a[1];
        [NSObject method_exchangeWithMethodClass:NSClassFromString(@"__NSArrayI")
                                          sysSEL:NSSelectorFromString(@"objectAtIndexedSubscript:")
                                         safeSEL:@selector(safeI_objectAtIndexedSubscript:)];
        [NSObject method_exchangeWithMethodClass:NSClassFromString(@"__NSArray0")
                                          sysSEL:NSSelectorFromString(@"objectAtIndexedSubscript:")
                                         safeSEL:@selector(safe0_objectAtIndexedSubscript:)];
        [NSObject method_exchangeWithMethodClass:NSClassFromString(@"__NSSingleObjectArrayI")
                                          sysSEL:NSSelectorFromString(@"objectAtIndexedSubscript:")
                                         safeSEL:@selector(safeSingle_objectAtIndexedSubscript:)];

    });
}

- (instancetype)safe_initWithObjects:(id *)objects count:(NSUInteger)cnt {
    @try {
        return [self safe_initWithObjects:objects count:cnt];
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
        return nil;
    } @finally {
        
    }
//    for (int i=0; i<cnt; i++) {
//        if (objects[i] == nil) {
//            return nil;
//        }
//    }
//    return [self safe_initWithObjects:objects count:cnt];
}


- (id)safeI_objectAtIndex:(NSUInteger)index {
    @try {
        return [self safeI_objectAtIndex:index];
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
        return nil;
    } @finally {
        
    }
//    if (index >= self.count) {
//        NSLog(@"越界-NSArrayI-objectAtIndex:%@",self);
//        return nil;
//    }
//    return [self safeI_objectAtIndex:index];
}
- (id)safe0_objectAtIndex:(NSUInteger)index {
    @try {
        return [self safe0_objectAtIndex:index];
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
        return nil;
    } @finally {
    }
//    if (index >= self.count) {
//        NSLog(@"越界-NSArray0-objectAtIndex:%@",self);
//        return nil;
//    }
//    return [self safe0_objectAtIndex:index];
}
- (id)safeSingle_objectAtIndex:(NSUInteger)index {
    @try {
        return [self safeSingle_objectAtIndex:index];
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
        return nil;
    } @finally {
    }
//    if (index >= self.count) {
//        NSLog(@"越界-NSArray-objectAtIndex:%@",self);
//        return nil;
//    }
//    return [self safeSingle_objectAtIndex:index];
}


- (id)safeI_objectAtIndexedSubscript:(NSUInteger)index {
    @try {
        return [self safeI_objectAtIndexedSubscript:index];
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
        return nil;
    } @finally {
    }
//    if (index >= self.count) {
//        NSLog(@"越界-NSArray-objectAtIndex:%@",self);
//        return nil;
//    }
//    return [self safeI_objectAtIndexedSubscript:index];
}
- (id)safe0_objectAtIndexedSubscript:(NSUInteger)index {
    @try {
        return [self safe0_objectAtIndexedSubscript:index];
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
        return nil;
    } @finally {
    }
//    if (index >= self.count) {
//        NSLog(@"越界-NSArray-objectAtIndex:%@",self);
//        return nil;
//    }
//    return [self safe0_objectAtIndexedSubscript:index];
}
- (id)safeSingle_objectAtIndexedSubscript:(NSUInteger)index {
    @try {
        return [self safeSingle_objectAtIndexedSubscript:index];
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
        return nil;
    } @finally {
    }
//    if (index >= self.count) {
//        NSLog(@"越界-NSArray-objectAtIndex:%@",self);
//        return nil;
//    }
//    return [self safeSingle_objectAtIndexedSubscript:index];
}


@end
