//
//  PushViewControllerB.m
//  Objc
//
//  Created by mf on 2018/8/2.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "PushViewControllerB.h"

@interface PushViewControllerB ()

@end

@implementation PushViewControllerB

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ctrl B";
}

- (void)dealloc {
    LCLog(@"dealloc %s",__func__);
}

@end
