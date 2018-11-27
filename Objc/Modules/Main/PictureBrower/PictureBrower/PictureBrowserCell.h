//
//  PictureBrowserCell.h
//  Object-CDemo
//
//  Created by Mac on 2018/3/27.
//  Copyright © 2018年 MF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureBrowserZoomScrollView.h"
#import "PictureBrowserSouceModel.h"

@protocol PictureBrowserCellDelegate <NSObject>

- (void)imageViewClick:(NSInteger)cellIndex;

@end

@interface PictureBrowserCell : UICollectionViewCell


@property (nonatomic, weak)   id <PictureBrowserCellDelegate> delegate;
@property (nonatomic, assign) NSInteger cellIndex;
@property (nonatomic, strong) PictureBrowserZoomScrollView *pictureImageScrollView;

- (void)showWithModel:(PictureBrowserSouceModel *)model;

@end
