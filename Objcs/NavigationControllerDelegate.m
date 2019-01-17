//
//  NavigationDelegate.m
//  Objcs
//
//  Created by header on 2018/12/7.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "NavigationControllerDelegate.h"
#import "OrientationOneViewController.h"
#import "OrientationTwoViewController.h"
#import "PlayerViewController.h"
#import "LFPhotoEditingController.h"

@implementation NavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //隐藏导航栏
    BOOL hidden = [viewController isKindOfClass:PlayerViewController.class] || [viewController isKindOfClass:LFPhotoEditingController.class];
    [navigationController setNavigationBarHidden:hidden animated:animated];
    
    NSString *ori = @"orientation";
    if ([viewController isKindOfClass:OrientationOneViewController.class]) {
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInt:UIDeviceOrientationLandscapeRight] forKey:ori];
    } else {
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInt:UIDeviceOrientationPortrait] forKey:ori];
    }
}
    
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}
    
    /*
    4.设置转场动画modalTransitionStyle
    
    1.系统的
    ForgetNameViewController *vc = [[ForgetNameViewController alloc] init];
    vc.vcType = ViewControllerTypeFindName;
    //    [self.navigationController pushViewController:vc animated:YES];
    
    IWNavigationController *nav = [[IWNavigationController alloc] initWithRootViewController:vc];
    [IWNavigationController setupWithType:IWNavTypeWhite];
    //nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;//以屏幕中间x为轴旋转
    //nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;//直接进入页面，无动画效果
    nav.modalTransitionStyle = UIModalTransitionStylePartialCurl;//翻页
    
    [self presentViewController:nav animated:YES completion:nil];
    2.自定义的
    　　　　1.创建个CATransition动画
    　　　　2.将动画添加到self.view.window.layer，注意：千万别忘了window
    　　　　3.presentViewController的时候，animated要设置为no
    　　　　4.dissmiss的时候，animated也要设置为no，并且，也要添加对应的动画
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [self.view.window.layer addAnimation:animation forKey:@"LoginViewController"];                   //  添加动作
    
    ForgetNameViewController *vc = [[ForgetNameViewController alloc] init];
    vc.vcType = ViewControllerTypeFindName;
    
    IWNavigationController *nav = [[IWNavigationController alloc] initWithRootViewController:vc];
    [IWNavigationController setupWithType:IWNavTypeWhite];
    
    [self presentViewController:nav animated:NO completion:^{
        [self.view.window.layer removeAnimationForKey:@"LoginViewController"];
    }];
    */
    
@end
