//
//  InkeModel.m
//  Objcs
//
//  Created by wff on 2018/12/7.
//  Copyright © 2018 mf. All rights reserved.
//

#import "InkeModel.h"

@implementation InkeModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"data":[InkeDataModel class]};
}

@end

@implementation InkeDataModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"list":[InkeListModel class]};
}

@end

@implementation InkeListModel
@end
