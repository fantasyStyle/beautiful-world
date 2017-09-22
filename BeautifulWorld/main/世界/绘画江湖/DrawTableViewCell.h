//
//  DrawTableViewCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/5/2.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReUserModel;
@protocol tapDrawClickDelegate <NSObject>

-(void)tapDraw:(ReUserModel * )route andIntag:(NSInteger)tag;

@end
@interface DrawTableViewCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * myTabelView;
@property(nonatomic,strong)NSMutableArray * classModelArray;
@property(nonatomic,assign)id drawDelegate;

@end
