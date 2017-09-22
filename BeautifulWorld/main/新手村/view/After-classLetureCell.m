//
//  After-classLetureCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/1.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "After-classLetureCell.h"
#define kcellH kScreen_Height/8
#import "UIImageView+WebCache.h"
@implementation After_classLetureCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initCell];
    }
    return self;
}
-(void)initCell{
    _classShow = [[UIImageView alloc]init];
    _classShow.frame = CGRectMake(10, 5, kcellH, kcellH - 10);
    
    [self addSubview:_classShow];
    
    UIImageView * play = [[UIImageView alloc]init];
    play.frame = CGRectMake(kcellH/10*3, 0, kcellH/5*2, kcellH/5*2);
    play.centerY = _classShow.centerY;
    play.image = LoadImageByName(@"play_03");
    //[_classShow addSubview:play];
    
    
    UILabel * class = [[UILabel alloc]init];
    class.frame = CGRectMake(kcellH +20, 13, 40, 17);
    class.font = font13;
    class.textColor = lightTextColor;
    class.text = @"课程：";
    [self addSubview:class];
    
    //课堂名
    _classNameLab = [[UILabel alloc]init];
    _classNameLab.frame = CGRectMake(kcellH+60, 10, kScreen_Width/2, 20);
    _classNameLab.font = [UIFont systemFontOfSize:15];
    _classNameLab.textColor = [UIColor darkGrayColor];
    [self addSubview:_classNameLab];
    
    //课堂详情
    
    UIImageView * pen = [[UIImageView alloc]init];
    pen.frame = CGRectMake(class.x, kcellH-35, 20, 20);
    pen.image = LoadImageByName(@"xiangguan_03");
    [self addSubview:pen];
    _classDetailLab = [[UILabel alloc]init];
    _classDetailLab.frame = CGRectMake(class.x+25, kcellH-45, kScreen_Width - kcellH-10,40);
    _classDetailLab.textColor = [UIColor grayColor];
    _classDetailLab.font = [UIFont systemFontOfSize:13];
    _classDetailLab.numberOfLines = 2;
    [self addSubview:_classDetailLab];
    
    UIImageView * line = [[UIImageView alloc]init];
    line.frame = CGRectMake(class.x, _classNameLab.y+30, kScreen_Width/5, 5);
    line.image = LoadImageByName(@"line_03");
    [self addSubview:line];
    
    UIImageView * video = [[UIImageView alloc]initWithFrame:CGRectMake(line.x+line.frame.size.width, line.y, kScreen_Width/4, kcellH/5*2)];
    video.image = LoadImageByName(@"video_03");
    [self addSubview:video];
    
    //开始答题
    UIButton * answer = [UIButton buttonWithType:UIButtonTypeCustom];
    answer.frame = CGRectMake(kScreen_Width/5*4-10, kcellH/3, kScreen_Width/5-5, kcellH/3);
    answer.layer.masksToBounds = YES;
    answer.layer.cornerRadius = 5;
    [answer setUserInteractionEnabled:NO];
    [answer setImage:LoadImageByName(@"button_guankan_03") forState:UIControlStateNormal];
    [answer setTitleColor:RGBColor(0, 0, 76) forState:UIControlStateNormal];
    [self addSubview:answer];
    
}
-(void)setMyClass:(ClassLectureModel *)myClass{
    _classShow.image = LoadImageByName(myClass.classIma);
    //NSString * str = [NSString stringWithFormat:@"%@%@",BaseImaUrl,myClass.classIma];
    [_classShow sd_setImageWithURL:[NSURL URLWithString:myClass.classIma] placeholderImage:LoadImageByName(@"WechatIMG31")];
    //_classNameLab.text =[NSString stringWithFormat:@"课题: %@",myClass.className];
    _classNameLab.text = myClass.className;
    
    NSLog(@"教师姓名%@",myClass.teacherName);
    if (myClass.teacherName) {
        NSLog(@"教师姓名y");
         _classDetailLab.text =[NSString stringWithFormat:@"%@",myClass.teacherName];
        if ([myClass.teacherName isKindOfClass:[NSNull class]]) {
            _classDetailLab.text = @"";
        }
    }else{
         NSLog(@"教师姓名n");
         _classDetailLab.text =[NSString stringWithFormat:@"%@个",myClass.classDetail];
    }
   
}


@end
