//
//  TabBar.h
//  Objcs
//
//  Created by header on 2019/3/14.
//  Copyright © 2019年 mf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TabBar : UITabBar

@property (nonatomic,copy) void (^ appleHandle)(void);

@end

NS_ASSUME_NONNULL_END
