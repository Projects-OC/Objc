//
//  MasonryLayoutModel.h
//  Objc
//
//  Created by mf on 2018/7/25.
//  Copyright © 2018年 mf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MasonryLayoutModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *imageName;

@end
