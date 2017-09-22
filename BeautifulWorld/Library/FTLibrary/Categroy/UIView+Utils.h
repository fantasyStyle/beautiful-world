 //
//  UIView+Utils.h
//  Borrowed from Three20 / DTFoundation
//
//  Created by zym on 14-7-18.
//  Copyright (c) 2014年 翔傲信息科技（上海）有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (Utils)

/**
 *  获取起点
 */
- (CGPoint)origin;
/**
 *  设置起点
 *
 *  @param point 起点
 */
- (void)setOrigin:(CGPoint) point;

/**
 *  获取大小
 */
- (CGSize)size;

/**
 *  设置大小
 *
 *  @param size 大小
 */
- (void)setSize:(CGSize) size;

/**
 *  获取x坐标
 */
- (CGFloat)x;

/**
 *  设置X坐标
 *
 *  @param x 坐标
 */
- (void)setX:(CGFloat)x;

/**
 *  获取y坐标
 */
- (CGFloat)y;

/**
 *  设置y坐标
 *
 *  @param y y坐标
 */
- (void)setY:(CGFloat)y;

/**
 *  获取height
 */
- (CGFloat)height;

/**
 *  设置height
 *
 *  @param height height
 */
- (void)setHeight:(CGFloat)height;

/**
 *  获取width
 */
- (CGFloat)width;

/**
 *  设置width
 *
 *  @param width width
 */
- (void)setWidth:(CGFloat)width;

/**
 *  获取尾标
 */
- (CGFloat)tail;

/**
 *  设置尾标
 *
 *  @param tail 尾标
 */
- (void)setTail:(CGFloat)tail;

/**
 *  获取尾标
 */
- (CGFloat)bottom;

/**
 *  设置尾标
 *
 *  @param tail 尾标
 */
- (void)setBottom:(CGFloat)bottom;

/**
 *  获取右标
 */
- (CGFloat)right;

/**
 *  设置右标
 *
 *  @param right 右标
 */
- (void)setRight:(CGFloat)right;

/**
 *  查找特殊类的第一个子视图
 *
 *  @param cls 特殊类
 *
 *  @return 子视图
 */
- (UIView*)descendantOrSelfWithClass:(Class)cls;

/**
 *  查找特殊类的第一个父视图
 *
 *  @param cls 特殊类
 *
 *  @return 父视图
 */
- (UIView*)ancestorOrSelfWithClass:(Class)cls;

/**
 *  移除所有视图
 */
- (void)removeAllSubviews;

/**
 *  快速创建一个单击句柄
 *
 *  @param block 句柄block
 */
- (void)setTapActionWithBlock:(void (^)(void))block;

/**
 *  快速创建一个长按句柄
 *
 *  @param block 句柄block
 */
- (void)setLongPressActionWithBlock:(void (^)(void))block;

@end
