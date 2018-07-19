//
//  AppDelegate.m
//  Objc
//
//  Created by mf on 2018/7/19.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "AppDelegate.h"
#import "TableViewController.h"
#import "BaseObject.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[TableViewController alloc] init]];
    
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    tabBar.viewControllers = @[nav];
    self.window.rootViewController = tabBar;
    
    //    NSTimer *_timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    //    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    [self terminationTitles:@"1",@"2",@"3", nil];
    [self arrayValueForKey];
    
    return YES;
}



//多参数传递
- (void)terminationTitles:(NSString *)titles, ...NS_REQUIRES_NIL_TERMINATION{
    NSMutableArray* arrays = [NSMutableArray array];
    NSLog(@"title = %@",titles);
    if (titles){
        [arrays addObject:titles];
        NSString* subTitle;
        va_list argumentList;
        va_start(argumentList, titles);
        while((subTitle = va_arg(argumentList, id))){
            [arrays addObject:subTitle];
            NSLog(@"%@",subTitle);
        }
        va_end(argumentList);
    }
}

//
- (void)timerTick:(NSTimer *)timer{
    NSLog(@"定时器--------");
}

//筛选model中某一属性组成新数组
- (void)arrayValueForKey{
    NSInteger cot = 20;
    NSMutableArray *datas = [NSMutableArray arrayWithCapacity:cot];
    for (int i=0; i<cot; i++) {
        BaseObject *obj = [BaseObject new];
        obj.name = @(i).stringValue;
        obj.sex = [@"man-" stringByAppendingString:@(i).stringValue];
        [datas addObject:obj];
    }
    NSArray *objs = [datas valueForKey:NSStringFromSelector(@selector(sex))];
    NSLog(@"%@",objs);
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
