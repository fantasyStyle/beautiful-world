//
//  FTShowMessageView.h
//  NewWorld
//
//  Created by fantasy  on 2017/2/16.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTShowMessageView : NSObject
/**
 *  展示错误信息
 *
 *  @param message 信息内容
 */
+ (void)showErrorWithMessage:(NSString *)message;
/**
 *  展示成功信息
 *
 *  @param message 信息内容
 */
+ (void)showSuccessWithMessage:(NSString *)message;
/**
 *  展示提交状态
 *
 *  @param message 信息内容
 */
+ (void)showStatusWithMessage:(NSString *)message;
/**
 *  隐藏弹出框
 */
+ (void)dismissSuccessView:(NSString *)message;
+ (void)dismissErrorView:(NSString *)message;

+(void)dismiss;

@end
