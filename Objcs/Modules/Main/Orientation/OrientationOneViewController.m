//
//  OrientationOneViewController.m
//  Objcs
//
//  Created by header on 2018/12/7.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "OrientationOneViewController.h"
#import "OrientationTwoViewController.h"

@interface OrientationOneViewController ()

@end

@implementation OrientationOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"Orientation111");
    
    UILabel *lb = [UILabel new];
    lb.text = @"点击页面";
    lb.textAlignment = NSTextAlignmentCenter;
    lb.backgroundColor = [UIColor greenColor];
    [self.view addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController pushViewController:[OrientationTwoViewController new] animated:YES];
}
    
@end
