//
//  TTIClient.h
//  AFNetWorkingDemo
//
//  Created by zym on 14-8-8.
//  Copyright (c) 2014年 翔傲信息科技（上海）有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTIClientConfig.h"
#import "UIKit+AFNetworking.h"
#import "AFNetworking.h"

#import "AFHTTPSessionManager.h"


@class TTIClientManager;

typedef void(^ TTIClientManagerBlock)(NSURLSessionDataTask *_Nonnull task,id _Nullable responseObject);

@interface TTIClientManager : NSObject

@property (nonatomic, strong) AFHTTPSessionManager * manager;   //网络请求管理


/**
 *  通用的解析方法
 *  1、继承直接调用即可。
 *  2、如果需要其他解析方式，可以继承重写，或者在子类写其他解析方法。
 *
 *  @param response  返回数据
 *  @param operation 请求
 *  @param success   成功block
 *  @param failure   失败block
 */
-(void)parseResponse:(id)response
           operation:(NSURLSessionDataTask *)operation
             success:(void(^)(NSURLSessionDataTask *_Nonnull task,id _Nullable responseObject))success
             failure:(void(^)(NSURLSessionDataTask *_Nonnull task,id _Nullable responseObject))failure;

-(void)initAfterLoginManager;

@end





/**
 *  视频缓存
 *
 *  @param downLoadUrl 缓存地址
 */
typedef void(^ TTINetManagerBlock)(NSURL *downLoadUrl);

@interface TTINetManager : AFHTTPSessionManager

@property (nonatomic, strong) AFHTTPSessionManager *manager;   //网络请求管理


@end

