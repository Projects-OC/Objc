//
//  MFWebKitViewController+Native.m
//  Objcs
//
//  Created by header on 2019/7/17.
//  Copyright © 2019年 mf. All rights reserved.
//

#import "MFWebKitViewController+Native.h"

@interface MFWebKitViewController ()<WKScriptMessageHandler>

@end

@implementation MFWebKitViewController (Native)

- (void)shareWithParams:(NSDictionary *)params {
    if (![params isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSDictionary *dic = @{@"key" : @"value"};
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    // 将分享结果返回给js
    // windown.native，JS定，
    NSString *jsStr = [NSString stringWithFormat:@"window.native.shareResult('%@')",json];
    [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"%@----%@",result, error);
    }];
}

- (void)goBack {
    [self.webView goBack];
}

- (void)addMessageScripe {
    WKUserContentController *userContentController = self.webView.configuration.userContentController;
    [userContentController addScriptMessageHandler:self name:@"Share"];
    [userContentController addScriptMessageHandler:self name:@"GoBack"];
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"Share"]) {
        [self shareWithParams:message.body];
    } else if ([message.name isEqualToString:@"GoBack"]) {
        [self goBack];
    }
}

- (void)dealloc {
    WKUserContentController *userContentController = self.webView.configuration.userContentController;
    [userContentController removeScriptMessageHandlerForName:@"Share"];
}

@end
