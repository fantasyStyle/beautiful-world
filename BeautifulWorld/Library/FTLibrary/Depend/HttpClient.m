//
//  HttpClient.m
//  chinaJuJiao
//
//  Created by feng on 15/6/1.
//  Copyright (c) 2015年 feng. All rights reserved.
//

#import "HttpClient.h"
#import "NSMutableDictionary+Utils.h"


#define REQUEST_ADDRESS  @""

//#define BASEURL @"http://open.leleda.com/"
//
#define BASEURL @"http://bnw.jinghuan.info/bnw/api/"
//#define BASEURL @"http://192.168.20.98/bnw/api/"



/******************  网络接口 ***********************/


@implementation HttpClient

#pragma mark 网络判断

// 判断网络状态
+ (NSInteger )getNetworkType
{

    
    NSArray *subviews = [[[[UIApplication sharedApplication] valueForKey:@"statusBar"] valueForKey:@"foregroundView"]subviews];
    NSNumber *dataNetworkItemView = nil;
    
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    
    NSInteger netType;
    switch ([[dataNetworkItemView valueForKey:@"dataNetworkType"]integerValue]) {
        case 0:{
            netType = 0;
        }
            break;
            
        case 1:
        {
            netType = 1;
        }
            break;
            
        case 2:
        {
            netType = 2;
        }
            break;
            
        case 3:
        {
            netType = 3;
        }
            break;
            
        case 4:
        {
            netType = 4;
        }
            break;
            
        case 5:
        {
            netType = 5;
        }
            break;
            
        default:{
            netType = 6;
        }     }
    
    return netType ;
}
+ (void)isNetReachable
{
    
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [HUD showAlertWithTitle:@"The Internet connection appears to be offline."];
                });
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"AFNetworkReachabilityStatusReachableViaWWAN");
                break;
                
            default:
                
                break;
        }
    }];
    [mgr startMonitoring];
}

//字典转化为JSON串
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}



static HttpClient *instance = nil;

//单例
+(HttpClient *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HttpClient alloc] init];
    });
    
    return instance;
}

#pragma mark 接口


-(void)requestApiWithurl: (NSString *)url
                  parmar:(NSMutableDictionary *)parmars
                 success:(TTIClientManagerBlock)success
                 failuer:(TTIClientManagerBlock)failure
{
    [self initAfterLoginManager];
    [self.manager POST:[NSString stringWithFormat:@"%@%@",BASEURL,url]
            parameters:parmars
               success:^(NSURLSessionDataTask *task, id response){
                   [self parseResponse:response operation:task success:success failure:failure];
               }
     
    
               failure:^(NSURLSessionDataTask *task, NSError *error){
                   [self parseResponse:task.response operation:task success:success failure:failure];
               }

     ];
}




@end
