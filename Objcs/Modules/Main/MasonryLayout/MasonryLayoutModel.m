//
//  MasonryLayoutModel.m
//  Objc
//
//  Created by mf on 2018/7/25.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "MasonryLayoutModel.h"

@implementation MasonryLayoutModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = super.init;
    if (self) {
        _title = dictionary[@"title"];
        _content = dictionary[@"content"];
        _name = dictionary[@"username"];
        _time = dictionary[@"time"];
        _imageName = dictionary[@"imageName"];
    }
    return self;
}

@end
