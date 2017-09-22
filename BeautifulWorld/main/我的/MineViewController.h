//
//  MineViewController.h
//  NewWorld
//
//  Created by fantasy  on 2017/2/7.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineViewController : UIViewController
@property(nonatomic,strong)NSMutableArray * dataArray; //文字数组
@property(nonatomic,strong)UITableView * myTable;
@property(nonatomic,strong)UIView * headView;
@property(nonatomic,strong)UIImageView * picShow;//顶部图片
@property(nonatomic,strong)UIImageView * userIcon; //头像
@property(nonatomic,strong)UILabel * nameLab;//昵称
@property(nonatomic,strong)UILabel * signLab;//个性签名

//-(void)iconClick:(UIButton *)sender;
-(void)creatData;
@end
