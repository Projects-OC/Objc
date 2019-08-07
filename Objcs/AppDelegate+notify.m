//
//  AppDelegate+notify.m
//  Objcs
//
//  Created by header on 2019/7/25.
//  Copyright © 2019 mf. All rights reserved.
//

#import "AppDelegate+notify.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate (notify)

- (void)registerNotifyWithApplication:(UIApplication *)application {
    if (@available(iOS 10,*)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionAlert | UNAuthorizationOptionSound
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  if (granted) {
                                      //用户授权
                                      
                                  }
                              }];
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            //获取授权信息
        }];
        [self setNotify];
    } else {
        //iOS8 ~ iOS10
        UIUserNotificationSettings *setting = [UIUserNotificationSettings
                                               settingsForTypes:
                                               UIUserNotificationTypeBadge |
                                               UIUserNotificationTypeAlert |
                                               UIUserNotificationTypeSound
                                               categories:nil];
        [application registerUserNotificationSettings:setting];
    }
    [application registerForRemoteNotifications];
}

- (void)setNotify {
    if (@available(iOS 10,*)) {
        [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:self.notifyCategory];
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:self.notifyRequest
                                                               withCompletionHandler:^(NSError * _Nullable error) {
                                                           
                                                               }];
    }
}

- (NSSet <UNNotificationCategory *>*)notifyCategory  API_AVAILABLE(ios(10.0)){
    if (@available(iOS 10,*)) {
        UNTextInputNotificationAction *inputAction = [UNTextInputNotificationAction actionWithIdentifier:@"action.input"
                                                                                                   title:@"标题"
                                                                                                 options:UNNotificationActionOptionForeground
                                                                                    textInputButtonTitle:@"发送"
                                                                                    textInputPlaceholder:@"输入发送内容"];
        
        UNNotificationAction *likeAction = [UNNotificationAction actionWithIdentifier:@"action.like"
                                                                                title:@"喜欢"
                                                                              options:UNNotificationActionOptionForeground];
        
        UNNotificationAction *cancelAction = [UNNotificationAction actionWithIdentifier:@"action.cancel"
                                                                                  title:@"取消"
                                                                                options:UNNotificationActionOptionDestructive];
        UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"category"
                                                                                  actions:@[inputAction,likeAction,cancelAction]
                                                                        intentIdentifiers:@[]
                                                                                  options:UNNotificationCategoryOptionCustomDismissAction];
        return [NSSet setWithObject:category];
    }
    return nil;
}

- (UNNotificationRequest *)notifyRequest  API_AVAILABLE(ios(10.0)){
    if (@available(iOS 10,*)) {
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"通知title";
        content.subtitle = @"通知副标题";
        
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:60 repeats:YES];
        
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"obj.notification"
                                                                              content:content
                                                                              trigger:trigger];
        return request;
    }
    return nil;
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(nonnull UNNotificationResponse *)response
         withCompletionHandler:(nonnull void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    NSString *actionIdentifier = response.actionIdentifier;
    // 输入框
    if ([actionIdentifier isKindOfClass:UNTextInputNotificationAction.class]) {
        
    }
    
    // 喜欢
    if ([actionIdentifier isEqualToString:@"action.like"]) {
        
    }
}


@end
