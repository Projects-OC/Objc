//
//  TaobaoTableViewCell.m
//  Object-CDemo
//
//  Created by Mac on 2018/3/26.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "TaobaoTableViewCell.h"

@implementation TaobaoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    self.backgroundColor = [UIColor colorWithRed:0.1 green:0.7 blue:0.4 alpha:1];
    _imgView = [[UIImageView alloc] init];
    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    _imgView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_imgView];
}

- (void)setImageForImgView:(UIImage *)image{
    CGSize size = [self backImageNewSize:image.size];
    _imgView.frame = CGRectMake(16, 0, size.width, size.height);
    _imgView.image = image;
    _cellHeight = size.height + 40;
}

- (CGSize)backImageNewSize:(CGSize)size{
    CGSize newSize;
    newSize.height = 200;
    newSize.width = newSize.height / size.height * size.width;
    
    return newSize;
}


@end
