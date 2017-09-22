//
//  TeacherDetailCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/7.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "TeacherDetailCell.h"
#define KcellH kScreen_Height/8
@implementation TeacherDetailCell

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
    imaShow  = [[UIImageView alloc]init];
    imaShow.frame = CGRectMake(5,5,kScreen_Width/4 ,KcellH - 10);
    
    [self addSubview:imaShow];
    
    
    NameLab  = [[UILabel alloc]init];
    NameLab.frame = CGRectMake(kScreen_Width/4+10, 6, kScreen_Width/4*3-30, 20);
    
    NameLab.font = [UIFont systemFontOfSize:14];
    NameLab.textColor = [UIColor darkGrayColor];
    [self addSubview:NameLab];
    
    introduceLab  = [[UILabel alloc]init];
    introduceLab.frame = CGRectMake(NameLab.x, NameLab.y+20, kScreen_Width/4*3-30,40);
    introduceLab.font = [UIFont systemFontOfSize:12];
    introduceLab.numberOfLines = 3;
    introduceLab.textColor = [UIColor darkGrayColor];
    [self addSubview:introduceLab];
    
}
-(void)setCourse:(TeacherDetailModel *)course{
    imaShow.image = LoadImageByName(course.imaName);
    NameLab.text = course.courseName;
    introduceLab.text = course.introduce;
}

@end
