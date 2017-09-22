//
//  ResourcesBuyTableViewCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/5/5.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResourcesBuyModel.h"
@interface ResourcesBuyTableViewCell : UITableViewCell
{
//    UIImageView * payIcon;
    UILabel * titleLab;
    UILabel * iconCount;
    
}
@property (nonatomic,strong)UIImageView * payIcon;;
@property (nonatomic,strong)UIButton * payBtn;
@property (nonatomic,strong)ResourcesBuyModel * buyModel;
@end
