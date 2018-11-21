//
//  KVOViewController.m
//  Objc
//
//  Created by header on 2018/11/21.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "KVOViewController.h"

@interface KVOViewController ()

@property (nonatomic,strong) NSMutableArray *objs;

@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addObserver:self forKeyPath:[self stringFromSelector] options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[self mutableValueForKey] addObject:@"1"];
    });
}

- (id)mutableValueForKey {
    return [self mutableArrayValueForKey:[self stringFromSelector]];
}

- (NSString *)stringFromSelector {
    return NSStringFromSelector(@selector(objs));
}

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    if ([keyPath isEqualToString:[self stringFromSelector]]) {
        NSLog(@"%@",self.objs);
    }
}
     
@end
