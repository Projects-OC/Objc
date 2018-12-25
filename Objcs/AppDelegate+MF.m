//
//  AppDelegate+MF.m
//  Objcs
//
//  Created by header on 2018/12/7.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "AppDelegate+MF.h"

static NSString *const UMKEY = @"";
static NSString *const BUGLYKEY = @"";

@implementation AppDelegate (MF)
    
- (void)appStatistics {
    [self bugly];
    [self umeng];
}
    
- (void)bugly {
    /*
#if TARGET_OS_SIMULATOR
    NSLog(@"模拟器");
#elif TARGET_OS_IPHONE
    NSLog(@"真机");
    [Bugly startWithAppId:BUGLYKEY];
#endif
     */
}
    
- (void)umeng {
    /*
    //开发者需要显式的调用此函数，日志系统才能工作
    [UMCommonLogManager setUpUMCommonLogManager];
    //    [UMConfigure setLogEnabled:YES];
    [UMConfigure initWithAppkey:UMKEY channel:@"App Store"];
    [MobClick setScenarioType:E_UM_GAME|E_UM_DPLUS];
    */
    
    //此函数在UMCommon.framework版本1.4.2及以上版本，在UMConfigure.h的头文件中加入。
    //如果用户用组件化SDK,需要升级最新的UMCommon.framework版本。
    /*
     NSString* deviceID =  [UMConfigure deviceIDForIntegration];
     NSLog(@"集成测试的deviceID:%@",deviceID);
     
     NSData* jsonData = [NSJSONSerialization dataWithJSONObject:@{@"oid" : deviceID}
     options:NSJSONWritingPrettyPrinted
     error:nil];
     NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
     */
}

@end
