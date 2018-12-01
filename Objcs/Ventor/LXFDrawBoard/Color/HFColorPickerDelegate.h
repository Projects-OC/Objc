//
//  ColorPickerDelegate.h
//  HF_Client_iPhone_Application
//
//  Created by 何景根 on 2018/6/27.
//  Copyright © 2018年 HengFeng. All rights reserved.
//

#ifndef ColorPickerDelegate_h
#define ColorPickerDelegate_h
@protocol HFColorPickerDelegate <NSObject>
-(void)colorDidPicked:(UIColor *)color;
@end
#endif /* ColorPickerDelegate_h */
