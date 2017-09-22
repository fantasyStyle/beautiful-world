//
//  NSString+Category.h
//  iOSCodeProject
//
//  Created by zym on 14-7-18.
//  Copyright (c) 2014年 翔傲信息科技（上海）有限公司. All rights reserved.
//

#import "TTIFormatValidate.h"
#import "NSString+Category.h"

/**
 *  常用正则表达式：
 
 1、非负整数：^\d+$
 
 2、正整数：^[0-9]*[1-9][0-9]*$
 
 3、非正整数：^((-\d+)|(0+))$
 
 4、负整数：^-[0-9]*[1-9][0-9]*$
 
 5、整数：^-?\d+$
 
 6、非负浮点数：^\d+(\.\d+)?$
 
 7、正浮点数：^((0-9)+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$
 
 8、非正浮点数：^((-\d+\.\d+)?)|(0+(\.0+)?))$
 
 9、负浮点数：^(-((正浮点数正则式)))$
 
 10、英文字符串：^[A-Za-z]+$
 
 11、英文大写串：^[A-Z]+$
 
 12、英文小写串：^[a-z]+$
 
 13、英文字符数字串：^[A-Za-z0-9]+$
 
 14、英数字加下划线串：^\w+$
 
 15、E-mail地址：^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$
 
 16、URL：^[a-zA-Z]+://(\w+(-\w+)*)(\.(\w+(-\w+)*))*(\?\s*)?$
 或：^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>""])*$
 
 17、邮政编码：^[1-9]\d{5}$
 
 18、中文：^[\u0391-\uFFE5]+$
 
 19、电话号码：^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$
 
 20、手机号码：^((\(\d{2,3}\))|(\d{3}\-))?13\d{9}$
 
 21、双字节字符(包括汉字在内)：^\x00-\xff
 
 22、匹配首尾空格：(^\s*)|(\s*$)（像vbscript那样的trim函数）
 
 23、匹配HTML标记：<(.*)>.*<\/\1>|<(.*) \/>
 
 24、匹配空行：\n[\s| ]*\r
 
 25、提取信息中的网络链接：(h|H)(r|R)(e|E)(f|F)  *=  *('|")?(\w|\\|\/|\.)+('|"|  *|>)?
 
 26、提取信息中的邮件地址：\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*
 
 27、提取信息中的图片链接：(s|S)(r|R)(c|C)  *=  *('|")?(\w|\\|\/|\.)+('|"|  *|>)?
 
 28、提取信息中的IP地址：(\d+)\.(\d+)\.(\d+)\.(\d+)
 
 29、提取信息中的中国手机号码：(86)*0*13\d{9}
 
 30、提取信息中的中国固定电话号码：(\(\d{3,4}\)|\d{3,4}-|\s)?\d{8}
 
 31、提取信息中的中国电话号码（包括移动和固定电话）：(\(\d{3,4}\)|\d{3,4}-|\s)?\d{7,14}
 
 32、提取信息中的中国邮政编码：[1-9]{1}(\d+){5}
 
 33、提取信息中的浮点数（即小数）：(-?\d*)\.?\d+
 
 34、提取信息中的任何数字 ：(-?\d*)(\.\d+)?
 
 35、IP：(\d+)\.(\d+)\.(\d+)\.(\d+)
 
 36、电话区号：/^0\d{2,3}$/
 
 37、腾讯QQ号：^[1-9]*[1-9][0-9]*$
 
 38、帐号(字母开头，允许5-16字节，允许字母数字下划线)：^[a-zA-Z][a-zA-Z0-9_]{4,15}$
 
 39、中文、英文、数字及下划线：^[\u4e00-\u9fa5_a-zA-Z0-9]+$
 
 40、匹配首尾空白字符的正则表达式：^\s*|\s*$
 评注：可以用来删除行首行尾的空白字符(包括空格、制表符、换页符等等)，非常有用的表达式
 
 41、匹配网址URL的正则表达式：(https?|ftp|file)://[-A-Z0-9+&@#/%?=~_|!:,.;]*[-A-Z0-9+&@#/%=~_|]
 
 
 */




@implementation TTIFormatValidate

+ (BOOL)isValidateMobilePhone:(NSString *)mobilePhone{
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188，183
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,183
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobilePhone] == YES)
        || ([regextestcm evaluateWithObject:mobilePhone] == YES)
        || ([regextestct evaluateWithObject:mobilePhone] == YES)
        || ([regextestcu evaluateWithObject:mobilePhone] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)isValidateMobilePhoneTextFiled:(UITextField *)textFiled{
    
//    if (textFiled.text.length == 0 || [[textFiled.text stringByDeleteWhitespaceAndWrap] length] == 0) {
//        return NO;
//    }
//    
//    
    
    NSString *regex = @"^\\d{11}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [test evaluateWithObject:textFiled.text];
    
//    return [TTIFormatValidate isValidateMobilePhone:[textFiled.text stringByDeleteWhitespaceAndWrap]];
}

