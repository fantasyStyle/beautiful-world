//
//  CustRouteTableViewCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/26.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
@class RouteModel;
@protocol tapRouteClickDelegate <NSObject>

-(void)tapRoute:(RouteModel * )route andIntag:(NSInteger)tag;

@end
@interface CustRouteTableViewCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * myTabelView;
@property(nonatomic,strong)NSMutableArray * classModelArray;
@property(nonatomic,assign)id routeDelegate;
@end
