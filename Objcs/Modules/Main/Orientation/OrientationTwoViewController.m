//
//  OrientationTwoViewController.m
//  Objcs
//
//  Created by header on 2018/12/7.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "OrientationTwoViewController.h"

@interface OrientationTwoViewController ()

@end

@implementation OrientationTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"Orientation2222");

    UILabel *lb = [UILabel new];
    lb.text = @"or 222";
    lb.textAlignment = NSTextAlignmentCenter;
    lb.backgroundColor = [UIColor greenColor];
    [self.view addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
}

@end
