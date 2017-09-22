//
//  PurchaseViewController.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/5/4.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurchaseViewController : UIViewController
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArr;
-(void)loadData;
-(void)createUI;
@end
