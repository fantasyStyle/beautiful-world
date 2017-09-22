//
//  UserInfo.m
//  个人信息界面
//
//  Created by 李校松 on 16/9/21.
//  Copyright © 2016年 李校松. All rights reserved.
//

#import "UserInfo.h"

#define nicKEY @"nickname"
#define sexKEY @"sex"
#define headKEY @"image"
#define signKEY @"sign"
#define cityKEY @"city"
#define userRankey @"rank"
#define PhoneKEY @"phone"
#define babyKEY @"baby"
#define countryKEY @"countryStyle"
#define constellationKEY @"constellation"
#define authKEY @"auth"
#define loginKEY @"isLoginKEY"
#define  teacherKEY @"isTeacher"
#define userIDKEY @"user_id"
#define vipKEY @"vipType"
#define goldKEY @"gold"

#define jewelKEY @"jewel"

@implementation UserInfo

singleton_implementation(UserInfo)


- (void)saveUserInofFromSanbox{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:self.nickName forKey:nicKEY];
    [defaults setValue:self.sign forKey:signKEY];
    [defaults setValue:self.sex forKey:sexKEY];
    [defaults setValue:self.iconUser forKey:headKEY];
    [defaults setValue:self.addressName forKey:cityKEY];
    [defaults setValue:self.phoneNum forKey:PhoneKEY];
    [defaults setValue:self.babyName forKey:babyKEY];
    [defaults setValue:self.constellation forKey:constellationKEY];
    [defaults setValue:self.countrySideStyle forKey:countryKEY];
    [defaults setValue:self.auth forKey:authKEY];
    [defaults setValue:self.isTeacher forKey:teacherKEY];
    [defaults setValue:self.userRank forKey:userRankey];
    [defaults setValue:self.userGold forKey:goldKEY];
    [defaults setValue:self.userJewel forKey:jewelKEY];
    [defaults setValue:self.isLogin forKey:loginKEY];
    [defaults setValue:self.user_id forKey:userIDKEY];
    [defaults setValue:self.vipType forKey:vipKEY];
    [defaults synchronize];
}

- (void)loadUserInofFromSanbox{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.nickName = [defaults objectForKey:nicKEY];
    self.sign = [defaults objectForKey:signKEY];
    self.sex = [defaults objectForKey:sexKEY];
    self.iconUser = [defaults objectForKey:headKEY];
    self.addressName = [defaults objectForKey:cityKEY];
    self.phoneNum = [defaults objectForKey:PhoneKEY];
    self.babyName = [defaults objectForKey:babyKEY];
    self.countrySideStyle = [defaults objectForKey:countryKEY];
    self.constellation = [defaults objectForKey:constellationKEY];
    self.auth = [defaults objectForKey:authKEY];
    self.isLogin = [defaults objectForKey:loginKEY];
    self.isTeacher = [defaults objectForKey:teacherKEY];
    self.user_id = [defaults objectForKey:userIDKEY];
    self.vipType = [defaults objectForKey:vipKEY];
    self.userRank = [defaults objectForKey:userRankey];
    self.userGold = [defaults objectForKey:goldKEY];
    self.userJewel = [defaults objectForKey:jewelKEY];
}

@end
