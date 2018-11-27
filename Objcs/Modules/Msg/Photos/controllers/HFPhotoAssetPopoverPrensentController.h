//
//  HFPhotoAssetPopoverPrensentController.h
//  PhotoKit
//
//  Created by header on 2018/9/18.
//  Copyright © 2018年 header. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFPhotoAssetPopoverPrensentController : UITableViewController

@property (nonatomic,copy) NSString *selectTitle;

- (instancetype)initWithAlbums:(NSArray *)albums
                    clickBlock:(void (^)(NSInteger index))block;

- (void)updateAlbums:(NSArray *)albums;

@end
