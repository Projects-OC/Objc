//
//  HFBaseTableView.m
//  HF_Client_iPhone_Application
//
//  Created by header on 2018/9/21.
//  Copyright © 2018年 HengFeng. All rights reserved.
//

#import "HFBaseTableView.h"

@implementation HFBaseTableView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self config];
    }
    return self;
}

-(void)config{
    self.emptyTitle = @"";
    self.emptyImage = @"";
    self.delaysContentTouches = NO;
    self.canCancelContentTouches = YES;
    self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    self.emptyDataSetSource = self;
    self.emptyDataSetDelegate = self;
    
    [self reloadEmptyDataSet];
}

- (void)registerClassCells:(NSArray <Class>*_Nullable)cells {
    [cells enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self registerClass:obj forCellReuseIdentifier:NSStringFromClass(obj)];
    }];
}

- (void)registerClassHeaderFooters:(NSArray <Class>*_Nullable)headerFooters {
    [headerFooters enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self registerClass:obj forHeaderFooterViewReuseIdentifier:NSStringFromClass(obj)];
    }];
}

-(BOOL)touchesShouldCancelInContentView:(UIView *)view{
    if ([view isKindOfClass:[UIControl class]]) {
        return YES;
    }
    return [super touchesShouldCancelInContentView:view];
}

- (void)setEmptyTitle:(NSString *)emptyTitle {
    _emptyTitle = emptyTitle;
}

- (void)setEmptyImage:(NSString *)emptyImage {
    _emptyImage = emptyImage;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:self.emptyImage];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                 NSForegroundColorAttributeName:[UIColor redColor]};
    return [[NSAttributedString alloc] initWithString:self.emptyTitle attributes:attributes];
}

//空数据提示纵向偏移量
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return _verticalOffset;
}

//是否允许交互
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView{
    return YES;
}

//是否允许滑动,当加载数据时 不允许滑动
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

//空页面点击回调
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{
    if (_tapViewBlock) {
        _tapViewBlock();
    }
}

@end
