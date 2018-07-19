//
//  PictureBrowseTransitionParameter.h
//  Object-CDemo
//
//  Created by Mac on 2018/3/27.
//  Copyright © 2018年 MF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PictureBrowserTransitionParameter : NSObject

/*
 firstVC : 发起查看图片浏览器的界面
 secondVC: 图片浏览器界面
 */

//************************** firstVC、secondVC 都需要传值
///转场过渡image
@property (nonatomic, strong) UIImage           *transitionImage;

///所浏览图片的下标
@property (nonatomic, assign) NSInteger         transitionImgIndex;


//************************** 只需要firstVC 传值
///firstVC 图片的frame数组，记录所有图片view在第一个界面上相对于window的frame
@property (nonatomic, strong) NSArray<NSValue*> *firstVCImgFrames;


//************************** 只需要secondVC 传值
///滑动返回手势
@property (nonatomic, strong) UIPanGestureRecognizer *gestureRecognizer;
///当前滑动时，对应图片的frame
@property (nonatomic, assign) CGRect                 currentPanGestImgFrame;


//************************** 只读
///通过transitionImgIndex在内部计算出来在firstVC上所对应的图片frame
@property (nonatomic, assign, readonly) CGRect       firstVCImgFrame;

///通过transitionImage在内部计算出来在secondVC上所显示的图片frame
@property (nonatomic, assign, readonly) CGRect       secondVCImgFrame;

@end
