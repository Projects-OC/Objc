//
//  HFDrawBoardColors.m
//  HF_Client_iPhone_Application
//
//  Created by header on 2018/11/6.
//  Copyright © 2018年 HengFeng. All rights reserved.
//

#import "HFDrawBoardColors.h"
@class HFDrawBoardColorsCell;

@interface HFDrawBoardColors ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation HFDrawBoardColors

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        [self addSubview:self.collection];
        [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (UICollectionView *)collection {
    if (!_collection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        UICollectionView *collection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        collection.delegate = self;
        collection.dataSource = self;
        collection.backgroundColor = [UIColor clearColor];
        collection.showsVerticalScrollIndicator = NO;
        collection.showsHorizontalScrollIndicator = NO;
        [collection registerClass:HFDrawBoardColorsCell.class forCellWithReuseIdentifier:NSStringFromClass(HFDrawBoardColorsCell.class)];
        _collection = collection;
    }
    
    return _collection;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _colors.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HFDrawBoardColorsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(HFDrawBoardColorsCell.class) forIndexPath:indexPath];
    
    if (indexPath.row < _colors.count-1) {
        cell.colorView.backgroundColor = _colors[indexPath.row];
        cell.revokeBtn.hidden = YES;
        cell.colorView.hidden = NO;
    } else {
        cell.colorView.hidden = YES;
        cell.revokeBtn.hidden = NO;
        [cell.revokeBtn addTarget:self action:@selector(revokeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectIndexBlock) {
        _selectIndexBlock(indexPath.row);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(50, 40);
}

- (void)revokeBtnClick {
    if (_selectIndexBlock) {
        _selectIndexBlock(_colors.count-1);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collection.frame = self.bounds;
}

@end


@implementation HFDrawBoardColorsCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = 20;
        _colorView = ({
            UIView *_view = [UIView new];
            _view.layer.cornerRadius = width/2;
            _view.layer.masksToBounds = YES;
            _view.layer.borderWidth = 1;
            _view.layer.borderColor = [UIColor whiteColor].CGColor;
            [self.contentView addSubview:_view];
            [_view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
                make.size.mas_equalTo(CGSizeMake(width, width));
            }];
            _view;
        });
        
        _revokeBtn = ({
            UIButton *_btn = [UIButton buttonWithType:UIButtonTypeCustom];
            _btn.titleLabel.font = [UIFont systemFontOfSize:14];
            _btn.hidden = YES;
            [_btn setTitle:@"撤销" forState:UIControlStateNormal];
            [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.contentView addSubview:_btn];
            [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
                make.size.mas_equalTo(CGSizeMake(30, 30));
            }];
            _btn;
        });
        
    }
    return self;
}


@end
