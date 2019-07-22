//
//  AppDelegate+Exception.m
//  Objcs
//
//  Created by header on 2019/7/22.
//  Copyright © 2019年 mf. All rights reserved.
//

#import "AppDelegate+Exception.h"

@implementation AppDelegate (Exception)

static NSUncaughtExceptionHandler *previousUncaughtExceptionHandler = NULL;

- (void)registerExceptionHandler {
    // 如果Xcode调试模式
    if (isatty(STDOUT_FILENO)) {
        return;
    }
    previousUncaughtExceptionHandler = NSGetUncaughtExceptionHandler();
    
    NSSetUncaughtExceptionHandler(&appUncaughtExceptionHandler);
}

static void appUncaughtExceptionHandler(NSException * exception) {
    // 异常的堆栈信息
    NSArray * stacks = [exception callStackSymbols];
    // 异常的原因
    NSString * reason = [exception reason];
    // 异常名称
    NSString * name = [exception name];
    
    NSString * exceptionInfo = [NSString stringWithFormat:@"========uncaughtException异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@", name, reason, [stacks componentsJoinedByString:@"\n"]];
    
    [AppDelegate saveCrashLog:exceptionInfo name:name];
    if (previousUncaughtExceptionHandler) {
        previousUncaughtExceptionHandler(exception);
    }
}

+ (void)saveCrashLog:(NSString *)log name:(NSString *)name{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"Exception"];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:filePath]) {
        [manager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];

    NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:[filePath stringByAppendingPathComponent:dateStr]];
    [outFile seekToEndOfFile];
    [outFile writeData:[log dataUsingEncoding:NSUTF8StringEncoding]];
    [outFile closeFile];
    
//    BOOL iscreated = [manager createFileAtPath:[filePath stringByAppendingPathComponent:name] contents:[filePath dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
//    if (iscreated) {
//        NSLog(@"错误日志已缓存");
//    }
}


@end
