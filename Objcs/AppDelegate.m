//
//  AppDelegate.m
//  Objc
//
//  Created by mf on 2018/7/19.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forBarMetrics:UIBarMetricsDefault];

    //禁止程序运行时自动锁屏
//    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    //    NSTimer *_timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    //    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    self.window.rootViewController = [[TabBarViewController alloc] init];
    
    [self.window makeKeyAndVisible];

    return YES;
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
    
    //    UIApplication* app
    //    = [UIApplication sharedApplication];
    //    __block UIBackgroundTaskIdentifier
    //    bgTask;
    //    bgTask=
    //    [app beginBackgroundTaskWithExpirationHandler:^{
    //        dispatch_async(dispatch_get_main_queue(),^{
    //            if(bgTask
    //               != UIBackgroundTaskInvalid)
    //            {
    //                bgTask=
    //                UIBackgroundTaskInvalid;
    //            }
    //        });
    //    }];
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),^{
    //        dispatch_async(dispatch_get_main_queue(),^{
    //            if(bgTask
    //               != UIBackgroundTaskInvalid)
    //            {
    //                bgTask=
    //                UIBackgroundTaskInvalid;
    //            }
    //        });
    //    });
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
