//
//  TradeDetailCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/14.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "TradeDetailCell.h"
#define Htrade kScreen_Height/5
@implementation TradeDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //self.backgroundColor = RGBColor(235, 235, 241);
        [self initCell];
    }
    return self;
}
-(void)initCell{
    UIView * backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.frame = CGRectMake(20, 0, kScreen_Width - 40, Htrade);
    [self addSubview:backView];
    
    headIcon = [[UIImageView  alloc]init];
    headIcon.frame = CGRectMake(10, 10, kScreen_Width/12, kScreen_Width/12);
    headIcon.layer.masksToBounds = YES;
    headIcon.layer.cornerRadius = headIcon.frame.size.width/2;
    [backView addSubview:headIcon];
    
    
    nameLab = [[UILabel alloc]init];
    nameLab.frame =CGRectMake(headIcon.x+headIcon.frame.size.width+5, 12, kScreen_Width/3, 18);
    nameLab.font = font14;
    nameLab.textColor = [UIColor darkGrayColor];
    [backView addSubview:nameLab];
    
    _detailLab = [[UILabel alloc]init];
    _detailLab.frame  = CGRectMake(backView.frame.size.width-60, 15, 40, 20);
    _detailLab.text = @"详情";
    _detailLab.textColor = RGBColor(60, 164, 226);
    _detailLab.font = [UIFont systemFontOfSize:18];
    [backView addSubview:_detailLab];
    
    introduceLab = [[UILabel alloc]init];
    introduceLab.frame = CGRectMake(headIcon.x+8, headIcon.y+headIcon.frame.size.height+10, kScreen_Width/3*2, 20);
    introduceLab.font = font13;
    introduceLab.textColor = [UIColor darkGrayColor];
    [backView addSubview:introduceLab];
    
    demandLab = [[UILabel alloc]init];
    demandLab.frame = CGRectMake(introduceLab.x, introduceLab.y+20, kScreen_Width/3*2, 20);
    demandLab.font = font13;
    demandLab.textColor = [UIColor darkGrayColor];
    [backView addSubview:demandLab];
    
    
    timeLab = [[UILabel alloc]init];
    timeLab.frame=CGRectMake(demandLab.x, Htrade-30, kScreen_Width/3*2, 20);
    timeLab.font = font13;
    timeLab.textColor = [UIColor darkGrayColor];
    [backView addSubview:timeLab];
}
-(void)setTradeDetail:(TradeDetailModel *)tradeDetail{
    headIcon.image = LoadImageByName(tradeDetail.imaName);
    nameLab.text = tradeDetail.name;
    introduceLab.text = tradeDetail.title;
    demandLab.text = [NSString stringWithFormat:@"要求：%@",tradeDetail.demand];
    timeLab.text = [NSString stringWithFormat:@"任务时间：%@",tradeDetail.time];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
