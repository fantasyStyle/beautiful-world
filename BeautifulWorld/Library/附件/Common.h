//
//  Common.h
//  RepairMan
//
//  Created by Pishum on 16/8/3.
//  Copyright © 2016年 Leleda. All rights reserved.
//


#ifndef Common_h
#define Common_h





//LOG自定义
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s: %d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
//#define NSLog(FORMAT, ...) nil
#endif

//通知中心
#define IMReloadFriendlistNotification @"IMReloadFriendlistNotification"
#define IMReloadBlacklistNotification @"IMReloadBlacklistNotification"
#define IMRelationshipDidInitializeNotification @"IMRelationshipDidInitializeNotification"
//统一的颜色风格
#define kCOLOR_LLD [UIColor colorWithRed:252.0/255.0 green:94.0/255.0  blue:15.0/255.0  alpha:1.00]
#define kCOLOR_GRAY [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00]


//屏幕的尺寸
#define kScreenSize [[UIScreen mainScreen] bounds]

//显示版本号的key
#define kShortVersionKey @"CFBundleShortVersionString"

//首页的高度
#define KTableHeight [UIScreen mainScreen].bounds.size.height/3*2
//首页的宽度
#define KTableWidth [UIScreen mainScreen].bounds.size.width-20
//间隙的蓝色
#define  DistanceBlueColor UIColorFromRGB(0xD0FEFF)
//暗影村字体颜色
#define BlueTitileColor RGBColor(0, 0, 76)

#define lineRed RGBColor(139, 43, 9)
#define  lineBlue RGBColor(16, 20, 103)
#define lineYellow RGBColor(191, 141, 12)
//光明村
#define lightTextColor RGBColor(89, 185, 241)
#define Margin 5
//导航栏颜色
#define NavBar_Color  RGBAColor(0, 228, 255, 1)
//通用cell高度
#define kHeight kScreen_Height/3
//竖线的款
#define VerticalLineWidth 3
//评论框的button的Tag值
#define CommentBtnTag 11111

//字体大小
#define  font12 [UIFont systemFontOfSize:12]
#define  font13 [UIFont systemFontOfSize:13]
#define  font14 [UIFont systemFontOfSize:14]
#define  font15 [UIFont systemFontOfSize:15]


#endif /* Common_h */
