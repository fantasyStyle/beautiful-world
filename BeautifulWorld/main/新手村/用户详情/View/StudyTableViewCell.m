//
//  StudyTableViewCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/7.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "StudyTableViewCell.h"

@implementation StudyTableViewCell

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
    progressLab  = [[UILabel alloc]init];
    progressLab.frame = CGRectMake(20, 5, kScreen_Width/2, 20);
    progressLab.font = [UIFont systemFontOfSize:14];
    progressLab.textColor = [UIColor darkGrayColor];
    [self addSubview:progressLab];
    
    
    timeLab  = [[UILabel alloc]init];
    timeLab.frame = CGRectMake(20, 25, kScreen_Width/2, 20);
    timeLab.font = [UIFont systemFontOfSize:13];
    timeLab.textColor = [UIColor darkGrayColor];
    [self addSubview:timeLab];
    
    YNFinishLab  = [[UILabel alloc]init];
    YNFinishLab.frame = CGRectMake(kScreen_Width/4, 25, kScreen_Width/5, 20);
    YNFinishLab.font = [UIFont systemFontOfSize:13];
    YNFinishLab.textColor = [UIColor darkGrayColor];
    [self addSubview:YNFinishLab];
    
}
-(void)setStudyState:(StudyStateModel *)studyState{
    progressLab.text = studyState.progress;
    timeLab.text = studyState.time;
    YNFinishLab.text = studyState.ynFinish;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
