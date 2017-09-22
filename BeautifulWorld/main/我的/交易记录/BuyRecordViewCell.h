//
//  BuyRecordViewCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/17.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordModel.h"
@interface BuyRecordViewCell : UITableViewCell
{
    UIImageView * imaShow;
    UILabel * titleLab;
    UILabel * timeLab;
    UILabel * priceLab;
    UIImageView * imaType;
}
@property (nonatomic,strong)RecordModel * record;
@end
