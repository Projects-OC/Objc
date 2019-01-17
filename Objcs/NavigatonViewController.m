//
//  NavigatonViewController.m
//  Objc
//
//  Created by mf on 2018/8/2.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "NavigatonViewController.h"

@interface NavigatonViewController ()<UIGestureRecognizerDelegate>

@end

@implementation NavigatonViewController
    
+ (void)initialize {
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]]
                                       forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(popclick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *cusItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        //iOS11之前有效
        UIBarButtonItem *fixItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixItem.width = -15;
        viewController.navigationItem.leftBarButtonItems = @[fixItem,cusItem];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)popclick {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
    if ([self.topViewController respondsToSelector:@selector(popSEL)]) {
        [self.topViewController performSelector:@selector(popSEL)];
    }
#pragma clang diagnostic pop
    [self popViewControllerAnimated:YES];
}


@end
