//
//  commentModel.h
//  demo
//
//  Created by yuanju002 on 16/9/23.
//  Copyright © 2016年 yuanju001. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface commentModel : NSObject
@property(nonatomic,copy)NSString * icon;//头像
@property(nonatomic,copy)NSString * title;//标题／名字
@property(nonatomic,copy)NSString * date;//时间
@property(nonatomic,copy)NSString * detail;//内容
@property(nonatomic,copy)NSString * number;//点赞数

@end
