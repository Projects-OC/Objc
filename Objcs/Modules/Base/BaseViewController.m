//
//  BaseViewController.m
//  Object-CDemo
//
//  Created by Mac on 2018/3/21.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)dealloc {
    LCLog(@"dealloc %s",__func__);
}

@end
