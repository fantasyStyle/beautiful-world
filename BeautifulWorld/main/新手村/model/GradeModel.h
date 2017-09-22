//
//  GradeModel.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/2/22.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GradeModel : NSObject
@property (nonatomic,copy)NSString * grade;//等级
@property (nonatomic,copy)NSString * learnPlan;//学习任务
@property (nonatomic,copy)NSString * haveNoFinish;//学习任务
@property (nonatomic,copy)NSString * rank;//学习排名

@end
