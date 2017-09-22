//
//  WorksDetailsCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/5/2.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "WorksDetailsCell.h"
#define  KCellH   kScreen_Height/5*3
@implementation WorksDetailsCell

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
    headIcon = [[UIImageView alloc]init];
    headIcon.frame = CGRectMake(10, 10, kScreen_Width/9, kScreen_Width/9);
    headIcon.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:headIcon];
    
    nameLab = [[UILabel alloc]init];
    nameLab.frame = CGRectMake(headIcon.x + headIcon.frame.size.width +10, 10, 50, 20);
    nameLab.font = font15;
    nameLab.textColor = [UIColor darkGrayColor];
    [self addSubview:nameLab];
    
    timeLab = [[UILabel alloc]init];
    timeLab.frame = CGRectMake(nameLab.x, nameLab.y+20, kScreen_Width/2, 20);
    timeLab.font = font14;
    timeLab.textColor = [UIColor darkGrayColor];
    [self addSubview:timeLab];
    
    
    
    interoduceLab = [[UILabel alloc]init];
    interoduceLab.frame = CGRectMake(headIcon.x , headIcon.y+headIcon.frame.size.width+5, kScreen_Width-headIcon.x*2, 40);
    interoduceLab.font = font14;
    interoduceLab.numberOfLines = 2;
    interoduceLab.textColor = [UIColor darkGrayColor];
    [self addSubview:interoduceLab];

    videoIma = [[UIImageView alloc]init];
    videoIma.frame = CGRectMake(headIcon.x, interoduceLab.y+interoduceLab.frame.size.height, kScreen_Width -20, KCellH-(headIcon.y+headIcon.frame.size.width+5+30+40));
    videoIma.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:videoIma];
    UIImageView * play = [[UIImageView alloc]init];
    play.frame = CGRectMake(0, (videoIma.frame.size.height - kScreen_Width/6)/2, kScreen_Width/6, kScreen_Width/6);
    //play.center = videoIma.center;
    play.centerX =videoIma.centerX;
    play.image = LoadImageByName(@"play_03");
    
   // [videoIma addSubview:play];
    
    
    zanBtn = [[UIButton alloc]init];
    zanBtn.frame =CGRectMake(kScreen_Width-60, KCellH-30, 50, 20);
    [zanBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    zanBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [zanBtn setImage:LoadImageByName(@"zan_03") forState:UIControlStateNormal];
    [zanBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    [zanBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0,-5)];
   // [self addSubview:zanBtn];
    
    
    
    
    
}
-(void)setWorks:(WorksDetailsModel *)works{
   // headIcon.image = LoadImageByName(works.iconName);
    NSString * str = [NSString stringWithFormat:@"%@%@",BaseShopUrl,works.iconName];
    [headIcon sd_setImageWithURL:[NSURL URLWithString:str]];
    nameLab.text = works.name;
    timeLab.text = works.time;
    interoduceLab.text = works.introduce;
    videoIma.image  = LoadImageByName(works.imaName);
    NSString * str1 = [NSString stringWithFormat:@"%@%@",BaseWorksUrl,works.imaName];
    [videoIma sd_setImageWithURL:[NSURL URLWithString:str1]];

    
    [zanBtn setTitle:works.zanCount forState:UIControlStateNormal];
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
