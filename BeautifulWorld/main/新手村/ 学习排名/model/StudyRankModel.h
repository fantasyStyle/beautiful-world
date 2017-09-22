//
//  StudyRankModel.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/6.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudyRankModel : NSObject
@property (nonatomic,copy)NSString * sex;
@property (nonatomic,copy)NSString * personIcon;
@property (nonatomic,copy)NSString * personName;
@property (nonatomic,copy)NSString * grade;
@property (nonatomic,strong)NSMutableArray * styleArr;
@end
