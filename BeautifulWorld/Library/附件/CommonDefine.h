//
//  CommonDefine.h
//
//  Created by hushijun on 13-4-22.
//
//

#define MAS_SHORTHAND
/***************************************IOS中常用宏***************************************/
#pragma mark - =============IOS中常用宏=============

//1、屏幕宽度和高度
//2013年03月25日15:24:29  add by 胡仕君
#define kScreen_Height   [[UIScreen mainScreen] bounds].size.height
#define kScreen_Width    [[UIScreen mainScreen] bounds].size.width

//2、自定义导航bar，tabbar的高度
#define NavBar_Height 44
#define Tabbar_Height 50
#define StatusBar_Height 20
#define DistanceBlue_Height 10

//3、当前系统版本和当前语言
//2014年11月27日 判断是否是ios7+设备
#define iOS7 ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0)?YES:NO
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//4、检测是否是retina屏幕、是否是iphone5、是否是ipad
#define isRetinaScreen ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isIPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define isIPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//5、UserDefaults
#define UserDefaultClass [NSUserDefaults standardUserDefaults]
#define NotificationCenterClass [NSNotificationCenter defaultCenter]
#define ThemeManagerClass [ISTThemeManager defaultManager]
#define FileManagerClass [NSFileManager defaultManager]
#define MainBundleClass [NSBundle mainBundle]
#define StatusBarTipsWindowClass [StatusBarTipsWindow shareTipsWindow]
#define AppleNumHelperClass [AppleNumHelper sharedInstance]
#define DBHelperClass [DBHelper sharedInstance]
#define RequestHelperClass [RequestHelper sharedInstance]
#define RequestHelperNoAlerClass [RequestHelper sharedInstanceNoAlert]

//网络状态改变通知
#define NetWorkChangedNotify  @"netWorkChanged"
#define NetErrorInfo  @"无法连接到网络,请稍后再试"
//#define NetErrorInfo  @""
#define BaseVideoUrl @"http://47.92.156.104/Source/bnw/video/"//视频播放
#define BaseImaUrl @"http://47.92.156.104/Source/bnw/"//学堂
#define BaseShopUrl @"http://bnw.jinghuan.info/Source/bnw/shop/"//商城
#define BaseWorksUrl @"http://bnw.jinghuan.info/Source/bnw/draw/"//作品
#define  BaseActUrl @"http://bnw.jinghuan.info/Source/bnw/activity/"//活动
#define  BaseRouteSchoolUrl @"http://bnw.jinghuan.info/Source/bnw/teacher/"//学院
#define relateVideoUrl @"http://bnw.jinghuan.info/Source/bnw/video/"//推荐视频（官方）
#define teacherUrl @"http://bnw.jinghuan.info/Source/bnw/teacher/"//教师（碰撞名师）
#define teacherVideoUrl @"http://bnw.jinghuan.info/Source/bnw/teacher_video/"//教师视频
#define worldsell @"http://bnw.jinghuan.info/Source/bnw/"//世界的售卖


#define WX_APPID @"wx7c2a3ea6dbc54b21"

#define WebViewTimeoutInterval 15 //webview加载网络超时时间

/***************************************通用函数宏***************************************/
#pragma mark - =============通用函数宏=============

//1、安全释放内存
#define Safe_Release(x) {x=nil;}


//2、颜色函数
//背景色
#define Background_Color [UIColor colorWithRed:242.0/255.0f green:236.0/255.0f blue:231.0/255.0f alpha:1.0]
#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]


//3、图片函数：加载工程资源图片函数和根据图片名获取图片
//读取本地图片的 和imageNamed一样，但是性能比后者要强很多，两个参数，前面一个是 文件名，后面一个是类型
//例如 imageView.image =  LOADIMAGE(@"文件名",@"png");
//在资源不吃紧的情况下,这种反而是个累赘,因为没有缓存.
//imagenamed只是说要缓存,而且无法手动清空而已.缓存是好是坏,只能自己判定.
#define LoadImageByFile(fileName,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:fileName ofType:type]]
#define LoadImageByName(imgName) [UIImage imageNamed:imgName]
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]

//加载Bundle图片文件
#define LoadBundleImageByName(fileName) [UIImage imageForBundleByName:fileName]



//4、根据tag找视图：viewwithtag
#define ViewWithTag(_OBJECT, _TAG) [_OBJECT viewWithTag: _TAG]

