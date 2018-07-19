//
//  TaobaoSecondViewController.m
//  Object-CDemo
//
//  Created by Mac on 2018/3/26.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "TaobaoSecondViewController.h"

@interface TaobaoSecondViewController ()
@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation TaobaoSecondViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _imgView.hidden = YES;
//    self.navigationController.navigationBarHidden = NO;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.1 green:0.7 blue:0.4 alpha:1];

    self.title = @"WeChatSecond";

    _imgView = [[UIImageView alloc] initWithFrame:self.imgFrame];
    _imgView.image = self.image;
    _imgView.userInteractionEnabled = YES;
    [self.view addSubview:_imgView];
}


@end
