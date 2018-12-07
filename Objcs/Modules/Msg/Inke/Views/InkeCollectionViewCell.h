//
//  InkeCollectionViewCell.h
//  Objcs
//
//  Created by wff on 2018/12/7.
//  Copyright © 2018 mf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InkeListModel;

NS_ASSUME_NONNULL_BEGIN

@interface InkeCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong) InkeListModel *model;

@end

NS_ASSUME_NONNULL_END
