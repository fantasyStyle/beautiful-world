//
//  ClassLectureTableCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/1.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
@class ClassLectureModel;
@protocol TapClassClickDelegate <NSObject>

-(void)TapClassCellDelegate:(ClassLectureModel *)classData AndINtag:(NSInteger)tag;

@end

@interface ClassLectureTableCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * myTabelView;
@property(nonatomic,strong)NSMutableArray * classModelArray;
@property(nonatomic,assign)int  tags; //所在section
@property(nonatomic,assign)id classDelegate;
@end
