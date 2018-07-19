//
//  BaseViewController.m
//  Object-CDemo
//
//  Created by Mac on 2018/3/21.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic,copy) NSArray *array;
@property (nonatomic,strong) NSMutableArray *mutableArray;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)properyCopy{
    self.array = [NSArray array];
    self.mutableArray = [NSMutableArray arrayWithObject:@"1"];
    self.array = self.mutableArray;
    NSLog(@"%@",self.array);//1
    [self.mutableArray addObject:@"2"];
    NSLog(@"%@",self.array);//1
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITapGestureRecognizer*  tapGesture = [[UITapGestureRecognizer alloc] init];
    [tapGesture addTarget:self action:@selector(tapViewDismiss)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)tapViewDismiss {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
