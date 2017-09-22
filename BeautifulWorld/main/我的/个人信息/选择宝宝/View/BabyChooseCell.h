//
//  BabyChooseCell.h
//  demo
//
//  Created by yuanju001 on 16/10/29.
//  Copyright © 2016年 yuanju001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BabyModel.h"
@interface BabyChooseCell : UITableViewCell
{
    UIImageView * headIcon;
    
    UILabel * nameLab;
    
    UILabel * classLab;
}
@property (strong, nonatomic)BabyModel * choosedBabyModel;
@end
