//
//  TabBarViewController.m
//  Objc
//
//  Created by mf on 2018/8/2.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "TabBarViewController.h"
#import "MainTableViewController.h"
#import "MsgViewController.h"
#import "AppleViewController.h"

#import "NavigatonViewController.h"
#import "NavigationControllerDelegate.h"
#import "OrientationOneViewController.h"
#import "OrientationTwoViewController.h"

#import "TabBar.h"

@interface TabBarViewController ()

/**要使用全局变量*/
@property (nonatomic,strong) NavigationControllerDelegate *del;
    
@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TabBar *tabbar = [[TabBar alloc] init];
    [self setValue:tabbar forKey:@"tabBar"];
    tabbar.appleHandle = ^{
        self.selectedIndex = 1;
    };
    
    self.del = [NavigationControllerDelegate new];
    
    [self addChildCtrl:MainTableViewController.new title:@"首页"];
    [self addChildCtrl:AppleViewController.new title:@"Apple"];
    [self addChildCtrl:MsgViewController.new title:@"其他"];
}

- (void)addChildCtrl:(UIViewController *)ctrl title:(NSString *)title {
    NavigatonViewController *nav = [[NavigatonViewController alloc] initWithRootViewController:ctrl];
    nav.delegate = self.del;
    
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
    nav.title = title;
    nav.tabBarItem = tabBarItem;
    
    [self addChildViewController:nav];
}

- (BOOL)shouldAutorotate{
    return YES;
}
    
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    if (!self.viewControllers) {
        return UIInterfaceOrientationMaskPortrait;
    }
    UINavigationController *nav = self.viewControllers.firstObject;
    if([nav.topViewController isKindOfClass:OrientationOneViewController.class]){
        return UIInterfaceOrientationMaskLandscapeRight;
    }
    return UIInterfaceOrientationMaskPortrait;
}

@end
