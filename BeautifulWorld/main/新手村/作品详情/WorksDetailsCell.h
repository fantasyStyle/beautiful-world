//
//  WorksDetailsCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/5/2.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorksDetailsModel.h"
@interface WorksDetailsCell : UITableViewCell
{
    UIImageView * headIcon;
    UILabel * nameLab;
    UILabel * timeLab;
    UILabel * interoduceLab;
    UIImageView * videoIma;
    UIButton * zanBtn;
    UIButton * collectBtn;

    

    
}
@property (nonatomic,strong)WorksDetailsModel * works;
@end
