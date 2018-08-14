//
//  WechatNavAnimationTransitionViewController.m
//  Object-CDemo
//
//  Created by Mac on 2018/3/26.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "WechatNavAnimationTransitionViewController.h"
#import "WechatNavAnimationTransitionSecondViewController.h"
#import "WeChatNavAnimationTransition.h"

@interface WechatNavAnimationTransitionViewController ()
@property (nonatomic,strong) WeChatNavAnimationTransition *animatedTransition;
@end

@implementation WechatNavAnimationTransitionViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.animatedTransition = nil;
    self.navigationController.delegate = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"WeChat";
    self.view.backgroundColor = bgColor;
    
    UIImage *img = [UIImage imageNamed:@"wechat.jpg"];
    CGSize size;
    size.height = 120;
    size.width = size.height / img.size.height * img.size.width;
    
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(70, 70, size.width, size.height)];
        imageView.image = img;
        imageView.userInteractionEnabled = YES;
        [self.view addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushSecond:)];
        [imageView addGestureRecognizer:tap];
    }
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(170, 270, size.width, size.height)];
        imageView.image = img;
        imageView.userInteractionEnabled = YES;
        [self.view addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushSecond:)];
        [imageView addGestureRecognizer:tap];
    }
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(70, 400, size.width, size.height)];
        imageView.image = img;
        imageView.userInteractionEnabled = YES;
        [self.view addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushSecond:)];
        [imageView addGestureRecognizer:tap];
    }
}

- (void)pushSecond:(UITapGestureRecognizer *)tap{
    UIImageView *img = (UIImageView *)tap.view;
    //1. 设置代理
    self.animatedTransition = nil;
    self.navigationController.delegate = self.animatedTransition;
    
    //2. 传入必要的3个参数
    [self.animatedTransition setTransitionImgView:img];
    [self.animatedTransition setTransitionBeforeImgFrame:img.frame];
    [self.animatedTransition setTransitionAfterImgFrame:[self backScreenImageViewRectWithImage:img.image]];
    
    //3.push跳转
    WechatNavAnimationTransitionSecondViewController *second = [[WechatNavAnimationTransitionSecondViewController alloc] init];
    [self.navigationController pushViewController:second animated:YES];
}

- (WeChatNavAnimationTransition *)animatedTransition{
    if (!_animatedTransition) {
        _animatedTransition = [[WeChatNavAnimationTransition alloc] init];
    }
    return _animatedTransition;
}

//返回imageView在window上全屏显示时的frame
- (CGRect)backScreenImageViewRectWithImage:(UIImage *)image{
    
    CGSize size = image.size;
    CGSize newSize;
    newSize.width = LCScreenWidth;
    newSize.height = newSize.width / size.width * size.height;
    
    CGFloat imageY = (kScreenHeight - newSize.height) * 0.5;
    
    if (imageY < 0) {
        imageY = 0;
    }
    CGRect rect =  CGRectMake(0, imageY, newSize.width, newSize.height);
    
    return rect;
}

@end
