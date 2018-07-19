//
//  CoreAnimationViewController.m
//  Object-CDemo
//
//  Created by mf on 2018/7/4.
//  Copyright © 2018年 MF. All rights reserved.
//

#import "CoreAnimationViewController.h"
#import "ClockView.h"

@interface CoreAnimationViewController ()<CALayerDelegate>

@property (nonatomic,weak) UIView *layerView;
@property (nonatomic,weak) CALayer *blueLayer;
@property (nonatomic,strong) ClockView *clockView;

@end

@implementation CoreAnimationViewController

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (_clockView.timer) {
        [_clockView.timer invalidate];
    }
}

/**
 布局
 view:frame,bounds,center
 layer:frame,bounds,postion
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self emitterLayer];
//    [self textlayer];
//    [self rectCorner];
//    [self drawLayerPerson];
//    [self layerDisplay];
//    [self clock];
}

//画时钟+计算弧度
- (void)clock {
    _clockView = [[ClockView alloc] init];
    [self.view addSubview:_clockView];
    [_clockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.centerOffset(CGPointZero);
    }];
}

//CATextLayer
- (void)textlayer {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(200, 200, 300, 100)];
    view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view];
    
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = view.bounds;
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    textLayer.string = @"CATextLayer text";
    [view.layer addSublayer:textLayer];
    
}

//CAEmitterLayer
- (void)emitterLayer {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 300, 200)];
    view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view];
    
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = view.bounds;
    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterPosition = CGPointMake(emitter.frame.size.width, emitter.frame.size.height);
    [view.layer addSublayer:emitter];
    
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = [UIImage imageNamed:@"ios-template-58"];
    cell.color = [UIColor blueColor].CGColor;
    cell.lifetime = 5;
    cell.birthRate = 150;
    emitter.emitterCells = @[cell];
}

//画线
- (void)drawLayerPerson {
    UIView *personView = [[UIView alloc] initWithFrame:self.view.bounds];
    personView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:personView];
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.path = path.CGPath;
    shapeLayer.lineWidth = 5;
    [personView.layer addSublayer:shapeLayer];
}

//圆角
- (void)rectCorner {
    UIView *cornerView = [[UIView alloc] initWithFrame:CGRectMake(200, 200, 100, 100)];
    cornerView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:cornerView];
    
    UIRectCorner corners = UIRectCornerTopLeft | UIRectCornerBottomLeft;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:cornerView.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(10, 10)];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = path.CGPath;
    cornerView.layer.mask = shapeLayer;
}

//动画
- (void)layerDisplay {
    UIView *_layerView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    _layerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_layerView];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(50, 50, 100, 100);
    layer.delegate = self;
    layer.backgroundColor = [UIColor blueColor].CGColor;
    [_layerView.layer addSublayer:layer];
    [layer display];
    self.layerView = _layerView;
    _blueLayer = layer;
    
    [self viewTransformTag:3];
}

- (void)viewTransformTag:(NSInteger)tag {
    switch (tag) {
        case 1:
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //缩小50%，旋转30弧度，向右移动200
                [UIView animateWithDuration:0.2 animations:^{
                    CGAffineTransform transform = CGAffineTransformIdentity;
                    transform = CGAffineTransformScale(transform, 0.5, 0.5);
                    transform = CGAffineTransformRotate(transform, M_PI_4);
                    transform = CGAffineTransformTranslate(transform, 100, 0);
                    _layerView.layer.affineTransform = transform;
                }completion:^(BOOL finished) {
                    _layerView.layer.affineTransform = CGAffineTransformIdentity;
                }];
            });
        }
            break;
        case 2:
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.2 animations:^{
                    CATransform3D transform = CATransform3DMakeRotation(M_PI_4, 50, 50, 50);
                    _layerView.layer.transform = transform;
                } completion:^(BOOL finished) {
                    _layerView.layer.transform = CATransform3DIdentity;
                }];
            });
        }
            break;
        case 3:
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.2 animations:^{
                    CATransform3D transform = CATransform3DIdentity;
                    transform.m34 = -1/500.0;
                    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
                    
                    _layerView.layer.transform = transform;
                } completion:^(BOOL finished) {
                    _layerView.layer.transform = CATransform3DIdentity;
                }];
            });
        }
            break;
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self.view];
    CALayer *layer = [_layerView.layer hitTest:point];
    if (layer == _blueLayer) {
        NSLog(@"blueLayer");
    } else if (layer == _layerView.layer) {
        NSLog(@"layerView.layer");
    }
}

//在蓝色layer中画白色圆圈⭕️
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    CGContextSetLineWidth(ctx, 1);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}

- (void)layerContents {
    UIView *_layerView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _layerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_layerView];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(50, 50, 50, 50);
    layer.backgroundColor = [UIColor blueColor].CGColor;
    [_layerView.layer addSublayer:layer];
    
    UIImage *image = [UIImage imageNamed:@"Expression03.jpeg"];
    _layerView.layer.contents = (__bridge id _Nullable)(image.CGImage);
    /*
     layer.contentsGravity 和 view.contentMode一样
     如果设置的layer.contentsGravity属性，contentScale会失效
     self.view.contentMode = UIViewContentModeScaleToFill;
     */
    _layerView.layer.contentsGravity = kCAGravityResizeAspectFill;
}

@end
