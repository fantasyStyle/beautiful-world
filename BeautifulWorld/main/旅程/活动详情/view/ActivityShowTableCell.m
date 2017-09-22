//
//  ActivityShowTableCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/14.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "ActivityShowTableCell.h"

@implementation ActivityShowTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconIma.layer.masksToBounds = YES;
    self.iconIma.layer.cornerRadius  = 25;
    
    
    // Initialization code
}

-(void)setActDetail:(ActivityDetailModel *)actDetail{
    _iconIma.image = LoadImageByName(actDetail.icon);
    _nameLab.text = actDetail.name;
    _timeLab.text = actDetail.date;
    _themeLab.text = actDetail.theme;
    _contentLab1.text = actDetail.detail1;
    _contentLab2.text = actDetail.detail2;
    _imaShow.image = LoadImageByName(actDetail.ima);
    _joinNumLab.text = [NSString stringWithFormat:@"共%@人参与",actDetail.joinNum];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
