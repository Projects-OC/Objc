//
//  BrowerTableViewCell.m
//  Object-CDemo
//
//  Created by Mac on 2018/3/26.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "BCell.h"

@implementation BCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self setupView];
    }
    return self;
}
- (void)setupView {
    [self.contentView addSubview:self.imageView];
}

#pragma mark - Setter and getter

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    return _imageView;
}

@end
