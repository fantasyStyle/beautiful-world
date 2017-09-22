//
//  locationModel.m
//  gowuche
//
//  Created by 上海点硕 on 16/4/20.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//

#import "locationModel.h"

@implementation locationModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {
        self.name=dict[@"name"];
        self.tell=dict[@"tell"];
        self.dizhi= dict[@"dizhi"];
    }
    return self;
}
+(instancetype) appWithDict:(NSDictionary *)dict{
    
    // 为何使用self，谁调用self方法 self就会指向谁！！
    return [[self alloc] initWithDict:dict];
    
}
@end
