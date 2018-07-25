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

@property (nonatomic,copy) NSDictionary *dic;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)properyArrayCopy{
    self.array = [NSArray array];
    self.mutableArray = [NSMutableArray arrayWithObject:@"1"];
    self.array = self.mutableArray;
    NSLog(@"%@",self.array);//1
    [self.mutableArray addObject:@"2"];
    NSLog(@"%@",self.array);//1
}

- (void)propertyDictionaryCopy {
    self.dic = @{@"key1":@"1",@"key2":@"2"};
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithObject:@"3" forKey:@"key3"];
    NSLog(@" %@",_dic);
    self.dic = mutableDic;
    NSLog(@" %@",_dic);
    [mutableDic addEntriesFromDictionary:@{@"key4":@"4"}];
    NSLog(@" %@",_dic);
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
