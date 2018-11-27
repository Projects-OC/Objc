//
//  UIView+HF.m
//  Objc
//
//  Created by header on 2018/11/27.
//  Copyright © 2018年 mf. All rights reserved.
//

#import "UIView+HF.h"

@implementation UIView (HF)

+ (NSMutableArray *)layerBorderPostions:(NSMutableArray *)postions
                            borderColor:(UIColor *)borderColor
                           cornerRadius:(CGFloat)cornerRadius
                            borderWidth:(CGFloat)borderWidth{
    NSMutableArray *layers = [NSMutableArray new];
    /*
    [postions enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CALayer *layer = [CALayer layer];
        BorderPostion postiom = obj.integerValue;
        if (postiom == BorderTop) {
            layer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame),borderWidth);
        }
        else if (postiom == BorderLeft) {
            layer.frame = CGRectMake(0, 0, borderWidth, CGRectGetHeight(self.frame));
        }
        else if (postiom == BorderBottom) {
            layer.frame = CGRectMake(0, CGRectGetHeight(self.frame) - borderWidth, CGRectGetWidth(self.frame), borderWidth);
        }
        else {
            layer.frame = CGRectMake(CGRectGetWidth(self.frame) - borderWidth, 0, borderWidth, CGRectGetHeight(self.frame));
        }
        layer.backgroundColor = borderColor.CGColor;
        [self.layer addSublayer:layer];
        [layers addObject:layer];
    }];*/
    return layers;
}

+ (void)layerCorners:(NSMutableArray *)corners cornerRadius:(CGFloat)cornerRadius {
    __block UIRectCorner corner = 0;
    [corners enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIRectCorner cor = obj.integerValue;
        corner |= cor;
        if (cor == UIRectCornerAllCorners) {
            corner = cor;
            *stop = YES;
        }
    }];
    /*
    UIBezierPath *bezier = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = self.bounds;
    bezier.path = shape.CGPaths;
    self.layer.mask = bezier;
     */

}

@end
