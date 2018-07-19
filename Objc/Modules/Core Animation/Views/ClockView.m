//
//  ColorView.m
//  Object-CDemo
//
//  Created by mf on 2018/7/4.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "ClockView.h"

#define kClockWidth _clockImageView.bounds.size.width
//弧度转角度
#define radion2angle(angle) ((angle) / 180.0 * M_PI)
//角度转弧度
#define angle2radion(a) ((a) / 180.0 * M_PI)
// 一秒钟秒针转6°
CGFloat const perSecondA = 6;
// 一分钟分针转6°
CGFloat const perMinuteA = 6;
// 一小时时针转30°
CGFloat const perHourA = 30;
// 每分钟时针转多少度
CGFloat const perMinuteHourA = 0.5;

@interface ClockView ()

@property (nonatomic,strong) UIImageView *clockImageView;

@property (nonatomic,weak) CALayer *hourLayer;
@property (nonatomic,weak) CALayer *minuteLayer;
@property (nonatomic,weak) CALayer *secondLayer;

@end

@implementation ClockView

- (instancetype) init {
    if (self = [super init]) {
        _clockImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"钟表.png"]];
        [self addSubview:_clockImageView];
        [_clockImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
        [self addHourLayer];
        [self addMinuteLayer];
        [self addSecondLayer];
        // 添加定时器
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
        [self timeChange];
    }
    return self;
}

//时针
- (void)addHourLayer {
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor blackColor].CGColor;
    // 设置锚点
    layer.anchorPoint = CGPointMake(0.5, 1);
    layer.position = CGPointMake(kClockWidth /2, kClockWidth /2);
    layer.bounds = CGRectMake(0, 0, 4, kClockWidth * 0.5 - 40);
    layer.cornerRadius = 4;
    [_clockImageView.layer addSublayer:layer];
    _hourLayer = layer;
}

//分针
- (void)addMinuteLayer {
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    // 设置锚点
    layer.anchorPoint = CGPointMake(0.5, 1);
    layer.position = CGPointMake(kClockWidth /2, kClockWidth /2);
    layer.bounds = CGRectMake(0, 0, 4, kClockWidth * 0.5 - 40);
    layer.cornerRadius = 4;
    [_clockImageView.layer addSublayer:layer];
    _minuteLayer = layer;
}

//秒针
- (void)addSecondLayer {
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor yellowColor].CGColor;
    // 设置锚点
    layer.anchorPoint = CGPointMake(0.5, 1);
    layer.position = CGPointMake(kClockWidth /2, kClockWidth /2);
    layer.bounds = CGRectMake(0, 0, 4, kClockWidth * 0.5 - 40);
    layer.cornerRadius = 4;
    [_clockImageView.layer addSublayer:layer];
    _secondLayer = layer;
}

- (void)timeChange {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
    
    // 计算秒针转多少度
    CGFloat secondAngle = components.second * perSecondA;
    // 计算分针转多少度
    CGFloat minuteAngle = components.minute * perMinuteA;
    // 计算时针转多少度
    CGFloat hourAngle = components.hour * perHourA + components.minute * perMinuteHourA;
    
    // 旋转秒针
    _hourLayer.transform = CATransform3DMakeRotation(angle2radion(hourAngle), 0, 0, 1);
    // 旋转分针
    _minuteLayer.transform = CATransform3DMakeRotation(angle2radion(minuteAngle), 0, 0, 1);
    // 旋转小时
    _secondLayer.transform = CATransform3DMakeRotation(angle2radion(secondAngle), 0, 0, 1);
}

@end
