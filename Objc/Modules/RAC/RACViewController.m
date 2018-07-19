
//
//  RACViewController.m
//  Object-CDemo
//
//  Created by mf on 2018/7/13.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "RACViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

//连接状态
typedef enum {
    StreamConnectionStateDisconnected = 0,
    StreamConnectionStateConnecting = 1,
    StreamConnectionStateConnected = 2,
    StreamConnectionStateAuthenticated = 3,
    StreamConnectionStateRequestConnecting=4,
} StreamConnectionState;


@interface RACViewController ()

/**网络状态*/
@property (nonatomic,strong) NSNumber *state;

@property (nonatomic,strong) UIButton *button;

@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) NSString *textString;

@property (nonatomic,strong) NSMutableArray *datas;

@end

@implementation RACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClick)];
}

/**
 KVO,delegate,notification,target-action
 */
- (void)msgSend {
    //KVO
    [RACObserve(self, textString) subscribeNext:^(id  _Nullable x) {
        
    }];
    //target - action
    _button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"点击了按钮");
        return [RACSignal empty];
    }];
    [[_button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
    }];
    //notification
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidChangeFrameNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        
    }];
    //delegate
    [[self rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(RACTuple * _Nullable x) {
        
    }];
}

/**
 数组KVO，动态监听barButton点击状态
 */
- (void)updateDatas {
    RAC(self,navigationItem.rightBarButtonItem.enabled) = [RACSignal combineLatest:@[RACObserve(self, datas)]
                                                                    reduce:^id (NSArray *datas){
                                                                        if (datas.count > 0) return @(YES);
                                                                        return @(NO);
                                                                    }];
    [[self mutableSetValueForKeyPath:NSStringFromSelector(@selector(datas))] addObject:@"addObject"];
    [[self mutableSetValueForKeyPath:NSStringFromSelector(@selector(datas))] removeAllObjects];
}

/**
 监听值的变化，map映射替换
 */
- (void)racObserveMap {
    [[RACObserve(self, state) map:^id _Nullable(NSNumber *state) {
        if ([state intValue] == StreamConnectionStateConnecting) {
            return @"(收取中...)";
        } else if ([state intValue] == StreamConnectionStateConnected) {
            return @"(收取中...)";
        } else if ([state intValue] == StreamConnectionStateDisconnected) {
            return @"(未连接)";
        } else {
            return @"";
        }
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

/**
 替换数组datas中model.selected属性为YES
 */
- (void)racSequenceMap {
    NSArray *flags = [[self.datas.rac_sequence map:^id _Nullable(id  _Nullable value) {
//        value.selected = YES;
        return value;
    }] array];
}

- (void)racFlattenMap {
    [[[RACObserve(self, datas) ignore:nil] flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"send"];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{}];
        }];
    }] subscribeNext:^(id  _Nullable x) {
        
    }];
}

/**
 两种监听textField/textView变化
 */
- (void)racTextField {
    RAC(self,textString) = self.textField.rac_textSignal;
    @weakify(self)
    [self.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        self.textString = x;
    }];
}

/**
 发出信号，订阅信号
 */
- (void)racSignalSubscribeNext {
    [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"发送数据"];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{}];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

- (void)rightBarButtonClick {
    
}

@end
