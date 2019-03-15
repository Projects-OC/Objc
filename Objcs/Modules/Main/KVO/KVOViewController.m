//
//  KVOViewController.m
//  Objc
//
//  Created by header on 2018/11/21.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "KVOViewController.h"
#import "BaseObject.h"
#import "NavigatonViewController.h"

@interface KVOViewController ()

@property (nonatomic,strong) NSMutableArray *objs;

@end

@implementation KVOViewController

- (void)popSEL {
    NSLog(@"popSEL");
}

- (void)popProtocol {
    NSLog(@"popProtocol");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addObserver:self forKeyPath:[self stringFromSelector] options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        BaseObject *o = [BaseObject new];
        o.name = @"1";
        [[self mutableValueForKey] addObject:o];
    });
}

- (NSMutableArray <BaseObject *>*)objs {
    if (!_objs) {
        _objs = [NSMutableArray new];
    }
    return _objs;
}

- (id)mutableValueForKey {
    return [self mutableArrayValueForKey:[self stringFromSelector]];
}

- (NSString *)stringFromSelector {
    return NSStringFromSelector(@selector(objs));
}

//- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
//    if ([keyPath isEqualToString:[self stringFromSelector]]) {
//        NSLog(@"%@",self.objs);
//    }
//}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:[self stringFromSelector]]) {
        NSLog(@"%@",self.objs);
    }
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:[self stringFromSelector]];
}
     
@end
