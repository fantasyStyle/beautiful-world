//
//  AppDelegate.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/2/21.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "AppDelegate.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "MyTabBarViewController.h"
#import "LeadViewController.h"
#import "WXApi.h"//微信sdk头文件

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [NSThread sleepForTimeInterval:1];//设置启动页面时间

    
    // 注册微信
    [WXApi registerApp:WX_APPID];
    
    
    [self startAppShow];
    [self setShare];
    [[UserInfo sharedUserInfo] loadUserInofFromSanbox];
  

    return YES;
}
//显示启动页面
- (void)startAppShow{
    
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    
    
    NSString * appBuildVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    // NSString * appBuildVersion =
    NSString * savedVersion = [[NSUserDefaults standardUserDefaults]objectForKey:kShortVersionKey];
    // NSLog(@"获取到short version=%@  savedVersion=%@",appBuildVersion,savedVersion);
    
    if (savedVersion != nil && [savedVersion isEqualToString:appBuildVersion]){
        [self enterApp];//直接进入
    }else{
        [[NSUserDefaults standardUserDefaults]setValue:appBuildVersion forKey:kShortVersionKey];
        [[NSUserDefaults standardUserDefaults]synchronize];
        //启动launcher页面
        [self startWelcomeController];
        
    }
    
    [self.window makeKeyAndVisible];
}
//直接进入主界面
-(void)enterApp{
    MyTabBarViewController * main = [[MyTabBarViewController alloc]init];
    self.window.rootViewController = main;
}
//进入欢迎页
-(void)startWelcomeController{
    LeadViewController * welCome = [[LeadViewController alloc]init];
    self.window.rootViewController=welCome;
}
#pragma mark - sharesdk分享
-(void)setShare{
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:@"1dacac153fb00"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeWechat)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
//             case SSDKPlatformTypeQQ:
//                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;

             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)       
         {
                case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx7c2a3ea6dbc54b21"
                                       appSecret:@"7df16bd463840b91ec8b2ba1aa28a4e7"];
                 break;
//             case SSDKPlatformTypeQQ:
//                 [appInfo SSDKSetupQQByAppId:@"100371282"
//                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
//                                    authType:SSDKAuthTypeBoth];
//                 break;
                default:
                 break;
         }
     }];
}

#pragma mark - 微信支付相关处理
//前面的两个方法被iOS9弃用了，如果是Xcode7.2网上的话会出现无法进入进入微信的onResp回调方法，就是这个原因。本来我是不想写着两个旧方法的，但是一看官方的demo上写的这两个，我就也写了。。。。

//9.0前的方法，为了适配低版本 保留
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
//    return [WXApi handleOpenURL:url delegate:self];
//}
//
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
//    return [WXApi handleOpenURL:url delegate:self];
//}
//
////9.0后的方法
//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
//    //这里判断是否发起的请求为微信支付，如果是的话，用WXApi的方法调起微信客户端的支付页面（://pay 之前的那串字符串就是你的APPID，）
//    return  [WXApi handleOpenURL:url delegate:self];
//}
////微信SDK自带的方法，处理从微信客户端完成操作后返回程序之后的回调方法,显示支付结果的
//-(void) onResp:(BaseResp*)resp
//{
//    //启动微信支付的response
//    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
//    if([resp isKindOfClass:[PayResp class]]){
//        //支付返回结果，实际支付结果需要去微信服务器端查询
//        switch (resp.errCode) {
//            case 0:
//                payResoult = @"支付结果：成功！";
//                [HUD showAlertWithTitle:payResoult duration:1.0];
//                break;
//            case -1:
//                payResoult = @"支付结果：失败！";
//                [HUD showAlertWithTitle:payResoult duration:1.0];
//                break;
//            case -2:
//                payResoult = @"用户已经退出支付！";
//               [HUD showAlertWithTitle:payResoult duration:1.0];
//                break;
//            default:
//                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
//                break;
//        }
//    }
//}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
