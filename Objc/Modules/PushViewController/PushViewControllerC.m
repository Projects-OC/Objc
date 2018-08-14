//
//  PushViewControllerC.m
//  Objc
//
//  Created by mf on 2018/8/2.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "PushViewControllerC.h"
#import "PushViewControllerB.h"

@interface PushViewControllerC ()

@end

@implementation PushViewControllerC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ctrl C";
    
    UILabel *_lb = [[UILabel alloc] initWithFrame:self.view.bounds];
    _lb.text = @"点击屏幕,pop到Controller B";
    _lb.textAlignment = NSTextAlignmentCenter;
    _lb.textColor = [UIColor blueColor];
    [self.view addSubview:_lb];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[PushViewControllerB class]]) {
            [self.navigationController popToViewController:obj animated:YES];
        }
    }];
}

- (void)dealloc {
    LCLog(@"dealloc %s",__func__);
}

@end
