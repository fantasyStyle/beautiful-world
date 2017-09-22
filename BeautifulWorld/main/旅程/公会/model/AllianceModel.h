//
//  AllianceModel.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/13.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllianceModel : NSObject
@property (nonatomic,copy)NSString * tradeIma;//图片名
@property (nonatomic,copy)NSString * tradeTitle;//标题
@property (nonatomic,copy)NSString * tradeTime;//时间
@property (nonatomic,copy)NSString * visitCount;//查看量
@property (nonatomic,strong)NSMutableArray * styleArr;//风格
@property (nonatomic,assign)int hotRate;//活跃度

@end
