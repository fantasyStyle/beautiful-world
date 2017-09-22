//
//  RecommendUsersCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/15.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendUsersModel.h"
@interface RecommendUsersCell : UITableViewCell
{
    UIImageView * icon;
    UILabel * nameLab;
    UILabel * recommendLab;
    UIImageView * imaShow1;
    UIImageView * imaShow2;
    UIImageView * imaShow3;
    UIButton * focusBtn;
}
@property (nonatomic,strong)RecommendUsersModel * usersModel;
@end
