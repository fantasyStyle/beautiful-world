//
//  TradeMemberCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/14.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TradeMemberModel.h"
@interface TradeMemberCell : UITableViewCell
{
    UIImageView * iconIma;
    UIImageView * sexIma;
    UILabel * nameLab;
    UIImageView * styleIma;
    UIButton * focusBtn;
    UILabel * createrLab;
}
@property (nonatomic,assign)BOOL creater;
@property (nonatomic,assign)NSInteger cellTag;
@property (nonatomic,strong)TradeMemberModel * memberModel;
@end
