//
//  TableViewController.m
//  Object-CDemo
//
//  Created by Mac on 2018/3/22.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "MainTableViewController.h"
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
#import "UIViewController+Popup.h"
#import "MasonryLayoutTableViewController.h"
#import <MFWebKit/MFWebKitViewController.h>
#import "OneViewController.h"
#import "DecimalNumberViewController.h"
#import "MoreViewController.h"
#import "PushViewControllerA.h"

@interface MainTableViewController ()

@property (nonatomic,copy) NSArray *titles;

@property (nonatomic,strong) UIImageView *headerImage;

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:NSStringFromClass([TableViewCell class])];
    self.tableView.tableHeaderView = self.headerImage;
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
                    @{@"title" : @"转场的另一种思路",
                      @"class" : NSStringFromClass([MoreViewController class])
                      },
                    @{@"title" : @"Core Animation",
                      @"class" : NSStringFromClass([CoreAnimationViewController class])
                      },
                    @{@"title" : @"MasnoryLayout",
                      @"class" : NSStringFromClass([MasonryLayoutTableViewController class])
                      },
                    @{@"title" : @"WebView",
                      @"class" : NSStringFromClass([MFWebKitViewController class])
                      },
                    @{@"title" : @"DecimaNumber",
                      @"class" : NSStringFromClass([DecimalNumberViewController class])
                      },
                    @{@"title" : @"多页面跳转",
                      @"class" : NSStringFromClass([PushViewControllerA class])
                      },
                    ];
    }
    return _titles;
}

- (UIImageView *)headerImage {
    if (!_headerImage) {
        _headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
        _headerImage.image = [UIImage imageNamed:@"Expression03.jpeg"];
        _headerImage.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headerImage;
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
    else if ([classString isEqualToString:NSStringFromClass([MFWebKitViewController class])]) {
        MFWebKitViewController *ctrl = [[MFWebKitViewController alloc] init];
        ctrl.url = [NSURL URLWithString:@"https://www.baidu.com"];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    else {
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
   
    /**
     控制表头图片的放大
     */
//    if (scrollView.contentOffset.y < 0) {
//        // 向下拉多少
//        // 表头就向上移多少
//        self.headerImage.top = scrollView.contentOffset.y;
//        // 高度就增加多少
//        self.headerImage.height = 200 + fabs(scrollView.contentOffset.y);
//    }else{
//        // 复原
//        self.headerImage.top = 0;
//        self.headerImage.height = 200;
//    }
    
    /**
     获取tableView中心的cell
     */
    NSIndexPath *middleIndexPath = [self.tableView indexPathForRowAtPoint:CGPointMake(0, scrollView.contentOffset.y + self.tableView.frame.size.height/2)];
    TableViewCell *cell = [self.tableView cellForRowAtIndexPath:middleIndexPath];
    NSLog(@"%@",cell.titleLb.text);
    
    /**
     更改导航条 透明度
     */
    CGFloat contentOffY = scrollView.contentOffset.y + LCStatusBarAndNavigationBarHeight;
    CGFloat alpha = contentOffY/kScreenHeight*10;
    if (alpha > 0 && alpha <= 1.0) {
        self.navigationController.navigationBar.subviews[0].alpha = alpha;
    }
    NSLog(@"%f *** %f **** %f",contentOffY/kScreenHeight,contentOffY,alpha);
}

@end
