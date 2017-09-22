//
//  ActivityDetailController.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/13.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityDetailController : UIViewController
@property(nonatomic,strong)UIView * bottomBar;
@property (nonatomic,copy)NSString * activityUrl;
@property (nonatomic,copy)NSString * introUrl;
@property (nonatomic,copy)NSString * activityID;
-(void)createBottomBar;
@end
