//
//  ToolsHeader.h
//  SerialNumberQuery
//
//  Created by hushijun on 15/7/28.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#ifndef SerialNumberQuery_ToolsHeader_h
#define SerialNumberQuery_ToolsHeader_h


#endif


#ifdef __OBJC__

/*
 * 说明：
 *  1、将tools文件夹导入项目
 *  2、将ToolsHeader.h导入pch文件中
 *  3、导入相关类库的框架：
 *  4、对非arc头文件设置属性：-fno-objc-arc
 **/


//极光推送
#define jPAPPKEY @"ed8982f929272068b38685c5"



#define UMENG_APPKEY @"55efed2de0f55a5bc90005b9" //友盟乐乐达appkey
#import "NSMutableDictionary+Utils.h"
/*************************IOS类库中扩展帮助类**************************/
//#import "UtilsHeader.h"

/*************************常用操作帮助类**************************/
//#import "CPToast.h"                     //提示信息帮助类
//#import "DBHelper.h"                    //数据库操作相关帮助类
//#import "ALBattery.h"                   //ios设备硬件数据帮助类:电池帮助类中又导入了硬件帮助类（ALHardware.h）
//#import "RequestHelper.h"               //自定义网络状态请求帮助类：移到RequestHelper.h中，统一管理网络请求操作
#import "UserInfo.h"
#import "CommonDefine.h"                //常用宏定义帮助类
//#import "TotalBaseViewController.h"     //所有vc的基类
#import "BaseViewController.h"
//#import "BaseWebViewController.h"       //所有webviewvc的基类
//#import "VersionUpdateHelper.h"         //版本更新vc
//
//#import "ASDepthModalViewController.h"  //弹窗视图帮助类
//#import "WebViewJavascriptBridge.h"     //js网页交互帮助类
//
//#import <ShareSDK/ShareSDK.h>          //分享sdk
//#import "CMachineKeyStore.h"           //设备uuid帮助类
//#import "MobClick.h"                   //友盟统计数据sdk
//#import "MobClickSocialAnalytics.h"
//
//#import "Product.h" 
//#import "Pay.h"
//#import "HUD.h"
//#import "HttpClient.h"
///**
// *  支付宝支付sdk
// */
//#import <AlipaySDK/AlipaySDK.h>
//
//
/**
 *  微信支付sdk
 */
//APP端签名相关头文件
#import "WXApi.h"
#import "WXApiObject.h"
//#import "payRequsestHandler.h"
#import "Common.h"
//#import "Masonry.h"
////#import "BaseViewController.h"
//刷新空间
#import "MJRefresh.h"
#import "FTUtilsMethod.h"
#import "FTRefreshGifHeader.h"
#import "FTRefreshGifFooter.h"

//#import "PlayerController.h"//播放器
#import "SDWebImageCompat.h"
#import "UIImageView+WebCache.h"
//加载中
#import "FTShowMessageView.h"
//页面坐标
#import "UIView+Utils.h"
#import "UIView+Frame.h"
#import "UIView+UIViewTap_Extension.h"//页面点击事件

#import "NSDate+Utils.h"//时间转换
#import "LoadFailView.h"//加载失败
//#import "Definition.h"
//#import "UIView+YYAdd.h"
//#import <UIKit/UIKit.h>
//#import <Foundation/Foundation.h>
//#import "EMAlertView.h"
//#import "TTGlobalUICommon.h"
//#import "EMSDKFull.h"
//#import "EaseUI.h"
//#import "ChatUIDefine.h"
//#import "ChatUIHelper.h"
//#import "AppUtils.h"
#import "HUD.h"
#import "HttpClient.h"

#import "LoadFailView.h"//加载失败

////个人信息
//#import "UIViewController+DismissKeyboard.h"
//#import "UserInfo.h"
#endif
