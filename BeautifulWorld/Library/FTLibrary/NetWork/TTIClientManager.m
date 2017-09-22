//
//  TTIClient.m
//  AFNetWorkingDemo
//
//  Created by zym on 14-8-8.
//  Copyright (c) 2014年 翔傲信息科技（上海）有限公司. All rights reserved.
//

#import "TTIClientManager.h"
#import "TTIClientConfig.h"
//#import "AFNetworkActivityLogger.h"
#import "AFNetworkActivityIndicatorManager.h"

#import "NSData+AES256.h"

@interface TTIClientManager ()

@end


@implementation TTIClientManager


-(id)init{
    self = [super init];
    if (self) {
        //设置baseurl
        self.manager = [AFHTTPSessionManager manager];
        
        //AF2.0默认是使用AFJSONResponseSerializer自行对JSON进行解析。（如果请求成功，但是JSON无法解析，错误代码为3840）
        //想要AF2.0使用第三方解析，那么需要将设置为AFHTTPResponseSerializer即可，那么返回值为respondata，需要自己解析。
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
      //  _manager.requestSerializer = [AFJSONRequestSerializer serializer];
       _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        NSLog(@"朝阳存储的数据为%@",[UserInfo sharedUserInfo].auth);

            [_manager.requestSerializer setValue:[UserInfo sharedUserInfo].auth forHTTPHeaderField:@"Auth"];
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _manager.requestSerializer.timeoutInterval = 8.f;
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];

        
        
        //AF2.0只支持text/json，application/json，text/javascript三种格式，如果需要支持其他格式，请自行添加。
        _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
    }
    return self;
}
-(void)initAfterLoginManager{
    //设置baseurl
    self.manager = [AFHTTPSessionManager manager];

    
    //AF2.0默认是使用AFJSONResponseSerializer自行对JSON进行解析。（如果请求成功，但是JSON无法解析，错误代码为3840）
    //想要AF2.0使用第三方解析，那么需要将设置为AFHTTPResponseSerializer即可，那么返回值为respondata，需要自己解析。
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //  _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSLog(@"朝阳存储的数据为%@",[UserInfo sharedUserInfo].auth);
    
    [_manager.requestSerializer setValue:[UserInfo sharedUserInfo].auth forHTTPHeaderField:@"Auth"];
    
    [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    _manager.requestSerializer.timeoutInterval = 8.f;
    [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    

    
    //AF2.0只支持text/json，application/json，text/javascript三种格式，如果需要支持其他格式，请自行添加。
    _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;

}
-(void)parseResponse:(id)response
           operation:(NSURLSessionDataTask *)operation
             success:(void(^)(NSURLSessionDataTask *_Nonnull task,id _Nullable responseObject))success
             failure:(void(^)(NSURLSessionDataTask *_Nonnull task,id _Nullable responseObject))failure{
    
    if (operation.error) {
        NSLog(@"operation.error:%@",operation.error);
        if (operation.error.code == 3840) {
            failure(operation,[NSDictionary dictionaryWithObjects:@[@"3804", @"Data format error"] forKeys:@[NET_SUCCESS, NET_ERROR_MSG]]);
            return;
        }else if (operation.error.code == -1004)
        {
            failure(operation,[NSDictionary dictionaryWithObjects:@[@"-1004", @"无法连接服务器,请稍后重试"] forKeys:@[NET_SUCCESS, NET_ERROR_MSG]]);
            return;
        }else if (operation.error.code == -1001)
        {
            failure(operation,[NSDictionary dictionaryWithObjects:@[@"-1001", NetErrorInfo] forKeys:@[NET_SUCCESS, NET_ERROR_MSG]]);
            [HUD showAlertWithTitle:NetErrorInfo duration:2.0];
            return;
        }
 
        else
        {
            NSString *code = [NSString stringWithFormat:@"%ld",(long)operation.error.code];
            failure(operation,[NSDictionary dictionaryWithObjects:@[code, operation.error.localizedDescription] forKeys:@[NET_SUCCESS, NET_ERROR_MSG]]);
            return;
        }
    }else{
        NSDictionary *responseDic = (NSDictionary *)response;
        
        NSNumberFormatter*numberFor = [[NSNumberFormatter alloc]init];
        
        NSString *statusStr = [numberFor stringFromNumber:[responseDic objectForKey:NET_status]];
        if ([statusStr isEqualToString:@"0"] )
        {
            
            if (success)
            {
                
               success(operation,[responseDic objectForKey:NET_RESULT]);
                
                    if ([[responseDic allKeys] containsObject:NET_EXTEND]) {
                    id extendObject =[responseDic objectForKey:NET_EXTEND];
                    
                    if (extendObject != [NSNull null]) {
                         [UserInfo sharedUserInfo].auth = [extendObject objectForKey:@"auth"];
                        [[UserInfo sharedUserInfo] saveUserInofFromSanbox];
                        NSLog(@"夕阳下存储的数据为%@",[UserInfo sharedUserInfo].auth);

                    }
                    else{
                        NSLog(@"扩展数据为%@",extendObject);
                        //[UserInfo sharedUserInfo].auth = nil;


                       
                    }
                }
                return;

            }

        }else{
            if (failure) {
                failure(operation,responseDic);
                [FTShowMessageView dismissErrorView:NetErrorInfo];
                
                NSLog(@"调用失败");
                return;
            }
        }
    }

}

- (NSString *)stringToHex:(NSString *)string
{
    char *utf8 = [string UTF8String];
    NSMutableString *hex = [NSMutableString string];
    while ( *utf8 ) [hex appendFormat:@"%02X" , *utf8++ & 0x00FF];
    
    return [NSString stringWithFormat:@"%@", hex];
}

@end






@implementation TTINetManager


-(id)init{
    self = [super init];
    if (self) {
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://192.168.20.98/bnw/api/"]];
        
        
        //网络监测
        NSOperationQueue *operationQueue = self.manager.operationQueue;
        [self.manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    [operationQueue setSuspended:NO];
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                default:
                    [operationQueue setSuspended:YES];
                  //  [HUD showAlertWithTitle:@"网络异常，请检查网络"];
                    break;
            }
        }];
        //开始监控
        [self.manager.reachabilityManager startMonitoring];
    }
    
    return self;
}



@end

