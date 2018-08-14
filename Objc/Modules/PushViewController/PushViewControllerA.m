//
//  PushViewControllerA.m
//  Objc
//
//  Created by mf on 2018/8/2.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "PushViewControllerA.h"
#import "PushViewControllerC.h"
#import "PushViewControllerB.h"

@interface PushViewControllerA ()

@end

@implementation PushViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ctrl A";
    
    UILabel *_lb = [[UILabel alloc] initWithFrame:self.view.bounds];
    _lb.text = @"点击屏幕,ControllerA 跳转到 ControllerC";
    _lb.textAlignment = NSTextAlignmentCenter;
    _lb.textColor = [UIColor blueColor];
    [self.view addSubview:_lb];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSMutableArray *ctrls = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [ctrls addObject:[PushViewControllerB new]];
    [ctrls addObject:[PushViewControllerC new]];
    [self.navigationController setViewControllers:ctrls animated:YES];
}

- (void)dealloc {
    LCLog(@"dealloc %s",__func__);
}

@end
