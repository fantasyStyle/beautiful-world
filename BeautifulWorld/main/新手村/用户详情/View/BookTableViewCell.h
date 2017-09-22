//
//  BookTableViewCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/7.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookUserModel.h"
@interface BookTableViewCell : UITableViewCell
{
    UIImageView * imaShow;
    UILabel * bookNameLab;
    UILabel * timeLab;
    UIButton * inspectBtn;
}
@property (nonatomic,strong)BookUserModel * userBook;
@end
