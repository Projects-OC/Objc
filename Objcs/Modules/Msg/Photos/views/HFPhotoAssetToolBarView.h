//
//  HFPhotoAssetToolBarView.h
//  HF_Client_iPhone_Application
//
//  Created by header on 2019/8/6.
//  Copyright © 2019 HengFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFPhotoAssetToolBarView : UIView

@property (nonatomic,strong) UIButton *titleBtn;
@property (nonatomic,assign) NSInteger selectCount;

- (void)hideSelf;

@end

NS_ASSUME_NONNULL_END
