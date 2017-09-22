//
//  RouteSchoolTableViewCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/26.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RouteModel.h"
@interface RouteSchoolTableViewCell : UITableViewCell
{
    UIImageView * routeIma;
}
@property (nonatomic,strong)RouteModel * routeModel;
@end
