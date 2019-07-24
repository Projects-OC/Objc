//
//  InputKeyboardView.m
//  Objcs
//
//  Created by header on 2019/7/23.
//  Copyright © 2019 mf. All rights reserved.
//

#import "InputKeyboardView.h"
#import "InputKeyboardTextView.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

static float toolBarHeight = 48;
static int maxNumberOfLines = 4;
static float inputMargin = 10;
static float sendMargin = 21;

@interface InputKeyboardView ()<UITextViewDelegate>

//输入框
@property (nonatomic,strong) InputKeyboardTextView *textView;

@property (nonatomic,strong) UIView *backgroundControl;

//键盘高度
@property (nonatomic,assign) float keyboardHeight;

//toolBarView
@property (nonatomic,strong) UIView *toolBarView;

@property (nonatomic,strong) UIButton *sendView;


@end

@implementation InputKeyboardView

+ (InputKeyboardView *)keyboardView {
    InputKeyboardView *kb = [[InputKeyboardView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    [UIApplication.sharedApplication.keyWindow addSubview:kb];
    return kb;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundControl = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
        self.backgroundControl.backgroundColor = [UIColor blackColor];
        self.backgroundControl.alpha = 0;
        self.backgroundControl.userInteractionEnabled = YES;
        [self.backgroundControl addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)]];
        [self addSubview:self.backgroundControl];
        
        [self addSubview:self.toolBarView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
    }
    return  self;
}

- (UIView *)toolBarView {
    if (!_toolBarView) {
        _toolBarView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight, kWidth, toolBarHeight)];
        _toolBarView.backgroundColor = [UIColor whiteColor];
        
        [_toolBarView addSubview:self.sendView];
        [_sendView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(toolBarHeight);
            make.right.mas_equalTo(-sendMargin);
        }];
        
        [_toolBarView addSubview:self.textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.right.mas_equalTo(self.sendView.mas_left).offset(-sendMargin);
            make.top.mas_equalTo(inputMargin);
            make.bottom.mas_equalTo(-inputMargin);
        }];
    }
    return _toolBarView;
}

- (UIButton *)sendView {
    if (!_sendView) {
        _sendView = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendView setEnabled:NO];
        [_sendView setTitle:@"发送" forState:UIControlStateNormal];
        [_sendView addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
        [_sendView setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_sendView setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        _sendView.titleLabel.font = [UIFont systemFontOfSize:16];
        
    }
    return _sendView;
}

- (InputKeyboardTextView *)textView{
    if (!_textView) {
        _textView = [InputKeyboardTextView new];
        _textView.delegate = self;
        _textView.maxNumberOfLines = maxNumberOfLines;
        [_textView becomeFirstResponder];
        
        __weak typeof (self) weakSelf = self;
        _textView.inputBlock = ^(CGFloat height) {
            [weakSelf sendViewStatus];
            [weakSelf dynamicHeight:height];
        };
    }
    return _textView;
}

- (void)dynamicHeight:(CGFloat)height {
    CGRect textframe = self.textView.frame;
    textframe.size.height = height;
    self.textView.frame = textframe;
    
    CGRect toolframe = self.toolBarView.frame;
    toolframe.size.height = height + inputMargin*2;
    toolframe.origin.y = kHeight-toolframe.size.height-_keyboardHeight;
    self.toolBarView.frame = toolframe;
}

- (void)sendClick {
    if (_sendBlock) {
        _sendBlock(_textView.text);
    }
    _textView.text = @"";
    [self tapClick];
}

- (void)tapClick {
    [_textView resignFirstResponder];
}

- (void)sendViewStatus {
    if (_textView.text.length > 0) {
        _sendView.enabled = YES;
    } else {
        _sendView.enabled = NO;
    }
}

- (void)didMoveToSuperview {
    if (self.superview) {
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundControl.alpha = 0.3;
        }];
    }
}

- (BOOL)becomeFirstResponder {
    [super becomeFirstResponder];
    return [_textView becomeFirstResponder];
}

- (void)keyboardWillShow:(NSNotification *)noti {
    NSDictionary *userInfo = noti.userInfo;
    CGRect frame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _keyboardHeight = frame.size.height;
    
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration delay:0 options:[noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue] animations:^{
        self.toolBarView.frame = CGRectMake(0, kHeight-_keyboardHeight-toolBarHeight, kWidth, toolBarHeight);
    } completion:nil];
}

- (void)keyboardWillHide {
    [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.backgroundControl.alpha = 0;
        self.toolBarView.frame = CGRectMake(0, kHeight, kWidth, toolBarHeight);
    } completion:^(BOOL finished) {
        [self.textView removeFromSuperview];
        [self.toolBarView removeFromSuperview];
        [self.sendView removeFromSuperview];
        [self.backgroundControl removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    [self sendViewStatus];
    // 换行符
    if ([text isEqualToString:@"\n"]) {
        return YES;
    }
    return YES;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.textView = nil;
    self.toolBarView = nil;
    self.sendView = nil;
    self.backgroundControl = nil;
}

@end