+ (BOOL)isValidateEmail:(NSString *)email{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)isValidateEmailTextFiled:(UITextField *)textFiled{
    
    if (textFiled.text.length == 0 || [[textFiled.text stringByDeleteWhitespaceAndWrap] length] == 0) {
        return NO;
    }
    
    return [TTIFormatValidate isValidateEmail:[textFiled.text stringByDeleteWhitespaceAndWrap]];
    
}

+ (BOOL)isValidateNumber:(NSString *)number{
    
    NSString *regex = @"[0-9]*";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [numberTest evaluateWithObject:number];
}

+ (BOOL)isValidateStrictNumber:(NSString *)number{
    
    //严格判断
    NSString *regex = @"^((\\(\\d{2,3}\\))|(\\d{4}\\-))?1[3,4,5,8]\\d{9}$";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [numberTest evaluateWithObject:number];
    
}

+ (BOOL)isValidateTelephone:(NSString *)telephone{
    
    //判断电话
    NSString *regex = @"^[\\d+-]*$";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [numberTest evaluateWithObject:telephone];
    
}

+ (BOOL)isTextFiledValidate:(UITextField *)textFiled{
    
    return [TTIFormatValidate isTextFiledValidate:textFiled minLenght:0 maxLenght:16];
    
}

+ (BOOL)isTextFiledValidate:(UITextField *)textFiled minLenght:(int)min maxLenght:(int)max{
    
    if (textFiled.text.length == 0 || [[textFiled.text stringByDeleteWhitespaceAndWrap] length] == 0) {
        return NO;
    }
    
    if ([[textFiled.text stringByDeleteWhitespaceAndWrap] length] > max || [[textFiled.text stringByDeleteWhitespaceAndWrap] length] < min) {
        return NO;
    }
    
    return YES;
    
}

+ (BOOL)isTextViewValidate:(UITextView *)textView minLenght:(int)min maxLenght:(int)max{
    
    if (textView.text.length == 0 || [[textView.text stringByDeleteWhitespaceAndWrap] length] == 0) {
        return NO;
    }
    
    if ([[textView.text stringByDeleteWhitespaceAndWrap] length] > max || [[textView.text stringByDeleteWhitespaceAndWrap] length] < min) {
        return NO;
    }
    
    return YES;
    
}

+ (BOOL)validateIDCardNumber:(NSString *)value {
    
    if (value.length != 18) {
        return  NO;
    }
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[value substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[value substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[value substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
   // return  NO;
    
    //==============================================================================================
    //去除空格
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int length = 0;
    if (!value) {
        return NO;
    }else {
        length = (int)value.length;
        
        if (length != 15 && length !=18) {
            return NO;
        }
    }
    
    // 省份代码
    NSArray *areasArray =@[@"11", @"12", @"13", @"14", @"15", @"21", @"22",
                           @"23", @"31", @"32", @"33", @"34", @"35", @"36",
                           @"37", @"41", @"42", @"43", @"44", @"45", @"46",
                           @"50", @"51", @"52", @"53", @"54", @"61", @"62",
                           @"63", @"64", @"65", @"71", @"81", @"82", @"91"];
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year = 0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];// 测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                              options:NSMatchingReportProgress
                                                                range:NSMakeRange(0, value.length)];
            
            if(numberofMatch > 0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];// 测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                              options:NSMatchingReportProgress
                                                                range:NSMakeRange(0, value.length)];
            
            if(numberofMatch > 0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S % 11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)]; // 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return false;
    }
}


//昵称
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{8,12}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}


+ (BOOL) validatefloatString:(NSString *)floatString{
    
    NSScanner* scan = [NSScanner scannerWithString:floatString];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}
//判断NSString字符串是否包含emoji表情
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue =NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800) {
            if (0xd800 <= hs && hs <= 0xdbff) {
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                    if (0x1d000 <= uc && uc <= 0x1f77f) {
                        returnValue =YES;
                    }
                }
            }else if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    returnValue =YES;
                }
            }else {
                // non surrogate
                if (0x2100 <= hs && hs <= 0x27ff) {
                    returnValue =YES;
                }else if (0x2B05 <= hs && hs <= 0x2b07) {
                    returnValue =YES;
                }else if (0x2934 <= hs && hs <= 0x2935) {
                    returnValue =YES;
                }else if (0x3297 <= hs && hs <= 0x3299) {
                    returnValue =YES;
                }else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                    returnValue =YES;
                }
            }
        }
    }];
    return returnValue;
}


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



@end
