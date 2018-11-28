//
//  FloatingAnimatorView.h
//  Objcs
//
//  Created by wff on 2018/11/28.
//  Copyright © 2018年 mf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FloatingAnimatorView : UIImageView

- (void)startAnimateView:(UIView *)view fromeRect:(CGRect)fromRect toRect:(CGRect)toRect;

@end
