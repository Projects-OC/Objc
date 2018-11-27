//
//  LFLiveViewController.m
//  Objc
//
//  Created by header on 2018/11/27.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "LFLiveViewController.h"
#import "LFLivePreview.h"

@interface LFLiveViewController ()
@end

@implementation LFLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:[[LFLivePreview alloc] initWithFrame:self.view.bounds]];
}



@end
