//
//  HFToolBarView.h
//  Objcs
//
//  Created by wff on 2018/11/30.
//  Copyright © 2018年 mf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFToolBarView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray *)titles
                   touchBlock:(void (^)(NSInteger tag))touchBlock;

@end
