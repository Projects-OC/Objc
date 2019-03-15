//
//  SafeTestViewController.m
//  Objcs
//
//  Created by header on 2019/3/13.
//  Copyright © 2019年 mf. All rights reserved.
//

#import "SafeTestViewController.h"

@interface SafeTestViewController ()

@end

@implementation SafeTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    {
        NSArray *placeholder = [NSArray alloc];
        NSArray *arr1 = [placeholder init];
        NSArray *arr2 = [placeholder initWithObjects:@0, nil];
        NSArray *arr3 = [placeholder initWithObjects:@0, @1, nil];
        NSArray *arr4 = [placeholder initWithObjects:@0, @1, @2, nil];
        
        NSLog(@"placeholder: %s", object_getClassName(placeholder));    // placeholder: __NSPlaceholderArray
        NSLog(@"arr1: %s", object_getClassName(arr1));                  // arr1: __NSArray0
        NSLog(@"arr2: %s", object_getClassName(arr2));                  // arr2: __NSSingleObjectArrayI
        NSLog(@"arr3: %s", object_getClassName(arr3));                  // arr3: __NSArrayI
        NSLog(@"arr4: %s", object_getClassName(arr4));                  // arr4: __NSArrayI
        
        
        NSMutableArray *mplaceholder = [NSMutableArray alloc];
        NSArray *marr1 = [mplaceholder init];
        NSArray *marr2 = [mplaceholder initWithObjects:@0, nil];
        NSArray *marr3 = [mplaceholder initWithObjects:@0, @1, nil];
        NSArray *marr4 = [mplaceholder initWithObjects:@0, @1, @2, nil];
        
        NSLog(@"mplaceholder: %s", object_getClassName(mplaceholder));    // mplaceholder: __NSPlaceholderArray
        NSLog(@"marr1: %s", object_getClassName(marr1));                  // marr1: __NSArrayM
        NSLog(@"marr2: %s", object_getClassName(marr2));                  // marr2: __NSArrayM
        NSLog(@"marr3: %s", object_getClassName(marr3));                  // marr3: __NSArrayM
        NSLog(@"marr4: %s", object_getClassName(marr4));                  // marr4: __NSArrayM
        NSLog(@"----------------");
    }
    
    {
        NSDictionary *placeholder = [NSDictionary alloc];
        NSDictionary *dic1 = [placeholder init];
        NSDictionary *dic2 = [placeholder initWithObjectsAndKeys:@"key1",@"value1",nil];
        NSDictionary *dic3 = [placeholder initWithObjectsAndKeys:@"key1",@"value1",@"key2",@"value2",nil];
        NSDictionary *dic4 = [placeholder initWithObjectsAndKeys:@"key1",@"value1",@"key2",@"value2",@"key3",@"value3",nil];

        NSLog(@"placeholder: %s", object_getClassName(placeholder));    // placeholder: __NSPlaceholderDictionary
        NSLog(@"dic1: %s", object_getClassName(dic1));                  // dic1: __NSDictionary0
        NSLog(@"dic2: %s", object_getClassName(dic2));                  // dic2: __NSSingleEntryDictionaryI
        NSLog(@"dic3: %s", object_getClassName(dic3));                  // dic3: __NSDictionaryI
        NSLog(@"dic4: %s", object_getClassName(dic4));                  // dic4: __NSDictionaryI

        
        NSMutableDictionary *mplaceholder = [NSMutableDictionary alloc];
        NSMutableDictionary *mdic1 = [mplaceholder init];
        NSMutableDictionary *mdic2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"key1",@"value1", nil];
        NSMutableDictionary *mdic3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"key1",@"value1",@"key2",@"value2", nil];
        NSMutableDictionary *mdic4 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"key1",@"value1",@"key2",@"value2",@"key3",@"value4", nil];

        NSLog(@"mplaceholder: %s", object_getClassName(mplaceholder));    // mplaceholder: __NSPlaceholderDictionary
        NSLog(@"mdic1: %s", object_getClassName(mdic1));                  // mdic1: __NSDictionaryM
        NSLog(@"mdic2: %s", object_getClassName(mdic2));                  // mdic2: __NSDictionaryM
        NSLog(@"mdic3: %s", object_getClassName(mdic3));                  // mdic3: __NSDictionaryM
        NSLog(@"mdic3: %s", object_getClassName(mdic4));                  // mdic4: __NSDictionaryM
        NSLog(@"----------------");
    }
    
    NSString *nilstr = nil;

    //NSArray-数组相关
    NSArray *a = @[@"a",@"aa",nilstr];
    NSLog(@"%@",a[1]);
    NSLog(@"%@",a[100]);
    NSLog(@"%@",[a objectAtIndex:1]);
    NSLog(@"%@",[a objectAtIndex:100]);
    
    NSArray *b = [NSArray arrayWithObjects:@"b",@"bb",nilstr, nil];
    NSLog(@"%@",b[1]);
    NSLog(@"%@",b[100]);
    NSLog(@"%@",[b objectAtIndex:1]);
    NSLog(@"%@",[b objectAtIndex:100]);
    
    
    //NSMutableSArray-可变数组相关
    NSMutableArray *c = @[@"c",@"cc",nilstr].mutableCopy;
    NSLog(@"%@",c[1]);
    NSLog(@"%@",c[100]);
    NSLog(@"%@",[c objectAtIndex:1]);
    NSLog(@"%@",[c objectAtIndex:100]);
    
    NSMutableArray *d = [NSMutableArray arrayWithObjects:@"d",@"dd",nilstr, nil];
    NSLog(@"%@",d[1]);
    NSLog(@"%@",d[100]);
    NSLog(@"%@",[d objectAtIndex:1]);
    NSLog(@"%@",[d objectAtIndex:100]);
    
    [d addObject:nilstr];
    
    
    //NSDictionary
    NSDictionary *e = @{@"key1":@"value1",@"key2":@"value2",@"key3":nilstr};
    NSLog(@"%@",e[@"key1"]);
    NSLog(@"%@",e[@"key100"]);
    NSLog(@"%@",[e objectForKey:@"key2"]);
    NSLog(@"%@",[e objectForKey:@"key200"]);

    
    //NSMutableDictionary
    NSMutableDictionary *f = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"key1",@"value1",@"key2",@"value2",@"key3",nilstr, nil];
    NSLog(@"%@",f[@"key1"]);
    NSLog(@"%@",f[@"key100"]);
    NSLog(@"%@",[f objectForKey:@"key2"]);
    NSLog(@"%@",[f objectForKey:@"key200"]);

    [f setObject:nilstr forKey:@"key3"];
    [f setValue:nilstr forKey:@"key4"];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
