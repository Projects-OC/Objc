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
        _titles = @[@"GCD",
                    @"Runtime",
                    @"Transitions1",
                    @"Presentation",
                    @"Popover",
                    @"点击图片转场",
                    @"商品详情转场",
                    @"图片浏览",
                    @"Core Animation",
                    @"",
                    @"",
                    @"",
                    @"",];
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
    cell.titleLb.text = self.titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseViewController *vc = [[BaseViewController alloc] init];
    [self.tabBarController presentPopupViewController:vc animated:YES completion:^{
        
    }];
    return;
    switch (indexPath.row) {
        case 0:
            {
                
            }
            break;
        case 1:
        {
            RuntimeViewController *vc = [[RuntimeViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            TransitionsViewController *transitionVc = [[TransitionsViewController alloc] init];
            transitionVc.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:transitionVc animated:YES completion:nil];
        }
            break;
        case 3:
        {
            PresentationViewController *presentVc = [[PresentationViewController alloc] init];
            UIPresentationControllers *presentationController NS_VALID_UNTIL_END_OF_SCOPE;
            presentationController = [[UIPresentationControllers alloc] initWithPresentedViewController:presentVc
                                                                               presentingViewController:self];
            presentVc.transitioningDelegate = presentationController;
            [self presentViewController:presentVc animated:YES completion:NULL];
        }
            break;
        case 4:
        {
            PopoverViewController *popVc = [[PopoverViewController alloc] init];
            [self.navigationController pushViewController:popVc animated:YES];
        }
            break;
        case 5:{
            WechatNavAnimationTransitionViewController *vc = [[WechatNavAnimationTransitionViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:{
            TaobaoViewController *vc = [[TaobaoViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 7:{
            PBVc *vc = [[PBVc alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 8: {
            CoreAnimationViewController *vc = [[CoreAnimationViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}


@end
