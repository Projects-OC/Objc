//
//  TableViewController.m
//  Object-CDemo
//
//  Created by Mac on 2018/3/22.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "TableViewController.h"
#import "RuntimeViewController.h"
#import "TransitionsViewController.h"
#import "PresentationViewController.h"
#import "UIPresentationControllers.h"
#import "PopoverViewController.h"
#import "TableViewCell.h"
#import "WechatNavAnimationTransitionViewController.h"
#import "TaobaoViewController.h"
#import "PBVc.h"
#import "CoreAnimationViewController.h"
#import "UIViewController+YPopup.h"
#import "MasonryLayoutTableViewController.h"

@interface TableViewController ()

@property (nonatomic,copy) NSArray *titles;
@property (nonatomic,copy) NSArray *array;
@property (nonatomic,strong) NSMutableArray *mutableArray;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:NSStringFromClass([TableViewCell class])];
}

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@{@"title" : @"GCD",
                      @"class" : NSStringFromClass([UIViewController class])
                      },
                    @{@"title" : @"Runtime",
                      @"class" : NSStringFromClass([RuntimeViewController class])
                      },
                    @{@"title" : @"Transitions1",
                      @"class" : NSStringFromClass([TransitionsViewController class])
                      },
                    @{@"title" : @"Presentation",
                      @"class" : NSStringFromClass([PresentationViewController class])
                      },
                    @{@"title" : @"Popover",
                      @"class" : NSStringFromClass([PopoverViewController class])
                      },
                    @{@"title" : @"点击图片转场",
                      @"class" : NSStringFromClass([WechatNavAnimationTransitionViewController class])
                      },
                    @{@"title" : @"商品详情转场",
                      @"class" : NSStringFromClass([TaobaoViewController class])
                      },
                    @{@"title" : @"图片浏览",
                      @"class" : NSStringFromClass([PBVc class])
                      },
                    @{@"title" : @"Core Animation",
                      @"class" : NSStringFromClass([CoreAnimationViewController class])
                      },
                    @{@"title" : @"MasnoryLayout",
                      @"class" : NSStringFromClass([MasonryLayoutTableViewController class])
                      },
                    ];
    }
    return _titles;
}

- (void)properyCopy{
    self.array = [NSArray array];
    self.mutableArray = [NSMutableArray arrayWithObject:@"1"];
    self.array = self.mutableArray;
    NSLog(@"%@",self.array);//1
    [self.mutableArray addObject:@"2"];
    NSLog(@"%@",self.array);//1
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableViewCell class]) forIndexPath:indexPath];
    cell.titleLb.text = self.titles[indexPath.row][@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    BaseViewController *vc = [[BaseViewController alloc] init];
//    [self.tabBarController presentPopupViewController:vc animated:YES completion:^{
//
//    }];
//    return;
    
    NSString *classString = self.titles[indexPath.row][@"class"];
    UIViewController *ctrl = [[NSClassFromString(classString) alloc] init];
  
    if ([classString isEqualToString:NSStringFromClass([TransitionsViewController class])]) {
        ctrl.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:ctrl animated:YES completion:nil];
    }
    else if ([classString isEqualToString:NSStringFromClass([PresentationViewController class])]) {
        UIPresentationControllers *presentationController NS_VALID_UNTIL_END_OF_SCOPE;
        presentationController = [[UIPresentationControllers alloc] initWithPresentedViewController:ctrl
                                                                           presentingViewController:self];
        ctrl.transitioningDelegate = presentationController;
        [self presentViewController:ctrl animated:YES completion:NULL];
    }
    else {
        [self.navigationController pushViewController:ctrl animated:YES];
    }

}


@end
