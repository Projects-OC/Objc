//
//  HFPhotoAssetManager.h
//  PhotoKit
//
//  Created by header on 2018/9/18.
//  Copyright © 2018年 header. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface HFPhotoAssetManager : NSObject

+ (HFPhotoAssetManager *)sharedInstance;

/**相册数组*/
@property (strong,nonatomic) NSArray<NSDictionary *> *albums;
/**某一相册的照片数组（PHAsset）*/
@property (strong,nonatomic) NSMutableArray<PHAsset *> *albumAssets;
/**某一相册的照片数组（UIImage）*/
@property (strong,nonatomic) NSMutableArray<UIImage *> *albumImages;
/**当前选中相册的下标*/
@property (assign,nonatomic) NSInteger currentAlbumsIndex;
/**每行照片个数*/
@property (assign,nonatomic) NSInteger lineNum;
/**拍照完成block*/
@property (copy,nonatomic) void (^ imagePickerFinishBlock)(void);

/**获取所有相册*/
- (void)getAlbumsComletion:(void (^)(void))completion;

/**相册图片数据*/
- (void)getPhotosWithCompletion:(void (^)(void))completion;

/**根据相册index获取相册的所有照片*/
- (void)updateAlbumsWithIndex:(NSInteger)index completion:(void (^)(void))completion;

/**获取相册照片权限*/
- (void)albumsAuthorizationStatus:(void(^)(BOOL power))resultBlock;

/**获取照相机权限*/
- (void)cameraAuthorizationStatus;

/// Get photo 获得照片
- (int32_t)getPhotoWithAsset:(PHAsset *)asset completion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion;

- (int32_t)getPhotoWithAsset:(PHAsset *)asset photoWidth:(CGFloat)photoWidth completion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion;

- (int32_t)getPhotoWithAsset:(PHAsset *)asset completion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion progressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler networkAccessAllowed:(BOOL)networkAccessAllowed;

- (int32_t)getPhotoWithAsset:(PHAsset *)asset photoWidth:(CGFloat)photoWidth completion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion progressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler networkAccessAllowed:(BOOL)networkAccessAllowed;

- (int32_t)requestImageDataForAsset:(PHAsset *)asset completion:(void (^)(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info))completion progressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler;

/// Get full Image 获取原图
/// 如下两个方法completion一般会调多次，一般会先返回缩略图，再返回原图(详见方法内部使用的系统API的说明)，如果info[PHImageResultIsDegradedKey] 为 YES，则表明当前返回的是缩略图，否则是原图。
- (void)getOriginalPhotoWithAsset:(PHAsset *)asset completion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion;

// 该方法中，completion只会走一次
- (void)getOriginalPhotoDataWithAsset:(PHAsset *)asset completion:(void (^)(NSData *data,NSDictionary *info,BOOL isDegraded))completion;

- (void)getOriginalPhotoDataWithAsset:(PHAsset *)asset progressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler completion:(void (^)(NSData *data,NSDictionary *info,BOOL isDegraded))completion;

@end
