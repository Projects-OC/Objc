//
//  TableViewCell.m
//  Object-CDemo
//
//  Created by Mac on 2018/3/24.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 50)];
        _titleLb.textColor = [UIColor blueColor];
        [self.contentView addSubview:_titleLb];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:0.5
          initialSpringVelocity:12
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         if (selected) {
                             _titleLb.transform = CGAffineTransformMakeScale(1.2, 1.2);
                             _titleLb.textColor = [UIColor redColor];
                         } else {
                             _titleLb.transform = CGAffineTransformIdentity;
                             _titleLb.textColor = [UIColor blueColor];
                         }
                     }
                     completion:nil];
}

@end
