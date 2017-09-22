//
//  TradeMemberModel.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/14.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TradeMemberModel : NSObject
@property (nonatomic,copy)NSString * memberIcon;
@property (nonatomic,copy)NSString * sex;
@property (nonatomic,copy)NSString * name;
@property (nonatomic,strong)NSMutableArray * styleArr;
@property (nonatomic,copy)NSString * YNFocus;

@end
