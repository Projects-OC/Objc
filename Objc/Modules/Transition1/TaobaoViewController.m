//
//  TaobaoViewController.m
//  Object-CDemo
//
//  Created by Mac on 2018/3/26.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "TaobaoViewController.h"
#import "TaobaoSecondViewController.h"
#import "TaobaoAnimationTrasition.h"
#import "TaobaoTableViewCell.h"

@interface TaobaoViewController ()<UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView      *tableView;
@property (nonatomic, strong) NSMutableArray   *imageDataArray;

@property (nonatomic, strong) TaobaoAnimationTrasition *animatedTransition;

@end

@implementation TaobaoViewController

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.animatedTransition = nil;
    self.navigationController.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    _imageDataArray = [NSMutableArray array];
    //构造图片数据
    for (int i = 1; i < 10; i ++) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"Expression%.2d",i] ofType:@"jpeg"];
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        [_imageDataArray addObject:img];
    }
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _imageDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TaobaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TaobaoTableViewCell class])];
    if (!cell) {
        cell = [[TaobaoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TaobaoTableViewCell class])];
    }
    cell.cellIndex = indexPath.row;
    [cell setImageForImgView:_imageDataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //1. 设置代理
    self.animatedTransition = nil;
    self.navigationController.delegate = self.animatedTransition;
    
    //2. 传入必要的3个参数
    
    TaobaoTableViewCell * cell = (TaobaoTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    CGRect imgFrame = [self getFrameInWindow:cell.imgView];
    
    [self.animatedTransition setTransitionImgView:cell.imgView];
    [self.animatedTransition setTransitionBeforeImgFrame:imgFrame];
    [self.animatedTransition setTransitionAfterImgFrame:[self backScreenImageViewRectWithImage:cell.imgView.image]];
    
    //3.push跳转
    TaobaoSecondViewController *second = [[TaobaoSecondViewController alloc] init];
    second.image = cell.imgView.image;
    second.imgFrame = [self backScreenImageViewRectWithImage:cell.imgView.image];
    [self.navigationController pushViewController:second animated:YES];
}

#pragma mark - Setter - Getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithRed:0.1 green:0.7 blue:0.4 alpha:1];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (TaobaoAnimationTrasition *)animatedTransition{
    if (!_animatedTransition) {
        _animatedTransition = [[TaobaoAnimationTrasition alloc] init];
    }
    return _animatedTransition;
}

// 获取指定视图在window中的位置
- (CGRect)getFrameInWindow:(UIView *)view{
    return [view.superview convertRect:view.frame toView:nil];
}

- (CGRect)backScreenImageViewRectWithImage:(UIImage *)image{
    CGSize size = image.size;
    CGSize newSize;
    newSize.height = kScreenWidth * 0.6;
    newSize.width = newSize.height / size.height * size.width;
    
    CGFloat imageY = 64;
    CGFloat imageX = (kScreenWidth - newSize.width) * 0.5;
    
    CGRect rect =  CGRectMake(imageX, imageY, newSize.width, newSize.height);
    return rect;
}

@end
