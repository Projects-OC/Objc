//
//  main.m
//  Objcs
//
//  Created by wff on 2018/11/27.
//  Copyright © 2018年 mf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @try {
        @autoreleasepool {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        }
    } @catch (NSException *exception) {
        NSLog(@"Exception=%@\nStack Trace:%@",exception,[exception callStackSymbols]);
    } @finally {
        
    }
}
