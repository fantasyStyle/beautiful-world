//
//  BuyRecordController.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/17.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopPayView.h"
@interface BuyRecordController : UIViewController
@property (nonatomic,copy)NSString * shop_URL;
@property (nonatomic,copy)NSString * type_ID;
@property (nonatomic,copy)NSString * user_id;
@property (nonatomic,copy)NSString * timeIsHide;
@property (nonatomic,copy)NSString * clickType;//点击类型

@end
