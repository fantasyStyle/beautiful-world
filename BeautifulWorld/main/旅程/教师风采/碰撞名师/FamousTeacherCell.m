//
//  FamousTeacherCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/14.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "FamousTeacherCell.h"
#define Hfamous kScreen_Height/6
@implementation FamousTeacherCell

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
    headIma = [[UIImageView alloc]init];
    headIma.frame = CGRectMake(15, 10, Hfamous -20, Hfamous - 20);
    [self addSubview:headIma];
    
    nameLab = [[UILabel alloc]init];
    nameLab.frame = CGRectMake(headIma.x + headIma.frame.size.width +20, 10, 50, 20);
    nameLab.font = font15;
    nameLab.textColor = [UIColor darkGrayColor];
    [self addSubview:nameLab];
    
    sexIma = [[UIImageView alloc]init];
    sexIma.frame = CGRectMake(nameLab.x + 60, 10, 20, 20);
    [self addSubview:sexIma];
    
    
    ageLab = [[UILabel alloc]init];
    ageLab.frame = CGRectMake(sexIma.x + 30, 10, 50, 20);
    ageLab.textColor = [UIColor darkGrayColor];
    ageLab.font = font14;
    [self addSubview:ageLab];
    
    schoolLab = [[UILabel alloc]init];
    schoolLab.frame = CGRectMake(nameLab.x, nameLab.y+30, kScreen_Width/3*2, 20);
    schoolLab.textColor = [UIColor darkGrayColor];
    schoolLab.font = font13;
    [self addSubview:schoolLab];
    
    studentLab = [[UILabel alloc]init];
    studentLab.frame = CGRectMake(nameLab.x, schoolLab.y+25,kScreen_Width/3 , 20);
    studentLab.textColor = [UIColor darkGrayColor];
    studentLab.font = font13;
    [self addSubview:studentLab];
    
    _apprenticedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _apprenticedBtn.frame = CGRectMake(kScreen_Width - 60, 8, 50, 22);
    [_apprenticedBtn setImage:LoadImageByName(@"baishi_03") forState:UIControlStateNormal];
    [self addSubview:_apprenticedBtn];
    
    
}
-(void)setTeacherModel:(FamousTeacherModel *)teacherModel{
//    headIma.image  = LoadImageByName(teacherModel.imaName);
    
    NSString * str = [NSString stringWithFormat:@"%@%@",teacherUrl,teacherModel.imaName];
    [headIma sd_setImageWithURL:[NSURL URLWithString:str]];
    nameLab.text = teacherModel.name;
    sexIma.image = LoadImageByName(teacherModel.sex);
    ageLab.text = teacherModel.age;
    schoolLab.text =[NSString stringWithFormat:@"毕业于%@",teacherModel.school];
    studentLab.text =[NSString stringWithFormat:@"学生：%@人",teacherModel.studentCount];
    CGFloat styleW = 35;
    CGFloat margin = 10;
    NSString * apprence = [NSString stringWithFormat:@"%@",teacherModel.YNAppretticed];
    if ([apprence isEqualToString:@"0"]) {
        _apprenticedBtn.hidden = NO;
    }else{
        _apprenticedBtn.hidden = YES;
    }

//    for (int i = 0; i<teacherModel.styleArr.count; i++) {
//        styleIma = [[UIImageView alloc]init];
//        styleIma.frame = CGRectMake(nameLab.x+(styleW + margin)*i, Hfamous-25, styleW, 15);
//        styleIma.image = LoadImageByName(teacherModel.styleArr[i]);
//        [self addSubview:styleIma];
//        
//    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
