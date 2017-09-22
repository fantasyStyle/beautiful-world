//
//  GradeCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/2/21.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "GradeCell.h"

@implementation GradeCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initGradeCell];
      
    }
    return self;
}
-(void)initGradeCell{
   
    UIImageView * backIma = [[UIImageView alloc]init];
    backIma.backgroundColor = RGBColor(120, 181, 30);
    backIma.frame = CGRectMake(20, 8, 2, 24);
    [self addSubview:backIma];
    
    
    UIImageView * ima = [[UIImageView alloc]init];
    ima.frame = CGRectMake(40, 10, 20, 20);
    ima.image = LoadImageByName(@"xuexianpai_03");
    [self addSubview:ima];
    
    
    //学习排名
    rankLab = [[UILabel alloc]init];
    rankLab.frame = CGRectMake(0,10, kScreen_Width, 20);
    [rankLab addTapTraget:self withAction:@selector(onRankClick)];
    rankLab.textAlignment= NSTextAlignmentCenter;
    rankLab.textColor = [UIColor darkGrayColor];
    rankLab.font = [UIFont systemFontOfSize:16];
    [self addSubview:rankLab];
}
-(void)onRankClick{
    NSLog(@"查看学习排名");
    if ([self.rankDelegate respondsToSelector:@selector(TapRankCellDelegate)]) {
        [self.rankDelegate TapRankCellDelegate];
    }
}
-(void)setMyGrade:(GradeModel *)myGrade{
    rankLab.text = [NSString stringWithFormat:@"本周学习排名，第%@名",myGrade.rank];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
