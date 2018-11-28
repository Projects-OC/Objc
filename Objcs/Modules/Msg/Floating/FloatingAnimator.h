//
//  FloatingAnimator.h
//  Objcs
//
//  Created by wff on 2018/11/28.
//  Copyright © 2018年 mf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FloatingAnimator : NSObject<UIViewControllerContextTransitioning>

@property (nonatomic,assign) CGRect curFrame;

@end
