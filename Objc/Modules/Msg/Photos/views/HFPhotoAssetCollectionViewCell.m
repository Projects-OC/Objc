//
//  HFPhotoAssetCollectionViewCell.m
//  PhotoKit
//
//  Created by header on 2018/9/18.
//  Copyright © 2018年 header. All rights reserved.
//

#import "HFPhotoAssetCollectionViewCell.h"

@implementation HFPhotoAssetCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {        
        _img = [UIImageView new];
        [self.contentView addSubview:_img];
        [_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        UITapGestureRecognizer *_singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapClick:)];
        _singleTap.numberOfTapsRequired = 1;
        [self.contentView addGestureRecognizer:_singleTap];
        
        UITapGestureRecognizer *_doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapClick:)];
        _doubleTap.numberOfTapsRequired = 2;
        [self.contentView addGestureRecognizer:_doubleTap];
        
        //当没有检测到doubleTap 或者 检测doubleTap失败，singleTap才有效
        [_singleTap requireGestureRecognizerToFail:_doubleTap];
    }

    return self;
}

- (void)singleTapClick:(UITapGestureRecognizer *)singleTapClick {
    NSLog(@"单击");
}

- (void)doubleTapClick:(UITapGestureRecognizer *)singleTapClick {
    NSLog(@"双击 %d",singleTapClick.view.tag);
    if (_doubleTapBlock) {
        _doubleTapBlock(singleTapClick.view.tag);
    }
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.layer.borderColor = [UIColor greenColor].CGColor;
        self.layer.borderWidth = 2;
    } else {
        if (self.tag == 0) {
            self.layer.borderColor = [UIColor blackColor].CGColor;
            self.layer.borderWidth = 1;
        } else {
            //        self.layer.borderColor = [UIColor clearColor].CGColor;
            self.layer.borderWidth = 0;
        }
    }
}

@end
