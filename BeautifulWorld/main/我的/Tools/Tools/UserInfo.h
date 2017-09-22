//
//  UserInfo.h
//  个人信息界面
//
//  Created by 李校松 on 16/9/21.
//  Copyright © 2016年 李校松. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Singleton.h"

@interface UserInfo : NSObject

singleton_interface(UserInfo)

@property (nonatomic ,copy) NSString *nickName;
@property (nonatomic ,copy) NSString *sex;
@property (nonatomic ,copy) NSString *sign;
@property (nonatomic ,copy) NSString *iconUser;
@property (nonatomic ,copy) NSString *addressName;
@property (nonatomic ,copy) NSString *phoneNum;
@property (nonatomic ,copy) NSString *babyName;
@property (nonatomic ,copy) NSString *constellation;
@property (nonatomic,copy)NSString *  countrySideStyle;
@property (nonatomic,copy)NSString * auth;//请求头
@property (nonatomic,copy)NSString * user_id;
@property (nonatomic,copy)NSString * isLogin;
@property (nonatomic,copy)NSString * isTeacher;
@property (nonatomic,copy)NSString * vipType;
@property (nonatomic,copy)NSString * userRank;
@property (nonatomic,copy)NSString * userGold;
@property (nonatomic,copy)NSString * userJewel;


- (void)saveUserInofFromSanbox;

- (void)loadUserInofFromSanbox;
@end
