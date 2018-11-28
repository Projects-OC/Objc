//
//  PlayerViewController.m
//  Objcs
//
//  Created by header on 2018/11/28.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "PlayerViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface PlayerViewController ()

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    [options setPlayerOptionIntValue:1 forKey:@"videotoolbox"];
    // 帧速率(fps) （可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97）
    [options setPlayerOptionIntValue:29.97 forKey:@"r"];
    //-vol——设置音量大小，256为标准音量。（要设置成两倍音量时则输入512，依此类推
    [options setPlayerOptionIntValue:512 forKey:@"vol"];
    IJKFFMoviePlayerController *moviePlayer = [[IJKFFMoviePlayerController alloc]initWithContentURLString:@"" withOptions:options];
    moviePlayer.view.frame = self.view.bounds;
    
    //填充fill
    moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    //设置自动播放(必须设置为NO, 防止自动播放, 才能更好的控制直播的状态)
    moviePlayer.shouldAutoplay = NO;
    //默认不显示
    moviePlayer.shouldShowHudView = NO;
    [self.view addSubview:moviePlayer.view];
    
    [moviePlayer play];
}

@end
