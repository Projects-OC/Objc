//
//  MFWebKitViewController.m
//  MFWebKit
//
//  Created by mf on 2018/1/4.
//  Copyright © 2018年 mftechs. All rights reserved.
//

#import "MFWebKitViewController.h"

#define mfWidth ([UIScreen mainScreen].bounds.size.width)
#define mfHeight ([UIScreen mainScreen].bounds.size.height)
#define mfIPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define mfStatusBarHeight (mfIPhoneX ? 44:20)

@interface MFWebKitViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic,strong) WKWebViewConfiguration *webConfig;
@property (nonatomic,strong) UIView *progressView;

@end

@implementation MFWebKitViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = !_isNavigationBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:self.webConfig];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_url];
    [_webView loadRequest:request];
    [_webView addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (WKWebViewConfiguration *)webConfig{
    if (!_webConfig) {
        _webConfig = [WKWebViewConfiguration new];
        WKUserContentController *userController = [WKUserContentController new];
        NSString *js = @" $('meta[name=description]').remove(); $('head').append( '<meta name=\"viewport\" content=\"width=device-width, initial-scale=1,user-scalable=no\">' );";
        WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
        [userController addUserScript:script];
        [userController addScriptMessageHandler:self name:@"openInfo"];
        _webConfig.userContentController = userController;
    }
    return _webConfig;
}

-(UIView *)progressView{
    if (!_progressView) {
        _progressView = [UIView new];
        [_progressView setFrame:CGRectMake(0, mfStatusBarHeight, CGFLOAT_MIN, 2)];
        [self.view addSubview:_progressView];
        _progressView.backgroundColor = _progressColor ?: [UIColor blueColor];
        [self.view bringSubviewToFront:_progressView];
    }
    return _progressView;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"loading"]) {
    }else if ([keyPath isEqualToString:@"title"]){
        self.title = _webView.title;
    }else if ([keyPath isEqualToString:@"estimatedProgress"]){
        /**
         不显示进度条
         */
        if (!_isProgressView) {
            return;
        }
        double progress = _webView.estimatedProgress;
        [UIView animateWithDuration:0.01 animations:^{
            self.progressView.alpha = 1.0;
        } completion:nil];
        [self updateProgressWidth:progress];
        if (_webView.estimatedProgress == 1.0) {
            [self hideProgress];
        }
    }
    if (!_webView.loading) {
        [self hideProgress];
    }
}

- (void)updateProgressWidth:(double)progress{
    CGRect frame = self.progressView.frame;
    frame.size.width = mfWidth*progress;
    self.progressView.frame = frame;
}

-(void)hideProgress{
    [UIView animateWithDuration:0.2 animations:^{
        self.progressView.alpha = 0.0;
    } completion:nil];
}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}

-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}

-(void)dealloc{
    _webView.UIDelegate = nil;
    _webView.navigationDelegate = nil;
    _webView.scrollView.delegate = nil;
    [_webView removeObserver:self forKeyPath:@"loading" context:nil];
    [_webView removeObserver:self forKeyPath:@"title" context:nil];
    [_webView removeObserver:self forKeyPath:@"estimatedProgress" context:nil];
}

@end
