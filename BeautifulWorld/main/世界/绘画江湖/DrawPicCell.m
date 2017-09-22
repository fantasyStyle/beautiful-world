//
//  DrawPicCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/5/2.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "DrawPicCell.h"
#define KWcell    (kScreen_Width-15)/2
#define cellH kScreen_Height/6

@implementation DrawPicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self creatCell];
        
        
    }
    
    return self;
}
-(void)creatCell{
    //图片
    _iconShow = [[UIImageView alloc]initWithFrame:CGRectMake(2, 10,KWcell/2, KWcell/2 )];
    _iconShow.contentMode = UIViewContentModeScaleAspectFit;
    _iconShow.backgroundColor = RGBColor(235, 235, 241);
    
    [self.contentView addSubview:_iconShow];
    
    //用户
    _userName = [[UILabel alloc]initWithFrame:CGRectMake(_iconShow.frame.size.width+10, 10, KWcell/2, 20)];
    _userName.font = [UIFont systemFontOfSize:12];
    _userName.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:_userName];
    
    //等级
    _gradeLab = [[UILabel alloc]initWithFrame:CGRectMake(_userName.x, 40, KWcell/2, 20)];
    _gradeLab.font = font13;
    _gradeLab.textColor  = [UIColor darkGrayColor];
    [self.contentView addSubview:_gradeLab];
    //关注
    _attentionBtn  =[[UIButton  alloc]initWithFrame:CGRectMake(_userName.x , 70, 50, 20)];
    [_attentionBtn setTitle:@"+关注" forState:UIControlStateNormal];
    [_attentionBtn setTitleColor:BlueTitileColor forState:UIControlStateNormal];
    _attentionBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_attentionBtn setImage:LoadImageByName(@"guanzhu_03") forState:UIControlStateNormal];
    [_attentionBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    [_attentionBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0,-5)];
    
   // [self.contentView addSubview:_attentionBtn];
    
    
    
}
-(void)setReUserModel:(ReUserModel *)reUserModel{
//    _iconShow.image = LoadImageByName(reUserModel.icon);
    
    NSString * str = [NSString stringWithFormat:@"%@%@",BaseShopUrl,reUserModel.icon];
    [_iconShow sd_setImageWithURL:[NSURL URLWithString:str]];
    _gradeLab.text =[NSString stringWithFormat:@"lv: %@", reUserModel.grade];
    _userName.text = reUserModel.userName;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
