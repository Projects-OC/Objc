//
//  InkeModel.h
//  Objcs
//
//  Created by wff on 2018/12/7.
//  Copyright © 2018 mf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class InkeListModel;
@class InkeDataModel;

NS_ASSUME_NONNULL_BEGIN

@interface InkeModel : NSObject

@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *msg;
@property (nonatomic,strong) InkeDataModel *data;

@end

@interface InkeDataModel : NSObject

@property (nonatomic,copy) NSArray <InkeListModel *>*list;

@end

@interface InkeListModel : NSObject

@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *photo;
@property (nonatomic,copy) NSString *starlevel;
@property (nonatomic,copy) NSString *allnum;
@property (nonatomic,copy) NSString *news;
@property (nonatomic,copy) NSString *anchorLevel;
@property (nonatomic,copy) NSString *roomid;
@property (nonatomic,copy) NSString *useridx;
@property (nonatomic,copy) NSString *flv;
@property (nonatomic,copy) NSString *position;
@property (nonatomic,copy) NSString *lianMaiStatus;
@property (nonatomic,copy) NSString *phonetype;
@property (nonatomic,copy) NSString *isOnline;
@property (nonatomic,copy) NSString *familyName;

@end

NS_ASSUME_NONNULL_END
