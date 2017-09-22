//
//  PlanCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/2/21.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "PlanCell.h"

@implementation PlanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initPlanView];
    }
    return self;
}
-(void)initPlanView{
    
    spirit = [[UIImageView alloc]init];
    spirit.frame = CGRectMake(kScreen_Width/9, 10, kHeight/5*2, kHeight/5*2);
    spirit.image = LoadImageByName(@"精灵");
    [self addSubview:spirit];
    
    
    frameView = [[UIImageView alloc]init];
    frameView.frame = CGRectMake(kScreen_Width/9+kHeight/5*2+5, 20, kScreen_Width/2, kHeight/3-10);
    frameView.image = LoadImageByName(@"对话框");
    [frameView addTapTraget:self withAction:@selector(makeFormute)];
    [self addSubview:frameView];
    
    //是否有学习计划
    YNLab = [[UILabel alloc]init];
    YNLab.frame = CGRectMake(20, 15, kScreen_Width/2-30, 40);
    //YNLab.backgroundColor = [UIColor grayColor];
    YNLab.text = @"赶紧来完成今天的学习任务吧";
    YNLab.numberOfLines = 2;
    YNLab.font = [UIFont systemFontOfSize:15];
    YNLab.textColor = [UIColor darkGrayColor];
    [frameView addSubview:YNLab];

}
-(void)makeFormute{
    if ([self.delegate respondsToSelector:@selector(makeFormulate)]) {
        [self.delegate makeFormulate];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
