//
//  AllianceTableViewCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/13.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllianceModel.h"
@interface AllianceTableViewCell : UITableViewCell
{
    UIImageView * ima;
    UILabel * titleLab;
    UILabel * timeLab;
    UIImageView * styleIma;
    UILabel * visitCountLab;
    UIImageView * starIma;
    UILabel * hotLab;
}
@property (nonatomic,strong)UILabel * joinLab;
@property (nonatomic,strong)AllianceModel * myAlliance;
@end
