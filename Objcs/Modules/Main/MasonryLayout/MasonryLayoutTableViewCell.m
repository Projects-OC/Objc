//
//  MasonryLayoutTableViewCell.m
//  Objc
//
//  Created by mf on 2018/7/25.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "MasonryLayoutTableViewCell.h"
#import "MasonryLayoutModel.h"

@interface MasonryLayoutTableViewCell ()

@property (nonatomic,strong) UILabel *titleLb;
@property (nonatomic,strong) UILabel *contentLb;
@property (nonatomic,strong) UILabel *nameLb;
@property (nonatomic,strong) UILabel *timeLb;
@property (nonatomic,strong) UIImageView *imgView;

@end

@implementation MasonryLayoutTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat padding = 10;
        
        _titleLb = ({
            UILabel *_lb = [[UILabel alloc] init];
            _lb.font = [UIFont boldSystemFontOfSize:18];
            _lb.numberOfLines = 0;
            _lb.textColor = [UIColor blueColor];
            [self.contentView addSubview:_lb];
            [_lb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.mas_equalTo(padding);
                make.right.mas_equalTo(-padding);
            }];
            _lb;
        });
       
        _contentLb = ({
            UILabel *_lb = [[UILabel alloc] init];
            _lb.textColor = [UIColor blackColor];
            _lb.numberOfLines = 0;
            [self.contentView addSubview:_lb];
            [_lb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(padding);
                make.right.mas_equalTo(-padding);
                make.top.equalTo(self.titleLb.mas_bottom).offset(padding);
            }];
            _lb;
        });
        
        _imgView = ({
            UIImageView *_img = [[UIImageView alloc] init];
            _img.contentMode = UIViewContentModeScaleAspectFit;
            [self.contentView addSubview:_img];
            [_img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(padding);
                make.top.equalTo(self.contentLb.mas_bottom).offset(padding);
            }];
            _img;
        });
        
        _nameLb = ({
            UILabel *_lb = [[UILabel alloc] init];
            _lb.textColor = [UIColor grayColor];
            [self.contentView addSubview:_lb];
            [_lb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(padding);
                make.top.equalTo(self.imgView.mas_bottom).offset(padding);
                make.bottom.mas_equalTo(-padding);
            }];
            _lb;
        });
        
        _timeLb = ({
            UILabel *_lb = [[UILabel alloc] init];
            _lb.textColor = [UIColor grayColor];
            _lb.textAlignment = NSTextAlignmentRight;
            [self.contentView addSubview:_lb];
            [_lb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-padding);
                make.top.equalTo(self.imgView.mas_bottom).offset(padding);
                make.bottom.mas_equalTo(-padding);
            }];
            _lb;
        });
    }
    return self;
}

- (void)setEntityModel:(MasonryLayoutModel *)entityModel {
    _titleLb.text = entityModel.title;
    _contentLb.text = entityModel.content;
    _nameLb.text = entityModel.name;
    _timeLb.text = entityModel.time;
    _imgView.image = entityModel.imageName.length > 0 ? [UIImage imageNamed:entityModel.imageName] : nil;
}

@end
