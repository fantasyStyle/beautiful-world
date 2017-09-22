//
//  TradeDetailCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/14.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TradeDetailModel.h"
@interface TradeDetailCell : UITableViewCell
{
    UIImageView * headIcon;
    UILabel * nameLab;
    UILabel * introduceLab;
    UILabel * demandLab;
    UILabel * timeLab;
}
@property (nonatomic,strong)TradeDetailModel * tradeDetail;
@property (nonatomic,strong)UILabel * detailLab;
@end
