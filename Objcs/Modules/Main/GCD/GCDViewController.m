//
//  GCDViewController.m
//  Object-CDemo
//
//  Created by Mac on 2018/3/21.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self dispatch_sync];
}

- (void)queue{
    // 主队列
//    dispatch_queue_t mainDiapatchQueue = dispatch_get_main_queue();
//    // 高优先级全局并发队列
//    dispatch_queue_t globalDiapatchQueueHigh = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
//    // 默认先级全局并发队列
//    dispatch_queue_t globalDiapatchQueueDefault = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    // 低优先级全局并发队列
//    dispatch_queue_t globalDiapatchQueueLow = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
//    // 后台先级全局并发队列
//    dispatch_queue_t globalDiapatchQueueBackground = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
   
    //// 串行队列的创建方法
    //dispatch_queue_t queue= dispatch_queue_create("test.queue", DISPATCH_QUEUE_SERIAL);
    //// 并发队列的创建方法
    //dispatch_queue_t queue= dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
    ////创建全局并发队列
    //dispatch_get_global_queue
}

- (void)dispath_semaphore {
    NSInteger totalCount = 3;
    NSInteger requestCount = 0;
    
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    //请求1
    {
        if (totalCount == ++requestCount) {
            dispatch_semaphore_signal(sem);
        }
    }
    //请求2
    {
        if (totalCount == ++requestCount) {
            dispatch_semaphore_signal(sem);
        }
    }
    //请求3
    {
        if (totalCount == ++requestCount) {
            dispatch_semaphore_signal(sem);
        }
    }
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
}

/**
 异步、“并发” 或 “串行（同一个子线程）”
 DISPATCH_QUEUE_SERIAL 串行
 DISPATCH_QUEUE_CONCURRENT  并发
 */
- (void)dispatch_sync {
//    dispatch_queue_t queue = dispatch_queue_create("mySerialDispatchQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t serialQueue = dispatch_queue_create("queue.serial", DISPATCH_QUEUE_SERIAL);
    for(int i = 0; i < 5; i++){
        dispatch_sync(serialQueue, ^{
            NSLog(@"我开始了：%@ , %@",@(i),[NSThread currentThread]);
            [NSThread sleepForTimeInterval: i % 3];
        });
    }
    
    /*
    dispatch_group_t group = dispatch_group_create();
    for (int i = 0; i<3; i++ ) {
        dispatch_group_enter(group);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_group_leave(group);
        });
    }
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        NSLog(@"文件都已上传完成");
    });
     */
}

/**
 即调度组 不ABC不顺序执行
 */
- (void)dispatch_group_async {
    // 创建默认优先级的全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    // 创建调度组
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"A");
        });
    });
    dispatch_group_async(group, queue, ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"B");
        });
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"C");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"ABC都执行完成");
    });
}

- (void)dispatch_group_wait {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"下载图片A");
        });
    });
    dispatch_group_async(group, queue, ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"下载图片B");
        });
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"下载图片C");
    });
    
    /**
     * 第1个参数:执行任务的调度组
     * 第2个参数:等待时间：DISPATCH_TIME_FOREVER永久等待，DISPATCH_TIME_NOW程序执行到dispatch_group_wait方法,直接进行判断,而不用等待
     */
    long result = dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    if (result == 0){
        NSLog(@"处理下载完成的图片");
    }
    else{
        NSLog(@"以上调度组中存在未完成的任务");
    }
}

/**
 在并发执行任务的队列中追加处理任务,该任务在等待前面并发任务执行完成之后才执行,当dispatch_barrier_async中的任务执行完成,才会继续执行后续的并发执行的任务.
 */
- (void)dispatch_barrier_async{
    dispatch_queue_t queue = dispatch_queue_create("MyConcurrentDiapatchQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"第1次读取data值");
    });
    dispatch_async(queue, ^{
        NSLog(@"第2次读取data值");
    });
    dispatch_barrier_sync(queue, ^{
        NSLog(@"1，2都执行完成");
    });
    dispatch_async(queue, ^{
        NSLog(@"第3次写入data值");
    });
    dispatch_async(queue, ^{
        NSLog(@"第4次读取data值");
    });
    dispatch_async(queue, ^{
        NSLog(@"第5次读取data值");
    });
}

/**
 * 第1个参数:重复的次数
 * 第2个参数:执行任务的队列
 * 第3个参数:追加的处理
 */
- (void)dispatch_apply{
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_apply(10, queue, ^(size_t index) {
//        NSLog(@"%zu",index);
//    });
//    NSLog(@"done");
    
    NSArray *arr = [NSArray arrayWithObjects:@"10",@"20",@"30", nil];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        // 等待 dispatch_apply 方法中全部处理执行结束
        dispatch_apply(arr.count, queue, ^(size_t index) {
            // 并列处理包含在数组中全部对象
            NSLog(@"%zu:%@",index,[arr objectAtIndex:index]);
        });
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"用户界面更新");
        });
    });
}

/**
 dispatch semaphore是持有计数的信号.计数为0等待,计数为1或大于1,减去1而不等待.
 */
- (void)dispatch_semaphore_t{
    //开启太多子线程,势必导致程序响应问题,以及内存错误,导致崩溃.
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    NSMutableArray *arr = [[NSMutableArray alloc] init];
//    for (int i = 0; i < 10000; i++){
//        dispatch_async(queue, ^{
//            [arr addObject:[NSNumber numberWithInt:i]];
//        });
//    }
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    /**
     * 生成dispatch semaphore
     *
     * dispatch semaphore的计数初始值为1
     *
     * 保证可同时访问NSMutableArray类对象的线程
     * 同时只能有一个
     */
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 100; i++){
        dispatch_async(queue, ^{
            /**
             * 等待dispatch semaphore
             *
             * 一直等待,直到计数值大于等于1
             */
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            
            /**
             * 由于dispatch semaphore的计数值大于等于1
             * 所以将dispatch semaphore的计数值减去1
             * dispatch_semaphore_wait方法执行返回
             *
             * 执行到此时的dispatch semaphore的计数恒为0
             * 由于可访问NSMutableArray类对象的线程只有1个
             * 因此可安全地进行更新
             */
            [arr addObject:[NSNumber numberWithInt:i]];
            NSLog(@"%d%@",i,[NSThread currentThread]);

            // dispatch_semaphore_signal 方法将dispatch semaphore的计数加1.
            dispatch_semaphore_signal(semaphore);
        });
    }
}

- (void)dispatch_once_{
    static BaseViewController *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[BaseViewController alloc] init];
    });
}

@end
