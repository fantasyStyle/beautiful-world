//
//  TeacherSceneryCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/7.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "TeacherSceneryCell.h"
#define cellH    (kScreen_Width-30)/2
@implementation TeacherSceneryCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self creatCell];
     
    }
    return self;
}
-(void)creatCell{
    //图片
    _picShow = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,(kScreen_Width-30)/2, cellH/4*3)];
    [self.contentView addSubview:_picShow];
    
    _suoIma = [[UIImageView alloc]initWithFrame:CGRectMake(0, _picShow.frame.size.height-30, 30, 30)];
    _suoIma.image = LoadImageByName(@"suo_03");
    [_picShow addSubview:_suoIma];
    
    UIImageView * timeIcon = [[UIImageView alloc]init];
    timeIcon.frame = CGRectMake(0, _picShow.frame.size.height+5, 18, 18);
    timeIcon.image = LoadImageByName(@"time_03");
    [self addSubview:timeIcon];
    
    _timeLab = [[UILabel alloc]init];
    _timeLab.frame = CGRectMake(timeIcon.x +20, timeIcon.y, cellH - 20, 18);
    _timeLab.textColor = [UIColor darkGrayColor];
    _timeLab.font =font13;
    [self addSubview:_timeLab];
    //标题
    _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, _timeLab.y+20  ,cellH,20)];
    _titleLab.textColor = [UIColor darkGrayColor];
    _titleLab.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:_titleLab];
    
    
    
}
-(void)setTeacherModel:(TeacherSceneryModel *)teacherModel{
    NSString * str = [NSString stringWithFormat:@"%@%@",teacherVideoUrl,teacherModel.cover];
    [_picShow sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:LoadImageByName(@"huodong_02")];
     NSString * time = [NSDate dateFormTimestampStringForDay:teacherModel.time];
    _titleLab.text = teacherModel.title;
    _timeLab.text = time;
}
@end
