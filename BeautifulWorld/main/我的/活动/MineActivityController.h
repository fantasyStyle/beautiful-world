//
//  MineActivityController.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/5/5.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineActivityController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic,strong)NSMutableArray * datailArr;
@property (nonatomic,strong)NSMutableArray * introArr;
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,copy)NSString * activityType;
@end
