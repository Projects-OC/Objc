//
//  TransitionsViewController.m
//  Object-CDemo
//
//  Created by Mac on 2018/3/22.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "TransitionsViewController.h"
#import "TransitionsViewController.h"
#import "CrossDissolveAnimatedTransition.h"

@interface TransitionsViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation TransitionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"transitions" style:UIBarButtonItemStylePlain target:self action:@selector(transitionClick)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点击返回" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn setFrame:CGRectMake(0, 0, 100, 100)];
}

- (void)transitionClick{
    TransitionsViewController *transitionVc = [[TransitionsViewController alloc] init];
    transitionVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:transitionVc animated:YES completion:nil];
}

#pragma TransitioningDelegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [[CrossDissolveAnimatedTransition alloc] init];
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[CrossDissolveAnimatedTransition alloc] init];
}

- (void)backClick{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
