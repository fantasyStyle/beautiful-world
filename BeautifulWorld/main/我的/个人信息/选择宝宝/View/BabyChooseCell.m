//
//  BabyChooseCell.m
//  demo
//
//  Created by yuanju001 on 16/10/29.
//  Copyright © 2016年 yuanju001. All rights reserved.
//

#import "BabyChooseCell.h"
#define kbabyH  [UIScreen mainScreen].bounds.size.height / 10
@implementation BabyChooseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        [self creatCell];
    }
    return self;
}
-(void)creatCell{
    //头像
    headIcon =[[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width/20, 5, kbabyH-10,kbabyH-10)];
    headIcon.layer.cornerRadius = (kbabyH-10)/2;
    headIcon.layer.masksToBounds=YES;
    //headIcon.backgroundColor =[UIColor grayColor];
    [self addSubview:headIcon];
    
    //姓名
    nameLab = [[UILabel alloc]init];
    nameLab.frame = CGRectMake(kScreen_Width/20 + kbabyH, 5, kScreen_Width/3, kbabyH/3+5);
   // nameLab.backgroundColor = [UIColor redColor];
    nameLab.textColor = [UIColor darkGrayColor];
    [self addSubview:nameLab];
    
    //班级
    classLab = [[UILabel alloc]init];
    classLab.frame = CGRectMake(nameLab.x, 10+kbabyH/3, kScreen_Width/3, kbabyH/3);
    //classLab.backgroundColor = [UIColor greenColor];
    classLab.textColor = [UIColor grayColor];
    classLab.font = [UIFont systemFontOfSize:15];
    [self addSubview:classLab];
}

-(void)setChoosedBabyModel:(BabyModel *)choosedBabyModel{
    headIcon.image = LoadImageByName(choosedBabyModel.cover);
    nameLab.text =choosedBabyModel.babyName;
    classLab.text = choosedBabyModel.classes;
}

@end
