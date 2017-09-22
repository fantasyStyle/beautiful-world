//
//  FamousTeacherModel.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/14.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FamousTeacherModel : NSObject
@property (nonatomic,copy)NSString * imaName;
@property (nonatomic,copy)NSString * name;

@property (nonatomic,copy)NSString * sex;

@property (nonatomic,copy)NSString * age;

@property (nonatomic,copy)NSString * school;
@property (nonatomic,copy)NSString * studentCount;
@property (nonatomic,strong)NSMutableArray  * styleArr ;
@property (nonatomic,copy)NSString * YNAppretticed;
@property (nonatomic,copy)NSString * teacher_id;






@end
