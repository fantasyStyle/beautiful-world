//
//  FTRefreshGifFooter.m
//  NewWorld
//
//  Created by fantasy  on 2017/2/15.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "FTRefreshGifFooter.h"
#import "FTUtilsMethod.h"
@implementation FTRefreshGifFooter
- (void)prepare
{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=12; i++) {
        NSString *imageName = [NSString stringWithFormat:@"refresh%ld.png", i];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *newImage = [FTUtilsMethod imageByScalingToSize:CGSizeMake(40, 40) andSourceImage:image];
        [idleImages addObject:newImage];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=12; i++) {
        NSString *imageName = [NSString stringWithFormat:@"refresh%ld.png", i];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *newImage = [FTUtilsMethod imageByScalingToSize:CGSizeMake(40, 40) andSourceImage:image];
        [refreshingImages addObject:newImage];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    NSMutableArray *startImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<= 12; i++) {
        NSString *imageName = [NSString stringWithFormat:@"refresh%ld.png", i];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *newImage = [FTUtilsMethod imageByScalingToSize:CGSizeMake(40, 40) andSourceImage:image];
        [startImages addObject:newImage];
    }
    // 设置正在刷新状态的动画图片
    [self setImages:startImages forState:MJRefreshStateRefreshing];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
