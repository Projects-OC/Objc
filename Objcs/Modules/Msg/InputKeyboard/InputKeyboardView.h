//
//  InputKeyboardView.h
//  Objcs
//
//  Created by header on 2019/7/23.
//  Copyright © 2019 mf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InputKeyboardView : UIView

+ (InputKeyboardView *)keyboardView;

@property (nonatomic,copy) void (^ sendBlock)(NSString *);

@end

NS_ASSUME_NONNULL_END
