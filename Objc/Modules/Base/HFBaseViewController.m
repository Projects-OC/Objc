//
//  HFBaseViewController.m
//  HF_Client_iPhone_Application
//
//  Created by header on 2018/9/21.
//  Copyright © 2018年 HengFeng. All rights reserved.
//

#import "HFBaseViewController.h"

@interface HFBaseViewController ()

@end

@implementation HFBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.page = 1;
}

- (void)dealloc{
    NSLog(@"dealloc %s",__func__);
}

@end
