//
//  WechatNavAnimationTransitionSecondViewController.m
//  Object-CDemo
//
//  Created by Mac on 2018/3/26.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "WechatNavAnimationTransitionSecondViewController.h"


@interface WechatNavAnimationTransitionSecondViewController ()
@property (nonatomic, strong) UIImageView *imgView;
@end

@implementation WechatNavAnimationTransitionSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"WeChatSecond";
    self.view.backgroundColor = [UIColor blackColor];
    
    UIImage *image = [UIImage imageNamed:@"wechat.jpg"];
    CGSize size = [self backImageSize:image];
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (kScreenHeight - size.height) * 0.5, size.width, size.height)];
    _imgView.image = image;
    _imgView.userInteractionEnabled = YES;
    [self.view addSubview:_imgView];
}

- (CGSize)backImageSize:(UIImage *)image{
    CGSize size = image.size;
    CGSize newSize;
    newSize.width = kScreenWidth;
    newSize.height = newSize.width / size.width * size.height;    
    return newSize;
}

@end
