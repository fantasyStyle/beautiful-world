//
//  RecommendUsersCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/15.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "RecommendUsersCell.h"
#define cellH kScreen_Height/7*2
@implementation RecommendUsersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCell];
    }
    return self;
    
}
-(void)initCell{
    icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 8, kScreen_Width/6, kScreen_Width/6)];
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = kScreen_Width/12;
    [self addSubview:icon];
    
    nameLab = [[UILabel alloc]initWithFrame:CGRectMake(20+icon.frame.size.width, 12, 100, 20)];
    nameLab.textColor = [UIColor darkGrayColor];
    nameLab.font = font14;
    [self addSubview:nameLab];
    
    recommendLab = [[UILabel alloc]initWithFrame:CGRectMake(nameLab.x, 35, 100, 20)];
    recommendLab.textColor = [UIColor darkGrayColor];
    recommendLab.font = font13;
    [self addSubview:recommendLab];
    CGFloat margin = 10;
    CGFloat imaW =( kScreen_Width - margin * 4)/3;
    imaShow1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15+kScreen_Width/6, imaW, cellH-25-kScreen_Width/6)];
    [self addSubview:imaShow1];
    
    imaShow2 = [[UIImageView alloc]initWithFrame:CGRectMake(margin + imaW+10, imaShow1.y, imaW, cellH-25-kScreen_Width/6)];
    [self addSubview:imaShow2];
    
    imaShow3 = [[UIImageView alloc]initWithFrame:CGRectMake(margin*2+10+imaW*2, imaShow1.y, imaW, cellH-25-kScreen_Width/6)];
    [self addSubview:imaShow3];
    
    //关注按钮
    focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    focusBtn.frame = CGRectMake(kScreen_Width-50,15, 40, 22);
    focusBtn.backgroundColor = RGBColor(230, 231, 234);
    focusBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [focusBtn setTitle:@"关注" forState:UIControlStateNormal];
    [focusBtn setTitleColor:BlueTitileColor forState:UIControlStateNormal];
    focusBtn.layer.masksToBounds = YES;
    focusBtn.layer.cornerRadius  = 5;
    [self addSubview:focusBtn];
    
    
}
-(void)setUsersModel:(RecommendUsersModel *)usersModel{
    icon.image = LoadImageByName(usersModel.iconName);
    nameLab.text = usersModel.name;
    recommendLab.text = usersModel.reccommend;
    imaShow1.image = LoadImageByName(usersModel.ima1);
    imaShow2.image = LoadImageByName(usersModel.ima2);
    imaShow3.image = LoadImageByName(usersModel.ima3);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