//5、NSLocalizedString
//这样就不需要填默认的参数了. 对于需要反复使用的方法比较方便。
//比如说MyLocal(@"0094")  代替了NSLocalizedString(@"0094", nil)
#define MyLocal(x, ...) NSLocalizedString(x, nil)


//6、rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//7、degrees/radian functions
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

//8.数据缓存
#define ISSHOWRESERVE    @"isShowReserve"//存储是否显示预售
#define ADDIMG       @"addImage"//存储的上次的背景图
#define kUserDefaults [NSUserDefaults standardUserDefaults]

//9.强弱引用
#define FXWeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define FXStrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

#pragma mark - =============登录相关宏=============
//2014年09月15日 add by 胡仕君：将登陆界面的登录状态宏移到这里
#define LoginUIStatus @"LoginUIStatus"               //登陆状态
#define LoginAccount  @"LoginAccount"                //登陆账号
#define LoginPassword @"LoginPassword"               //登陆密码
#define RememberMePassword	  @"RememberMePassword"  //记住密码

#pragma mark - =============百度地图apikey=============
//百度地图apikey
//#define BaiduApiKey @"3B259CE8EC58C60003288B7C87B03BF555D254DA" //1.2.2版本的key
//#define BaiduApiKey @"EF7a77446bf7894515d3a6d9e8dce9ed"  //2.0.2版本的key：sunbox证书key
#define BaiduApiKey @"130c3e5805d1c13cb62b9ed21d7ca20b"    //2.0.2版本的key：石油证书key
#define BaiduWebAPIKey @"3SW08HhhdmemQ9fwUaw9dgN7"         //2014年07月25日 add by 胡仕君：百度服务器端WEB服务api ak


#pragma mark - =============消除警告等优化宏=============

//2013年08月28日 add by 胡仕君
//作用：定义一个下载地址宏，以后每次打包的时候都需要更新此宏，用于检测版本更新
//说明：1--表示从内部服务器下载的，2-表示从appstore下载的
//#define downloadAddress @"1"


//#if __LP64__ || (TARGET_OS_EMBEDDED && !TARGET_OS_IPHONE) || TARGET_OS_WIN32 || NS_BUILD_32_LIKE_64
//typedef long NSInteger;
//#else
//typedef int NSInteger;
//#endif

//2014年11月28日 add by 胡仕君：自定义nslog
#ifdef DEBUG  //debug模式打印nslog
//#define DLog(fmt, ...) NSLog((@"%s [Line %d] \n ------>>>" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define DLog(fmt, ...) NSLog((@"->>>" fmt), ##__VA_ARGS__);
#else         //非debug模式不打印nslog
#define DLog(...)
#endif


//rect、size、point 打印输出
#define NSLogRect(rect) NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define NSLogSize(size) NSLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define NSLogPoint(point) NSLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)

//A better version of NSLog
//#ifdef DEBUG  //debug模式打印nslog
//#define NSLog(format, ...) do {                                                 \
//fprintf(stderr, "<%s : %d> %s\n",                                           \
//[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
//__LINE__, __func__);                                                        \
//(NSLog)((format), ##__VA_ARGS__);                                           \
//fprintf(stderr, "-------\n");                                               \
//} while (0)
//#else         //非debug模式不打印nslog
//#define DLog(...)
//#endif


#define WeakSelf(x) __weak typeof(self) x = self;//IOS 5+
//__weak typeof(self) safeSelf = self;//IOS 5+
//__unsafe_unretained typeof(self) safeSelf = self;//IOS 4+
//音乐播放器
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define Frame_x_0  0.0f // 坐标 -> x
#define Frame_y_0  0.0f //
/* 数值变量 */
#define TableViewRowHeight self.view.frame.size.height /11 // tableView RowHight
/*
    当然，对于c/c++/java 编译器来说，这只是一个小问题，并不会导致无法编译。编译器实际上是倾向于前者的，它自动按第一种情况处理。
    但它会警告你这是一种不好的代码风格，你可以用#pragma clang diagnostic ignored "-Wswitch" 宏忽略该警告，
    或者将编译选项 MissingBraces and Parentheses 设置为 NO
    此宏的作用是忽略警告：“add explicit braces to avoid dangling else”
//#pragma clang diagnostic ignored "-Wswitch"
*/
//消除第3方库的警告
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
#define kCGImageAlphaPremultipliedLast (kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast)
#define kCGImageAlphaNone (kCGBitmapByteOrderDefault | kCGImageAlphaNone)
#else
#define kCGImageAlphaPremultipliedLast kCGImageAlphaPremultipliedLast
#define kCGImageAlphaNone kCGImageAlphaNone
#endif


