//
//  FloatingViewController.m
//  Objcs
//
//  Created by wff on 2018/11/27.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "FloatingViewController.h"
#import "FloatingViewBtn.h"

@interface FloatingViewController ()

@end

@implementation FloatingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加浮窗" style:UIBarButtonItemStylePlain target:self action:@selector(addFloating)];
}

- (void)addFloating {
    [FloatingViewBtn showFloating];
}
@end
