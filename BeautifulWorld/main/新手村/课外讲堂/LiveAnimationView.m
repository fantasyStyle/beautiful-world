//
//  LiveAnimationView.m
//  SUNLiveAnimation
//
//  Created by 孙金帅 on 16/5/27.
//  Copyright © 2016年 com.51fanxing. All rights reserved.
//

#import "LiveAnimationView.h"
#import "UIView+Frame.h"


static NSTimeInterval const liveAnimationDuration = 6;

@interface LiveAnimationView ()

@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, strong) UIView *superView;

@end
@implementation LiveAnimationView

- (instancetype)initWithFrame:(CGRect)frame withSuperView:(UIView *)superView
{
    if (self = [super initWithFrame:frame]) {
        
        self.superView = superView;
        self.borderColor = [UIColor whiteColor];
        self.fillColor = [UIColor colorWithRed:(arc4random_uniform(255))/255.0 green:(arc4random_uniform(255))/255.0 blue:(arc4random_uniform(255))/255.0 alpha:1];
        self.backgroundColor = [UIColor clearColor];
        self.layer.anchorPoint = CGPointMake(0.5, 1);
    }
    return self;
}

- (void)addAnimationView
{
    // 初始化
    self.transform = CGAffineTransformMakeScale(0, 0);
    self.alpha = 0;
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 0.9;
    } completion:^(BOOL finished) {
        
    }];

    // 随机数
    NSInteger i = arc4random_uniform(2);
    NSInteger rotationDirection = 1 - (2*i);
    
    // 绘制路径
    UIBezierPath *heartTravelPath = [UIBezierPath bezierPath];
    [heartTravelPath moveToPoint:self.center];
    
    CGPoint endPoint = CGPointMake(self.centerX + (rotationDirection) * arc4random_uniform(2*self.width), self.superView.height/6.0 + arc4random_uniform(self.superView.height/4.0));

    CGFloat x = (self.width/2.0 + arc4random_uniform(2*self.width)) * rotationDirection;
    CGFloat y = MAX(endPoint.y ,MAX(arc4random_uniform(8*self.width), self.width));
    CGPoint controlPoint1 = CGPointMake(self.centerX + x, self.superView.height - y);
    CGPoint controlPoint2 = CGPointMake(self.centerX - 2*x, y);
    
    [heartTravelPath addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAnimation.path = heartTravelPath.CGPath;
    keyFrameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    keyFrameAnimation.duration = liveAnimationDuration + endPoint.y/self.superView.height;
    [self.layer addAnimation:keyFrameAnimation forKey:@"positionOnPath"];
    
    [UIView animateWithDuration:liveAnimationDuration animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}


- (void)drawRect:(CGRect)rect
{
    
    [self.fillColor setFill];
    [self.borderColor setStroke];
    
    CGFloat drawingPadding = 2.0;
    CGFloat curveRadius = floor((CGRectGetWidth(rect) - 2*drawingPadding) / 4.0);
    
    UIBezierPath *heartPath = [UIBezierPath bezierPath];
    
    CGPoint tipLocation = CGPointMake(floor(CGRectGetWidth(rect) / 2.0), CGRectGetHeight(rect) - drawingPadding);
    [heartPath moveToPoint:tipLocation];
    
    CGPoint topLeftCurveStart = CGPointMake(drawingPadding, floor(CGRectGetHeight(rect) / 3));
    
    [heartPath addQuadCurveToPoint:topLeftCurveStart controlPoint:CGPointMake(topLeftCurveStart.x, topLeftCurveStart.y + curveRadius)];
    
    [heartPath addArcWithCenter:CGPointMake(topLeftCurveStart.x + curveRadius, topLeftCurveStart.y) radius:curveRadius startAngle:M_PI endAngle:0 clockwise:YES];
    
    CGPoint topRightCurveStart = CGPointMake(topLeftCurveStart.x + 2*curveRadius, topLeftCurveStart.y);
    [heartPath addArcWithCenter:CGPointMake(topRightCurveStart.x + curveRadius, topRightCurveStart.y) radius:curveRadius startAngle:M_PI endAngle:0 clockwise:YES];
    
    CGPoint topRightCurveEnd = CGPointMake(topLeftCurveStart.x + 4*curveRadius, topRightCurveStart.y);
    [heartPath addQuadCurveToPoint:tipLocation controlPoint:CGPointMake(topRightCurveEnd.x, topRightCurveEnd.y + curveRadius)];
    
    [heartPath fill];
    
    heartPath.lineWidth = 1;
    heartPath.lineCapStyle = kCGLineCapRound;
    heartPath.lineJoinStyle = kCGLineCapRound;
    [heartPath stroke];

}

@end
