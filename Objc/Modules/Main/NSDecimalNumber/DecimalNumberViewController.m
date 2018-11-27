//
//  DecimalNumberViewController.m
//  Objc
//
//  Created by mf on 2018/8/2.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "DecimalNumberViewController.h"

@interface DecimalNumberViewController ()

@end

@implementation DecimalNumberViewController

/**
typedef NS_ENUM(NSUInteger, NSRoundingMode) {
    NSRoundPlain,   // Round up on a tie，四舍五入
    NSRoundDown,    // Always down == truncate，只舍不入
    NSRoundUp,      // Always up，只入不舍
 NSRoundBankers  // on a tie round so last digit is even，四舍六入, 中间值时, 取最近的,保持保留最后一位为偶数：在四舍五入的基础上加了一个判断：当最后一位为5的时候，只会舍入成偶数。比如：1.25不会返回1.3而是1.2，因为1.3不是偶数。
};
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    /**
     scale: 保留几位小数
     raiseOnExactness:  发生精确错误时是否抛出异常，一般为NO
     raiseOnOverflow:   发生溢出错误时是否抛出异常，一般为NO
     raiseOnUnderflow:  发生不足错误时是否抛出异常，一般为NO
     raiseOnDivideByZero: 除数是0时是否抛出异常，一般为YES
     */
    NSDecimalNumberHandler *decimalNumberHandler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                                                      scale:2
                                                                           raiseOnExactness:NO
                                                                            raiseOnOverflow:NO
                                                                           raiseOnUnderflow:NO
                                                                        raiseOnDivideByZero:YES];
    {
        /**
         Mantissa:  无符号长整型数值
         exponent:  指数（几次方）
         isNegative:是否是负数
         result = Mantissa * 10^exponent
         */
        NSDecimalNumber *decimal1 = [NSDecimalNumber decimalNumberWithMantissa:36868 exponent:3 isNegative:NO];//log : 36868000
        NSDecimalNumber *decimal2 = [NSDecimalNumber decimalNumberWithMantissa:36868 exponent:-3 isNegative:YES];//log : -36.868
        NSLog(@"%@,%@\n",decimal1,decimal2);
    }
    
    {
        NSDecimalNumber *decimal1 = [[NSDecimalNumber alloc] initWithString:@"12345678998.68"];
        NSDecimalNumber *decimal2 = [[NSDecimalNumber alloc] initWithString:@"0.22"];
        
        /**加*/
        NSDecimalNumber *addRes = [decimal1 decimalNumberByAdding:decimal2
                                                     withBehavior:decimalNumberHandler];
        /**减*/
        NSDecimalNumber *subtractRes = [decimal1 decimalNumberBySubtracting:decimal2
                                                               withBehavior:decimalNumberHandler];
        /**乘*/
        NSDecimalNumber *multiplyingRes = [decimal1 decimalNumberByMultiplyingBy:decimal2
                                                                    withBehavior:decimalNumberHandler];
        /**除*/
        NSDecimalNumber *divideRes = [decimal1 decimalNumberByDividingBy:decimal2
                                                            withBehavior:decimalNumberHandler];
        /**n次方*/
        NSDecimalNumber *powerResult = [decimal2 decimalNumberByRaisingToPower:2
                                                                  withBehavior:decimalNumberHandler];
        NSLog(@"%@\n %@\n %@\n %@\n %@\n",addRes,subtractRes,multiplyingRes,divideRes,powerResult);
        
        NSComparisonResult result = [decimal1 compare:decimal2];
        NSLog(@"decimal1 %@ decimal2", result > 0 ? @">":@"<");
    }
}

@end