//消除-Wformat警告，在有警告的地方调用此宏定义
#define SuppressWFormatWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wformat\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

//消除arc中PerformSelector警告的方法，在有警告的地方调用此宏定义
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)



//#define CALLOUT_MENU_IN_READERVIEW   @"CalloutMenuBar"
//#define CALLOUT_CUSTOM_TABBAR        @"CalloutCustomTabbar"
//#define HIDE_CUSTOM_TABBAR           @"HideCustomTabbar"
//#define Resign_NoteTextView_Editing  @"ResignNoteTextViewEditing"
#define SHOW_BADGEVALUE              @"SHOW_BADGEVALUE"
#define SHOW_BADGEVALUEOnHomeView    @"SHOW_BADGEVALUEOnHomeView"

//支付宝
#define AliPartenerID   @"2088611229299643"
#define AliSellerID     @"lld@focus-x.com"
#define AliPrivate      @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAM8LJHIToLo2zMmSK73XXQnL+35AKce91Gkepwmf3pg4SHPUeSDTXu/fN64sXefVUuQ99apScCXwHt/tlITDeYCJEs6b4DYkHFE2odndWf0vI42NIPdW/d2WpGm4j/OvEhDxWsJ39iGZ8OguH38dbjhXyYu+Pyb1WMbI8GCC+qWTAgMBAAECgYAkxD/GmkGyj8SyDukBn1sAQF76vn4s4EL2H+FdziwDMAt9tj+EWsTDKAqFPY+3eaRsr6wOgPE1a3ywG0qCgQv0O45+yf81mMPm4cngN6ZAEUrZBtLuu58wYBXJowmYlUQcrjN/mJyeAQ5Qsa+JjyLihncl/a/zMf8wd2JZRH0FsQJBAO+BfUx77HPI5lFjQoh2QhoqJf8n4meaQAFvHlC+ff2LjFjzNUZDx2vqzw93bt76Qw8/I5XQvP5oL6dzJ69iRZ0CQQDdTVbuNZ6Nq3T6FLV6UWnhIR+4S8GCueMycECb4TfGc4OIV8MgzGIP1khH9itJC7NDUARckLWt240WbcQMbcjvAkEAviQCEn9rh7xdxQ1VW7ru3ZDKm5fRcUiPOdQ6sAWbRnfMEy36BG942Z8PhYre1Vy/clJA8QZHlH2oH3sXbXBKLQJAIM0/31sPP0x0sES1iYXbvcTdIMIJ0siexnEhAnnlfILOsjzf7VKeDl7io9f3HoKfdZC8tMO2SijKxtJKRtVW/QJAGE0s4xheBGN8z6E2PQ9z/8ZyB4tQBCV38rAUX0lLMW9zeM+tswWqULu7oHRxMjN+WuSV+U3pPWekWdK9BELeYg=="

#define AliNOTIFY_URL @"wwww.baidu.com"

/**
 *  判断一个对象是否为空
 *
 *  @param thing 对象
 *
 *  @return 返回结果
 */
static inline BOOL ICIsObjectEmpty(id thing){
    return thing == nil ||
    ([thing isEqual:[NSNull null]]) ||
    ([thing respondsToSelector:@selector(length)] && [(NSData *)thing length] == 0) ||
    ([thing respondsToSelector:@selector(count)]  && [(NSArray *)thing count] == 0);
}

/**
 *  判断一个字符串是否为空
 *
 *  @param string 字符串
 *
 *  @return 返回结果
 */
static inline BOOL ICIsStringEmpty(NSString *string){
    
    if (string == nil || string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    
    if ([string isEqualToString:@"null"]) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    
    return NO;
}
/**
 *  空字符串处理
 *
 *  @param string 字符串
 *
 *  @return 返回合适的字符串
 */
static inline NSString* ICUnEmptyString(NSString *string){
    
    if (string == nil || string == NULL) {
        return @" ";
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return @" ";
    }
    
    if ([string isEqualToString:@"<null>"]) {
        return @" ";
    }
    
    if ([string isEqualToString:@"(null)"]) {
        return @" ";
    }
    
    if ([string isEqualToString:@"null"]) {
        return @" ";
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return @" ";
    }
    
    return string;
}
/**
 *  生成字符串
 *
 *  @param ... 格式化参数
 *
 *  @return 得到的字符串
 */
#define str(...) [NSString stringWithFormat:__VA_ARGS__]


//#endif
