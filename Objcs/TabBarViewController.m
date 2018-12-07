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
#import "NavigatonViewController.h"
#import "NavigationControllerDelegate.h"
#import "OrientationOneViewController.h"
#import "OrientationTwoViewController.h"

@interface TabBarViewController ()

/**要使用全局变量*/
@property (nonatomic,strong) NavigationControllerDelegate *del;
    
@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.del = [NavigationControllerDelegate new];
   
    NavigatonViewController *mainNav = [[NavigatonViewController alloc] initWithRootViewController:[[MainTableViewController alloc] init]];
    mainNav.delegate = self.del;
    
    NavigatonViewController *msgNav = [[NavigatonViewController alloc] initWithRootViewController:[[MsgViewController alloc] init]];
    msgNav.delegate = self.del;
    
    UITabBarItem *mainTabBar = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
    mainNav.title = @"首页";
    mainNav.tabBarItem = mainTabBar;
    
    UITabBarItem *msgTabBar = [[UITabBarItem alloc] initWithTitle:@"其他" image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
    msgNav.title = @"其他";
    msgNav.tabBarItem = msgTabBar;
    
    self.viewControllers = @[mainNav,msgNav];
    self.selectedIndex = 1;
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
