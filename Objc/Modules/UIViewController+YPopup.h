//
//  UIViewController+YPopup.h
//  eim
//
//  Created by yanghui on 14-5-6.
//  Copyright (c) 2014年 Forever Open-source Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (YPopup)
@property (nonatomic, readwrite) UIViewController *popupViewController;
@property (nonatomic, readwrite) BOOL useBlurForPopup;
@property (nonatomic, readwrite) CGPoint popupViewOffset;


- (void)presentPopupViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion;
- (void)dismissPopupViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion;
- (void)setUseBlurForPopup:(BOOL)useBlurForPopup;
- (BOOL)useBlurForPopup;

@end
