//
//  RuntimeViewController.m
//  Object-CDemo
//
//  Created by Mac on 2018/3/22.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "RuntimeViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "UIButton+Block.h"
#import "Object.h"
#import "RuntimeViewController+Addtion.h"

static const void *CallStringKey = &CallStringKey;

/**
 引用runtime 需要在build setting objc_msgSend选项改为NO
 */
@interface RuntimeViewController ()<UIAlertViewDelegate>

@end

@implementation RuntimeViewController

void guessAnswer(id self,SEL _cmd){
    //一个Objective-C方法是一个简单的C函数，它至少包含两个参数–self和_cmd。所以，我们的实现函数(IMP参数指向的函数)至少需要两个参数
    NSLog(@"我是动态增加的方法响应");
}


/**
    Runtime方法
    关联
    发送
    替换
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tel = @"10010";
    
    {
        NSString *string = @"123";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"runtime"
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:@"好的", nil];
        [alert show];
        objc_setAssociatedObject(alert, CallStringKey, string, OBJC_ASSOCIATION_COPY);
    }
   
    
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(100, 100, 100, 100)];
        [btn setTitle:@"runtime" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = 119;
        [self.view addSubview:btn];
        [btn tapEvent:UIControlEventTouchUpInside withBlock:^(UIButton *sender) {
            NSLog(@"点了button %ld",sender.tag);
        }];
        
        objc_msgSend(btn, @selector(setBackgroundColor:),[UIColor grayColor]);
        objc_msgSend(btn.layer, @selector(setBorderColor:),[UIColor blueColor].CGColor);
        objc_msgSend(btn.layer, @selector(setBorderWidth:),3.0);
    }
    
    {
        Method m1 = class_getInstanceMethod([self class], @selector(func1));
        Method m2 = class_getInstanceMethod([self class], @selector(func2));
        method_exchangeImplementations(m1, m2);
        
        [self func1];
        [self func2];
    }
    
    //动态添加方法
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
        //写在这个中间的代码,都不会被编译器提示-Wundeclared-selector类型的警告
        class_addMethod([self class], @selector(guess), (IMP)guessAnswer, "v@:");
        if ([self respondsToSelector:@selector(guess)]) {
            [self performSelector:@selector(guess)];
        } else{
            NSLog(@"方法没有增加成功");
        }
#pragma clang diagnostic pop
        
//        Object *obj = [[Object alloc] init];
//        [obj performSelector:@selector(addMethod)];
    }
    //动态添加属性
    {
        [self age:@"18" sex:@"男"];
    }
    
    {
     /**
      //获取类
      Class class = object_getClass([self class]);
      //获取类方法
      Method oriMethod = Method class_getClassMethod(Class cls , SEL name);
      //获取实例方法
      Method class_getInstanceMethod(Class cls , SEL name)
      //添加方法
      BOOL addSucc = class_addMethod(xiaomingClass, oriSEL, method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));
      //替换原方法
      class_replaceMethod(toolClass, cusSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
      //交换两个方法
      method_exchangeImplementations(oriMethod, cusMethod);
      //获取类的属性列表
      objc_property_t *propertyList = class_copyPropertyList([self class], &count);
      //获取类的方法列表
      Method *methodList = class_copyMethodList([self class], &count);
      //获取类的成员变量列表
      Ivar *ivarList = class_copyIvarList([self class], &count);
      //获取成员变量的名字：
      const char *ivar_getName(Ivar v)
      //获取成员变量的类型
      const char *ivar_getTypeEndcoding(Ivar v)
      //获取一个类的协议列表（返回值是一个数组）
      __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
      */
    }
    [self getIvars];
    [self getPropertys];
    [self getMethods];
    [self changeTel];
}

-(void)getIvars{
    NSLog(@"getIvars--------------");
    // 1.打印所有ivars
    unsigned int ivarCount = 0;
    // 用一个字典装ivarName和value
    NSMutableDictionary *ivarDict = [NSMutableDictionary dictionary];
    Ivar *ivarList = class_copyIvarList([self class], &ivarCount);
    for(int i = 0; i < ivarCount; i++){
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivarList[i])];
        id value = [self valueForKey:ivarName];
        if (value) {
            ivarDict[ivarName] = value;
        } else {
            ivarDict[ivarName] = @"值为nil";
        }
    }
    // 打印ivar
    for (NSString *ivarName in ivarDict.allKeys) {
        NSLog(@"ivarName:%@, ivarValue:%@",ivarName, ivarDict[ivarName]);
    }
    free(ivarList);
}

- (void)getPropertys{
    NSLog(@"getPropertys--------------");
    unsigned int propertyCount = 0;
    // 用一个字典装propertyName和value
    NSMutableDictionary *propertyDict = [NSMutableDictionary dictionary];
    objc_property_t *propertyList = class_copyPropertyList([self class], &propertyCount);
    for(int j = 0; j < propertyCount; j++){
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(propertyList[j])];
        id value = [self valueForKey:propertyName];
        if (value) {
            propertyDict[propertyName] = value;
        } else {
            propertyDict[propertyName] = @"值为nil";
        }
    }
    // 打印property
    for (NSString *propertyName in propertyDict.allKeys) {
        NSLog(@"propertyName:%@, propertyValue:%@",propertyName, propertyDict[propertyName]);
    }
    free(propertyList);
}

- (void)getMethods{
    NSLog(@"getMethods--------------");
    unsigned int methodCount = 0;
    // 用一个字典装methodName和arguments
    NSMutableDictionary *methodDict = [NSMutableDictionary dictionary];
    Method *methodList = class_copyMethodList([self class], &methodCount);
    for(int k = 0; k < methodCount; k++){
        SEL methodSel = method_getName(methodList[k]);
        NSString *methodName = [NSString stringWithUTF8String:sel_getName(methodSel)];
        unsigned int argumentNums = method_getNumberOfArguments(methodList[k]);
        methodDict[methodName] = @(argumentNums - 2); // -2的原因是每个方法内部都有self 和 selector 两个参数
    }
    // 打印method
    for (NSString *methodName in methodDict.allKeys) {
        NSLog(@"methodName:%@, argumentsCount:%@", methodName, methodDict[methodName]);
    }
    free(methodList);
}


/**
 修改变量值
 */
-(void)changeTel{
    unsigned int count = 0;
    //动态获取类中的所有属性[当然包括私有]
    Ivar *ivar = class_copyIvarList([self class], &count);
    //遍历属性找到对应tel字段
    for (int i = 0; i < count; i++) {
        Ivar var = ivar[i];
        const char *varName = ivar_getName(var);
        NSString *name = [NSString stringWithUTF8String:varName];
        if ([name isEqualToString:@"_tel"]) {
            //修改对应的字段值成20
            object_setIvar(self, var, @"10086");
            break;
        }
    }
    NSLog(@"tel = %@",self.tel);
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *string = objc_getAssociatedObject(alertView, CallStringKey);
    NSLog(@"%@",string);
}

- (void)func1{
    NSLog(@"log func1");
}

- (void)func2{
    NSLog(@"log func2");
}

@end
