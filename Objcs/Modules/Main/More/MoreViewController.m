//
//  MoreViewController.m
//  Objc
//
//  Created by mf on 2018/8/2.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "MoreViewController.h"
#import "OneViewController.h"
#import "BaseObject.h"
#import <objc/runtime.h>

@interface MoreViewController ()

@property (nonatomic,copy) NSArray *array;
@property (nonatomic,strong) NSMutableArray *mutableArray;
@property (nonatomic,copy) NSDictionary *dic;
@property (nonatomic,strong) NSString *string;


@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"title1";
    
    [self stringByApplyingTransform];
    
    [self terminationTitles:@"1",@"2",@"3", nil];
    
    
    UILabel *_lb = [[UILabel alloc] initWithFrame:self.view.bounds];
    _lb.text = @"点击屏幕";
    _lb.textColor = [UIColor blueColor];
    [self.view addSubview:_lb];
    
    // 图片
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sinojerk"]];
    imageView.frame = CGRectMake(0, 400, self.view.frame.size.width, self.view.frame.size.width/2.2);
    [self.view addSubview:imageView];
}

- (void)properyString {
    NSMutableString *str = [NSMutableString string];
    [str appendString:@"1"];
    
    self.string = str;
    
    [str appendString:@"2"];
    str = [NSMutableString stringWithString:@"3"];
    NSLog(@"%@",self.string);
}

- (void)properyArrayCopy {
    self.array = [NSArray array];
    self.mutableArray = [NSMutableArray arrayWithObject:@"1"];
    self.array = self.mutableArray;
    NSLog(@"%@",self.array);//1
    [self.mutableArray addObject:@"2"];
    NSLog(@"%@",self.array);//1
}

- (void)propertyDictionaryCopy {
    self.dic = @{@"key1":@"1",@"key2":@"2"};
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithObject:@"3" forKey:@"key3"];
    NSLog(@" %@",_dic);
    self.dic = mutableDic;
    NSLog(@" %@",_dic);
    [mutableDic addEntriesFromDictionary:@{@"key4":@"4"}];
    NSLog(@" %@",_dic);
}

//多参数传递
- (void)terminationTitles:(NSString *)titles, ...NS_REQUIRES_NIL_TERMINATION {
    NSMutableArray* arrays = [NSMutableArray array];
    NSLog(@"title = %@",titles);
    if (titles){
        [arrays addObject:titles];
        NSString* subTitle;
        va_list argumentList;
        va_start(argumentList, titles);
        while((subTitle = va_arg(argumentList, id))){
            [arrays addObject:subTitle];
            NSLog(@"%@",subTitle);
        }
        va_end(argumentList);
    }
}

//筛选model中某一属性组成新数组
- (void)arrayValueForKey {
    NSInteger cot = 20;
    NSMutableArray *datas = [NSMutableArray arrayWithCapacity:cot];
    for (int i=0; i<cot; i++) {
        BaseObject *obj = [BaseObject new];
        obj.name = @(i).stringValue;
        obj.sex = [@"man-" stringByAppendingString:@(i).stringValue];
        [datas addObject:obj];
    }
    NSArray *objs = [datas valueForKey:NSStringFromSelector(@selector(sex))];
    NSLog(@"%@",objs);
}

/**
 计算：总和、平均、最大、最小
 */
- (void)arrayValueForKeyPath {
    NSArray *array = [NSArray arrayWithObjects:@"2.0", @"2.3", @"3.0", @"4.0", @"10", nil];
    CGFloat sum = [[array valueForKeyPath:@"@sum.floatValue"] floatValue];
    CGFloat avg = [[array valueForKeyPath:@"@avg.floatValue"] floatValue];
    CGFloat max =[[array valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat min =[[array valueForKeyPath:@"@min.floatValue"] floatValue];
    NSLog(@"%f\n%f\n%f\n%f",sum,avg,max,min);
}

/**
 汉语转拼音
 */
- (void)stringByApplyingTransform {
    NSString *content = @"增加，增长，长高，长大，长度,重新，重庆，重量，四，十，正常";
    NSLog(@"%@",[content stringByApplyingTransform:NSStringTransformToLatin reverse:NO]);
    NSLog(@"%@",[[content stringByApplyingTransform:NSStringTransformToLatin reverse:NO] stringByApplyingTransform:NSStringTransformStripCombiningMarks reverse:NO]);
}

/**
 判断string是否是纯数字
 */
- (void)scanner {
    NSString *string = @"1";
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    if ([scan scanInt:&val] && [scan isAtEnd]) {
        //如果string都是数字
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 在window上覆盖一个白色view
    //    UIView *whiteView = [[UIView alloc] initWithFrame:self.view.bounds];
    //    whiteView.backgroundColor = [UIColor whiteColor];
    //    [[[[UIApplication sharedApplication] delegate] window] addSubview:whiteView];
    //
    
    // 图片
    //    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sinojerk"]];
    //    imageView.frame = CGRectMake(0, 400, self.view.frame.size.width, self.view.frame.size.width/2.2);
    //    [self.view addSubview:imageView];
    
    // 暗中转场
    OneViewController *ctrl = [[OneViewController alloc] init];
    [self.navigationController pushViewController:ctrl animated:NO];
    
    //    // 动画
    //    [UIView animateWithDuration:0.3 animations:^{
    //        imageView.frame = CGRectMake(0, 90, self.view.frame.size.width, self.view.frame.size.width/2.2);
    //    } completion:^(BOOL finished) {
    //        // 动画结束后移除view
    //        [whiteView removeFromSuperview];
    //    }];
}



- (void)didMoveToParentViewController:(UIViewController *)parent {
    if (!parent) {
        //移除定时器
    }
}

@end
