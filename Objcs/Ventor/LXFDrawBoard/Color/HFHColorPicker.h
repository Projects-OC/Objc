//
//  HFHColorPicker.h
//  HF_Client_iPhone_Application
//
//  Created by 何景根 on 2018/6/27.
//  Copyright © 2018年 HengFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFColorPickerDelegate.h"
@interface HFHColorPicker : UIView
@property(nonatomic,strong)UIColor *color;
@property (nonatomic,strong) UIButton *revokeBtn;
@property(nonatomic,weak)id<HFColorPickerDelegate> delegate;
@end
