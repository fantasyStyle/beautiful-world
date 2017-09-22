//
//  AllianceTableViewCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/13.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "AllianceTableViewCell.h"
#define tradeH kScreen_Height/5
@implementation AllianceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
    
}
-(void)initView{
    ima = [[UIImageView alloc]init];
    ima.frame = CGRectMake(25, 10, tradeH - 20, tradeH - 20);
    [self addSubview:ima];
    
    titleLab = [[UILabel alloc]init];
    titleLab.frame = CGRectMake(ima.x + ima.frame.size.width +15, 15, kScreen_Width/3, 20);
    titleLab.textColor = [UIColor darkGrayColor];
    titleLab.font = font14;
    [self addSubview:titleLab];
    
    UIImageView * timeIcon = [[UIImageView alloc]init];
    timeIcon.frame = CGRectMake(titleLab.x, titleLab.y+30, 15, 15);
    timeIcon.image = LoadImageByName(@"time_03");
    [self addSubview:timeIcon];
    
    timeLab = [[UILabel alloc]init];
    timeLab.frame = CGRectMake(titleLab.x+20, timeIcon.y-2, kScreen_Width/3, 18);
    timeLab.font = font13;
    timeLab.textColor = [UIColor darkGrayColor];
    [self addSubview:timeLab];
    
    UIImageView * imaVisit = [[UIImageView alloc]init];
    imaVisit.frame = CGRectMake(titleLab.x, tradeH-30, 25, 18);
    imaVisit.image = LoadImageByName(@"qun_03");
    [self addSubview:imaVisit];
    
    visitCountLab = [[UILabel alloc]init];
    visitCountLab.frame = CGRectMake(imaVisit.x + 35, imaVisit.y, 50, 18);
    visitCountLab.font = font13;
    visitCountLab.textColor =[UIColor darkGrayColor];
    [self addSubview:visitCountLab];
    
    hotLab = [[UILabel alloc]init];
    hotLab.frame = CGRectMake(kScreen_Width/2+50, imaVisit.y, 40, 18);
    hotLab.textColor = [UIColor darkGrayColor];
    hotLab.text = @"活跃度";
    hotLab.font = font13;
    [self addSubview:hotLab];
    
    _joinLab = [[UILabel alloc]init];
    _joinLab.frame= CGRectMake(kScreen_Width - 60, 10, 40, 20);
    _joinLab.backgroundColor = [UIColor redColor];
    _joinLab.text = @"+加入";
    _joinLab.textColor = [UIColor whiteColor];
    _joinLab.font = font14;
    [self addSubview:_joinLab];
    
    
    
    
    
}
-(void)setMyAlliance:(AllianceModel *)myAlliance{
    ima.image = LoadImageByName(myAlliance.tradeIma);
    titleLab.text = myAlliance.tradeTitle;
    timeLab.text = myAlliance.tradeTime;
    visitCountLab.text = myAlliance.visitCount;
    CGFloat styleW = 35;
    CGFloat margin = 10;
    for (int i =0; i< myAlliance.styleArr.count; i++) {
        styleIma = [[UIImageView alloc]init];
        styleIma.frame = CGRectMake(titleLab.x+(styleW+margin)*i, timeLab.y+30, styleW, 15);
        styleIma.image = LoadImageByName(myAlliance.styleArr[i]);
        [self  addSubview:styleIma];
    }
    for (int i = 0; i< myAlliance.hotRate; i++) {
        starIma = [[UIImageView alloc]init];
        starIma.frame = CGRectMake(hotLab.x+45+(15+3)*i, hotLab.y, 15, 15);
        starIma.image = LoadImageByName(@"xing_03");
        [self.viewForLastBaselineLayout addSubview:starIma];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
