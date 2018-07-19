//
//  TaobaoTableViewCell.h
//  Object-CDemo
//
//  Created by Mac on 2018/3/26.
//  Copyright © 2018年 MF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaobaoTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, assign) CGFloat      cellHeight;

@property (nonatomic, assign) NSInteger    cellIndex;


- (void)setImageForImgView:(UIImage *)image;

@end
