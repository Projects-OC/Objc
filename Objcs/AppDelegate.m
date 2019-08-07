//
//  AppDelegate.m
//  Objc
//
//  Created by mf on 2018/7/19.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"
#import "AppDelegate+MF.h"
#import "AppDelegate+Exception.h"
#import "AppDelegate+notify.h"

/**
 https://developer.apple.com/design/human-interface-guidelines/ios/icons-and-images/launch-screen/
 iPhone
 640px*960px，
 640px*1136px，
 750px*1334px，
 828px*1792px，
 1242px*2208px，
 1125px*2436px，
 1242px*2688px。
 
 iPad
 768px*1024px
 1536px*2048px，
 1668px*2224px，
 1668px*2388px，
 2048px*2732px。
 */

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [self timer];
    self.window.rootViewController = [[TabBarViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    [self registerNotifyWithApplication:application];
    
    NSDictionary *dict = @{
    @"1" : @"A",
    @"2" : @"A",
    @"3" : @"A",
    };
    id array = [dict allKeysForObject:@"A"] ;
    NSLog(@"%@",array);
    
    [self registerExceptionHandler];
    [self appStatistics];

    return YES;
}


- (void)timer {
    NSTimer *_timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

//
- (void)timerTick:(NSTimer *)timer{
    NSLog(@"定时器--------");
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
        UIApplication* app
        = [UIApplication sharedApplication];
        __block UIBackgroundTaskIdentifier
        bgTask;
        bgTask=
        [app beginBackgroundTaskWithExpirationHandler:^{
            dispatch_async(dispatch_get_main_queue(),^{
                if(bgTask
                   != UIBackgroundTaskInvalid)
                {
                    bgTask=
                    UIBackgroundTaskInvalid;
                }
            });
        }];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),^{
            dispatch_async(dispatch_get_main_queue(),^{
                if(bgTask
                   != UIBackgroundTaskInvalid)
                {
                    bgTask=
                    UIBackgroundTaskInvalid;
                }
            });
        });
}


@end
