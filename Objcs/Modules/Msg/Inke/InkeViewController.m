//
//  InkeViewController.m
//  Objcs
//
//  Created by header on 2018/12/7.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "InkeViewController.h"
#import "InkeModel.h"
@class InkeListModel;

@interface InkeViewController ()

@end

@implementation InkeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

- (void)loadData {
    //@"http://live.9158.com/Room/GetNewRoomOnline?page=%ld"
    NSString *url = @"http://live.9158.com/Room/GetNewRoomOnline";
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    req.HTTPMethod = @"GET";
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
    }];
    [task resume];
    
    
}

@end
