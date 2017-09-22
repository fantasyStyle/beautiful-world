//
//  locationModel.h
//  gowuche
//
//  Created by 上海点硕 on 16/4/20.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface locationModel : NSObject
@property (weak, nonatomic) NSString *name;
@property (weak, nonatomic) NSString *tell;
@property (weak, nonatomic) NSString *dizhi;
-(instancetype)initWithDict:(NSDictionary *)dict;
@end
