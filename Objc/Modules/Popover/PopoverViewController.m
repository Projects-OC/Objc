//
//  PopoverViewController.m
//  Object-CDemo
//
//  Created by Mac on 2018/3/23.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "PopoverViewController.h"
#import "PopoverPresentationController.h"

@interface PopoverViewController ()<UIPopoverPresentationControllerDelegate>

@property (nonatomic,strong) PopoverPresentationController *popVc;

@end

@implementation PopoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"leftPopover"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(itemPop:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"rightPopover"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(itemPop:)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"中间弹出" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(centerPop:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn setFrame:CGRectMake(100, 100, 100, 50)];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"返回" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    btn2.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn2];
    [btn2 setFrame:CGRectMake(100, self.view.frame.size.height-100, 100, 50)];
}

- (void)itemPop:(id)item {
    self.popVc.view.backgroundColor = [UIColor orangeColor];
    self.popVc.preferredContentSize = CGSizeMake(150, 150);    
    self.popVc.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController *popoverPresentationController = self.popVc.popoverPresentationController;
    popoverPresentationController.barButtonItem = item;
    popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popoverPresentationController.delegate = self;
    [self presentViewController:self.popVc animated:YES completion:nil];
    
    self.popVc.popoverPresentationController.backgroundColor = [UIColor clearColor];
}

- (void)centerPop:(UIButton *)sender{
    self.popVc.preferredContentSize = CGSizeMake(150, 150);
    self.popVc.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController *popoverPresentationController = self.popVc.popoverPresentationController;
    popoverPresentationController.sourceView = self.view;
//    popoverPresentationController.sourceRect = self.view.bounds;
    popoverPresentationController.sourceRect = CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height, 0, 0);
    popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;//箭头弹出方向
    popoverPresentationController.delegate = self;
    popoverPresentationController.backgroundColor = [UIColor clearColor];
    [self presentViewController:self.popVc animated:YES completion:nil];
}

//点击蒙版是否消失，默认为yes；
- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    return YES;
}

//弹框消失时调用的方法
- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    
    NSLog(@"弹框已经消失");
    
}

- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (PopoverPresentationController *)popVc{
    if (!_popVc) {
        _popVc = [[PopoverPresentationController alloc] init];
    }
    return _popVc;
}

#pragma mark - UIPopoverPresentationControllerDelegate
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

//- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection {
//    return UIModalPresentationNone;
//}

@end
