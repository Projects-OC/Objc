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

@property(atomic, retain) id<IJKMediaPlayback> player;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initPlayer];
    [self installMovieNotificationObservers];
}
    
- (void)initPlayer {
    IJKFFOptions * options = [IJKFFOptions optionsByDefault];
    IJKFFMoviePlayerController * player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:@"rtmp://192.168.1.163:1935/rtmplive/demo" withOptions:options];
    self.player = player;
    self.player.view.frame = self.view.bounds;
    self.player.shouldAutoplay = YES;
    [self.view addSubview:self.player.view];
    
    [self.player prepareToPlay];
}
    
-(void)installMovieNotificationObservers {
    //监听网络环境，监听缓冲方法
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    //监听直播完成回调
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    //监听用户主动操作
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
}
    
- (void)loadStateDidChange:(NSNotification*)notification {
    //    MPMovieLoadStateUnknown        = 0,未知
    //    MPMovieLoadStatePlayable       = 1 << 0,缓冲结束可以播放
    //    MPMovieLoadStatePlaythroughOK  = 1 << 1, // Playback will be automatically started in this state when shouldAutoplay is YES 缓冲结束自动播放
    //    MPMovieLoadStateStalled        = 1 << 2, // Playback will be automatically paused in this state, if started
    //暂停
    
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStatePlaythroughOK: %d\n", (int)loadState);
    } else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}
    
- (void)moviePlayBackDidFinish:(NSNotification*)notification {
    //    MPMovieFinishReasonPlaybackEnded, 直播结束
    //    MPMovieFinishReasonPlaybackError, 直播错误
    //    MPMovieFinishReasonUserExited  用户退出
    int reason = [[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    
    switch (reason)
    {
        case IJKMPMovieFinishReasonPlaybackEnded:
        NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
        break;
        
        case IJKMPMovieFinishReasonUserExited:
        NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
        break;
        
        case IJKMPMovieFinishReasonPlaybackError:
        NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
        break;
        
        default:
        NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
        break;
    }
}
    
- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification {
    NSLog(@"mediaIsPreparedToPlayDidChange\n");
}
    
- (void)moviePlayBackStateDidChange:(NSNotification*)notification {
    //    MPMoviePlaybackStateStopped,
    //    MPMoviePlaybackStatePlaying,
    //    MPMoviePlaybackStatePaused,
    //    MPMoviePlaybackStateInterrupted,
    //    MPMoviePlaybackStateSeekingForward,
    //    MPMoviePlaybackStateSeekingBackward
    
    switch (_player.playbackState)
    {
        case IJKMPMoviePlaybackStateStopped: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePlaying: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            
            
            
            break;
        }
        case IJKMPMoviePlaybackStatePaused: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateInterrupted: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
}

- (void)popclick {
    [self.player shutdown];
}
    
/*
- (void)ijk {
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    [options setPlayerOptionIntValue:1 forKey:@"videotoolbox"];
    // 帧速率(fps) （可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97）
    [options setPlayerOptionIntValue:29.97 forKey:@"r"];
    //-vol——设置音量大小，256为标准音量。（要设置成两倍音量时则输入512，依此类推
    [options setPlayerOptionIntValue:512 forKey:@"vol"];
    IJKFFMoviePlayerController *moviePlayer = [[IJKFFMoviePlayerController alloc]initWithContentURLString:@"rtmp://192.168.1.163:1935/rtmplive/demo" withOptions:options];
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
*/

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
    
@end
