//
//  MsgViewController.m
//  Objc
//
//  Created by mf on 2018/8/2.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "MsgViewController.h"
#import "HFPhotoAssetViewController.h"
#import "LFLiveViewController.h"

@interface MsgViewController ()

@property (nonatomic,copy) NSArray *titles;

@end

@implementation MsgViewController

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@{@"title" : @"Photos",
                      @"class" : NSStringFromClass([HFPhotoAssetViewController class])
                      },
                    @{@"title" : @"Live",
                      @"class" : NSStringFromClass([LFLiveViewController class])
                      },
                    ];
    }
    return _titles;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    cell.textLabel.text = self.titles[indexPath.row][@"title"];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *classString = self.titles[indexPath.row][@"class"];
    UIViewController *ctrl = [[NSClassFromString(classString) alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
    
}

@end
