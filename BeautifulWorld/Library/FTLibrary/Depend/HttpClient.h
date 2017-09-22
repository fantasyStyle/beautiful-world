//
//  HttpClient.h
//  chinaJuJiao
//
//  Created by hfanfeng on 15/6/1.
//  Copyright (c) 2015年 hfanfeng. All rights reserved.
//

#import "TTIClientManager.h"


@interface HttpClient : TTIClientManager


/**
 *  判断网络状态 0=没有网络 1=2G 2=3G 3=4G 4=LTE 5=WIFI
 *
 *  @return 0
 */
+ (NSInteger )getNetworkType;
/**
 *  判断网络状态 持续监控
 */
+ (void)isNetReachable;

/**
 *  单例
 *
 *  @return 单例
 */
+(HttpClient *)shareInstance;
#pragma mark ROE接口



-(void)requestApiWithurl:(NSString *)url parmar:(NSMutableDictionary *)parmars  success:(TTIClientManagerBlock)success
                 failuer:(TTIClientManagerBlock)failure;



@end
