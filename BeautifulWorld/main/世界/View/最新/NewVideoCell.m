//
//  NewVideoCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/29.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "NewVideoCell.h"
#define  KCellH   kScreen_Height/5*2
@implementation NewVideoCell

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
    headIcon = [[UIImageView alloc]init];
    headIcon.frame = CGRectMake(10, 10, kScreen_Width/9, kScreen_Width/9);
    headIcon.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:headIcon];
    
    nameLab = [[UILabel alloc]init];
    nameLab.frame = CGRectMake(headIcon.x + headIcon.frame.size.width +10, 10, 50, 20);
    nameLab.font = font15;
    nameLab.textColor = [UIColor darkGrayColor];
    [self addSubview:nameLab];
    
    interoduceLab = [[UILabel alloc]init];
    interoduceLab.frame = CGRectMake(nameLab.x, nameLab.y+20, kScreen_Width/2, 20);
    interoduceLab.font = font14;
    interoduceLab.textColor = [UIColor darkGrayColor];
    [self addSubview:interoduceLab];
    
    sexIma = [[UIImageView alloc]init];
    sexIma.frame = CGRectMake(nameLab.x + 60, 10, 20, 20);
    [self addSubview:sexIma];
    
    newIma = [[UIImageView alloc]init];
    newIma.frame = CGRectMake(kScreen_Width - 70, 10, 40, 40);
    newIma.image = LoadImageByName(@"zuixin_03");
    [self addSubview:newIma];
    
    
    videoIma = [[UIImageView alloc]init];
    videoIma.frame = CGRectMake(headIcon.x, headIcon.y+headIcon.frame.size.width+5, kScreen_Width -20, KCellH-(headIcon.y+headIcon.frame.size.width+5+25));
    videoIma.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:videoIma];
    UIImageView * play = [[UIImageView alloc]init];
    play.frame = CGRectMake(0, (videoIma.frame.size.height - kScreen_Width/6)/2, kScreen_Width/6, kScreen_Width/6);
    //play.center = videoIma.center;
    play.centerX =videoIma.centerX;
    play.image = LoadImageByName(@"play_03");

    [videoIma addSubview:play];
    
    
    visitBtn = [[UIButton alloc]init];
    visitBtn.frame = CGRectMake(10, KCellH-25, 50, 20);
    [visitBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    visitBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [visitBtn setImage:LoadImageByName(@"liulan_03") forState:UIControlStateNormal];
    [visitBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    [visitBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0,-5)];
    
    
   // [self addSubview:visitBtn];
    
    zanBtn = [[UIButton alloc]init];
    zanBtn.frame =CGRectMake(kScreen_Width/3*2, visitBtn.y, 50, 20);
    [zanBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    zanBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [zanBtn setImage:LoadImageByName(@"zan_03") forState:UIControlStateNormal];
    [zanBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    [zanBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0,-5)];
   // [self addSubview:zanBtn];
    
    jfBtn = [[UIButton alloc]init];
    jfBtn.frame =CGRectMake(zanBtn.x+zanBtn.frame.size.width+10, visitBtn.y, 50, 20);
    [jfBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    jfBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [jfBtn setTitle:@"234" forState:UIControlStateNormal];
    [jfBtn setImage:LoadImageByName(@"pinglun_03") forState:UIControlStateNormal];
    [jfBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    [jfBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0,-2)];
    
   // [self addSubview:jfBtn];


    
    
}
-(void)setVideo:(NewVideoModel *)video{
   // headIcon.image = LoadImageByName(video.icon);
    NSString * str = [NSString stringWithFormat:@"%@%@",BaseShopUrl,video.icon];
    [headIcon sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:LoadImageByName(@"yue_03")];
    nameLab.text = video.author;
    sexIma.image = LoadImageByName(video.sex);
//    videoIma.image = LoadImageByName(video.imaName);
    NSString * str1 = [NSString stringWithFormat:@"%@%@",teacherVideoUrl,video.imaName];
    [videoIma sd_setImageWithURL:[NSURL URLWithString:str1] placeholderImage:LoadImageByName(@"video_01_03")];
    interoduceLab.text = video.introduce;
    
    [visitBtn setTitle:video.visitCount forState:UIControlStateNormal];
    [zanBtn setTitle:video.zanCount forState:UIControlStateNormal];
    [jfBtn setTitle:video.jfCount forState:UIControlStateNormal];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
