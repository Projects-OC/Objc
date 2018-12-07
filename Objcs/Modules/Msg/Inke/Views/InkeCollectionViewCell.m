//
//  InkeCollectionViewCell.m
//  Objcs
//
//  Created by wff on 2018/12/7.
//  Copyright © 2018 mf. All rights reserved.
//

#import "InkeCollectionViewCell.h"
#import "InkeModel.h"

@interface InkeCollectionViewCell ()

@property (nonatomic,strong) UIImageView *photo;
@property (nonatomic,strong) UILabel *nickname;
@property (nonatomic,strong) UILabel *position;

@end

@implementation InkeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        
        self.photo = ({
            UIImageView *img = [UIImageView new];
            [self.contentView addSubview:img];
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.contentView);
            }];
            img;
        });
        
        self.nickname = ({
            UILabel *lb = [UILabel new];
            lb.textColor = [UIColor whiteColor];
            lb.font = [UIFont boldSystemFontOfSize:14];
            [self.contentView addSubview:lb];
            [lb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(5);
                make.bottom.mas_equalTo(-5);
            }];
            lb;
        });
        
        self.position = ({
            UILabel *lb = [UILabel new];
            lb.textColor = [UIColor whiteColor];
            lb.font = [UIFont boldSystemFontOfSize:14];
            [self.contentView addSubview:lb];
            [lb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(5);
                make.bottom.equalTo(self.nickname.mas_top).offset(-5);
            }];
            lb;
        });
    }
    return self;
}

- (void)setModel:(InkeListModel *)model {
    [self.photo setImageWithURL:[NSURL URLWithString:model.photo] options:YYWebImageOptionProgressiveBlur];
    self.nickname.text = model.nickname;
    self.position.text = model.position;
}

@end
