//
//  InputKeyboardTextView.m
//  Objcs
//
//  Created by header on 2019/7/23.
//  Copyright © 2019 mf. All rights reserved.
//

#import "InputKeyboardTextView.h"

@interface InputKeyboardTextView ()

/**
 文字最大高度
 */
@property (nonatomic, assign) CGFloat maxTextH;

@end

@implementation InputKeyboardTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollEnabled = NO;
        self.scrollsToTop = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.enablesReturnKeyAutomatically = YES;
        
        self.layer.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0].CGColor;
        self.layer.cornerRadius = 14;
        self.font = [UIFont systemFontOfSize:14];
        self.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        [self becomeFirstResponder];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textDidChange {
    //计算高度
    CGFloat height = ceilf([self sizeThatFits:CGSizeMake(self.frame.size.width, MAXFLOAT)].height);
    //当textView大于最大高度的时候让其可以滚动
    if (height > _maxTextH) {
        height = _maxTextH;
        self.scrollEnabled = YES;
    } else {
        self.scrollEnabled = NO;
    }
    if (_inputBlock) {
        _inputBlock(height);
    }
    [self layoutIfNeeded];
}

- (void)setMaxNumberOfLines:(NSUInteger)maxNumberOfLines {
    _maxNumberOfLines = maxNumberOfLines;
    /**
     *  根据最大的行数计算textView的最大高度
     *  计算最大高度 = (每行高度 * 总行数 + 文字上下间距)
     */
    _maxTextH = ceil(self.font.lineHeight * maxNumberOfLines + self.textContainerInset.top + self.textContainerInset.bottom);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
