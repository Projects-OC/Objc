//
//  OneViewController.m
//  Objc
//
//  Created by mf on 2018/7/31.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "OneViewController.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"title2";

    // 图片
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sinojerk"]];
    imageView.frame = CGRectMake(0, 400, self.view.frame.size.width, self.view.frame.size.width/2.2);
    [self.view addSubview:imageView];
    
    // 动画
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = CGRectMake(0, 90, self.view.frame.size.width, self.view.frame.size.width/2.2);
    } completion:^(BOOL finished) {
        // 动画结束后移除view
//        [whiteView removeFromSuperview];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
