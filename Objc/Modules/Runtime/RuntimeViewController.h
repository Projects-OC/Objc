//
//  RuntimeViewController.h
//  Object-CDemo
//
//  Created by Mac on 2018/3/22.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "BaseViewController.h"

/**
 引用runtime 需要在build setting objc_msgSend选项改为NO
 */
@interface RuntimeViewController : BaseViewController

@property (nonatomic,copy) NSString *tel;

@end
