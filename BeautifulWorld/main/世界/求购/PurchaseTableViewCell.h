//
//  PurchaseTableViewCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/5/4.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseModel.h"
@interface PurchaseTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *phone;

-(void)setContents:(PurchaseModel*)model;
+(CGFloat)cellHeight:(PurchaseModel *)model;
@end
