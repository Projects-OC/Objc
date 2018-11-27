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

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NavigatonViewController *mainNav = [[NavigatonViewController alloc] initWithRootViewController:[[MainTableViewController alloc] init]];
    NavigatonViewController *msgNav = [[NavigatonViewController alloc] initWithRootViewController:[[MsgViewController alloc] init]];
    
    UITabBarItem *mainTabBar = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
    mainNav.title = @"首页";
    mainNav.tabBarItem = mainTabBar;
    
    UITabBarItem *msgTabBar = [[UITabBarItem alloc] initWithTitle:@"其他" image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
    msgNav.title = @"其他";
    msgNav.tabBarItem = msgTabBar;
    
    self.viewControllers = @[mainNav,msgNav];
    self.selectedIndex = 1;
}

@end
