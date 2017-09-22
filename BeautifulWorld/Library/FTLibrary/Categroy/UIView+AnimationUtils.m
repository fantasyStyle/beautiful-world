//
//  UIView+AnimationUtils.m
//  iOSCodeProject
//
//  Created by Fox on 14-7-19.
//  Copyright (c) 2014年 翔傲信息科技（上海）有限公司. All rights reserved.
//

#import "UIView+AnimationUtils.h"

CGFloat degreesToRadians(CGFloat degrees)
{
    return degrees * M_PI / 180;
}

@implementation UIView (AnimationUtils)

-(void)setX:(CGFloat)x duration:(NSTimeInterval)time finished:(TTIAnimationFinished)finished{
    
    [UIView animateWithDuration:time animations:^{
        CGRect frame = self.frame;
        frame.origin.x = x;
        self.frame = frame;
    } completion:^(BOOL f){
        if(finished)
            finished();
    }];
    
}

-(void)moveX:(CGFloat)x duration:(NSTimeInterval)time finished:(TTIAnimationFinished)finished{
    [self setX:(self.frame.origin.x+x) duration:time finished:finished];
}

-(void)setY:(CGFloat)y duration:(NSTimeInterval)time finished:(TTIAnimationFinished)finished{
    [UIView animateWithDuration:time animations:^{
        CGRect frame = self.frame;
        frame.origin.y = y;
        self.frame = frame;
    }completion:^(BOOL f){
        if(finished)
            finished();
    }];
}

-(void)moveY:(CGFloat)y duration:(NSTimeInterval)time finished:(TTIAnimationFinished)finished{
    [self setY:(self.frame.origin.y+y) duration:time finished:finished];
}

-(void)setRotation:(CGFloat)r duration:(NSTimeInterval)time finished:(TTIAnimationFinished)finished{

    [UIView animateWithDuration:time animations:^{
        CGAffineTransform rotationTransform = CGAffineTransformIdentity;
        self.transform = CGAffineTransformRotate(rotationTransform, degreesToRadians(r));
    } completion:^(BOOL f){
        if(finished)
            finished();
    }];
}

-(void)moveRotation:(CGFloat)r duration:(NSTimeInterval)time finished:(TTIAnimationFinished)finished{
    [UIView animateWithDuration:time animations:^{
        CGAffineTransform rotationTransform = self.transform;
        self.transform = CGAffineTransformRotate(rotationTransform, degreesToRadians(r));
    } completion:^(BOOL f){
        if(finished)
            finished();
    }];
}

-(void)pulse:(TTIAnimationFinished)finished{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL f){
        [UIView animateWithDuration:0.5 delay:0.1 options:0 animations:^{
            self.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL f){
            if(finished)
                finished();
        }];
    }];
}

-(void)shake:(TTIAnimationFinished)finished{
    
    float dist = 10;
    [self moveX:-dist duration:0.15 finished:^{
        [self moveX:dist*2 duration:0.15 finished:^{
            [self moveX:-(dist*2) duration:0.15 finished:^{
                [self moveX:dist duration:0.15 finished:^{
                    if(finished)
                        finished();
                }];
            }];
        }];
    }];
}

-(void)swing:(TTIAnimationFinished)finished{
    
    float dist = 15;
    float dur = 0.20;
    __weak id weakSelf = self;
    [weakSelf setRotation:dist duration:dur finished:^{
        [weakSelf setRotation:-dist duration:dur finished:^{
            [weakSelf setRotation:dist/2 duration:dur finished:^{
                [weakSelf setRotation:-dist/2 duration:dur finished:^{
                    [weakSelf setRotation:0 duration:dur finished:^{
                        if(finished)
                            finished();
                    }];
                }];
            }];
        }];
    }];
}

-(void)tada:(TTIAnimationFinished)finished{
    
    float dist = 3;
    float dur = 0.12;
    [UIView animateWithDuration:dur animations:^{
        CGAffineTransform rotationTransform = CGAffineTransformMakeScale(0.95, 0.95);
        rotationTransform = CGAffineTransformRotate(rotationTransform, degreesToRadians(dist));
        self.transform = rotationTransform;
    } completion:^(BOOL f){
        [UIView animateWithDuration:dur animations:^{
            CGAffineTransform rotationTransform = CGAffineTransformMakeScale(1.05, 1.05);
            rotationTransform = CGAffineTransformRotate(rotationTransform, degreesToRadians(-dist));
            self.transform = rotationTransform;
        } completion:^(BOOL f){
            
            __weak id weakSelf = self;
            [weakSelf moveRotation:dist*2 duration:dur finished:^{
                [weakSelf moveRotation:-dist*2 duration:dur finished:^{
                    [weakSelf moveRotation:dist*2 duration:dur finished:^{
                        [weakSelf moveRotation:-dist*2 duration:dur finished:^{
                            [UIView animateWithDuration:dur animations:^{
                                CGAffineTransform rotationTransform = CGAffineTransformMakeScale(1, 1);
                                rotationTransform = CGAffineTransformRotate(rotationTransform, degreesToRadians(0));
                                self.transform = rotationTransform;
                            } completion:^(BOOL f){
                                if(finished)
                                    finished();
                            }];
                        }];
                    }];
                }];
            }];
            
        }];
    }];
}

@end
