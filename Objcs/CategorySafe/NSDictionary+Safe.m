//
//  NSDictionary+Safe.m
//  Objcs
//
//  Created by header on 2019/3/5.
//  Copyright © 2019年 mf. All rights reserved.
//

#import "NSDictionary+Safe.h"
#import "NSObject+MethodExchange.h"

@implementation NSDictionary (Safe)

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
        
        [NSObject method_exchangeWithMethodClass:NSClassFromString(@"__NSPlaceholderDictionary")
                                          sysSEL:NSSelectorFromString(@"initWithObjects:forKeys:count:")
                                         safeSEL:@selector(safe_initWithObjects:forKeys:count:)];

//        [NSObject method_exchangeWithMethodClass:NSClassFromString(@"__NSPlaceholderDictionary")
//                                          sysSEL:NSSelectorFromString(@"initWithObjectsAndKeys:")
//                                         safeSEL:@selector(safe_initWithObjectsAndKeys:)];
        
        [NSObject method_exchangeWithMethodClass:NSClassFromString(@"__NSDictionaryI")
                                          sysSEL:NSSelectorFromString(@"dictionaryWithObjectsAndKeys:")
                                         safeSEL:@selector(safe_dictionaryWithObjectsAndKeys:)];

    });
}


- (instancetype)safe_dictionaryWithObjectsAndKeys:(id)firstObject, ... {
    @try {
        id eachObject;
        va_list argumentList;
        va_start(argumentList, firstObject);
        while((eachObject = va_arg(argumentList, id))){
            NSLog(@"eachObject = %@",eachObject);
        }
        va_end(argumentList);
        return [self safe_dictionaryWithObjectsAndKeys:firstObject];
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
        return nil;
    } @finally {
    }
}

- (instancetype)safe_initWithObjectsAndKeys:(id)firstObject, ...  {
    @try {
        return [self safe_initWithObjectsAndKeys:firstObject];
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
        return nil;
    } @finally {
    }
}

- (instancetype)safe_initWithObjects:(id *)objects forKeys:(id *)keys count:(NSUInteger)count {
    @try {
        return [self safe_initWithObjects:objects forKeys:keys count:count];
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
