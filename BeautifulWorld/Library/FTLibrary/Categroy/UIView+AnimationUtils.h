//
//  UIView+AnimationUtils.h
//  iOSCodeProject
//
//  Created by Fox on 14-7-19.
//  Copyright (c) 2014年 翔傲信息科技（上海）有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TTIAnimationFinished)(void);

/**
 *  常用动画工具类
 */
@interface UIView (AnimationUtils)

/**
 *  设置视图的X位置，并且添加动画
 *
 *  @param x        设置的x位置
 *  @param time     动画时间
 *  @param finished 完成后的操作
 */
-(void)setX:(CGFloat)x duration:(NSTimeInterval)time finished:(TTIAnimationFinished)finished;

/**
 *  移动视图X的位置
 *
 *  @param x        x移动的值，为正向右移动，为负向左移动
 *  @param time     动画时间
 *  @param finished 完成后的操作
 */
-(void)moveX:(CGFloat)x duration:(NSTimeInterval)time finished:(TTIAnimationFinished)finished;

/**
 *  设置视图的Y位置，并且添加动画
 *
 *  @param y        设置Y的位置
 *  @param time     动画时间
 *  @param finished 完成后的操作
 */
-(void)setY:(CGFloat)y duration:(NSTimeInterval)time finished:(TTIAnimationFinished)finished;

/**
 *  移动视图Y的位置
 *
 *  @param y        y移动的值，为正向下移动，为负向上移动
 *  @param time     动画时间
 *  @param finished 完成后的操作
 */
-(void)moveY:(CGFloat)y duration:(NSTimeInterval)time finished:(TTIAnimationFinished)finished;

/**
 *  设置旋转角度
 *
 *  @param r        角度（0~360）
 *  @param time     动画时间
 *  @param finished 完成后的操作
 */
-(void)setRotation:(CGFloat)r duration:(NSTimeInterval)time finished:(TTIAnimationFinished)finished;

/**
 *  移动视图的角度
 *
 *  @param r        角度
 *  @param time     动画时间
 *  @param finished 完成后的操作
 */
-(void)moveRotation:(CGFloat)r duration:(NSTimeInterval)time finished:(TTIAnimationFinished)finished;

/**
 *  心跳动画（放大后在缩小）
 *
 *  @param finished 完成后的操作
 */
-(void)pulse:(TTIAnimationFinished)finished;

/**
 *  左右摇晃效果
 *
 *  @param finished 完成后的操作
 */
-(void)shake:(TTIAnimationFinished)finished;

/**
 *  摇摆效果
 *
 *  @param finished 完成后的操作
 */
-(void)swing:(TTIAnimationFinished)finished;

/**
 *  心跳的效果
 *
 *  @param finished 完成后的操作
 */
-(void)tada:(TTIAnimationFinished)finished;

@end
