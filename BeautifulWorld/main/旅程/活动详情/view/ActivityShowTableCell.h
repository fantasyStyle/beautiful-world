//
//  ActivityShowTableCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/14.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityDetailModel.h"
@interface ActivityShowTableCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *iconIma;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UIButton *focusBtn;
@property (strong, nonatomic) IBOutlet UILabel *themeLab;
@property (strong, nonatomic) IBOutlet UILabel *contentLab1;
@property (strong, nonatomic) IBOutlet UIImageView *imaShow;
@property (strong, nonatomic) IBOutlet UILabel *contentLab2;
@property (strong, nonatomic) IBOutlet UIButton *joinBtn;
@property (strong, nonatomic) IBOutlet UILabel *joinNumLab;
@property (nonatomic,strong)ActivityDetailModel * actDetail;
@end
