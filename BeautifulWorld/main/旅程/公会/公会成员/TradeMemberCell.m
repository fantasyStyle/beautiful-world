//
//  TradeMemberCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/14.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "TradeMemberCell.h"
#define memberH kScreen_Height/12
@implementation TradeMemberCell

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
    iconIma = [[UIImageView alloc]init];
    iconIma.frame = CGRectMake(20, 5, memberH - 10, memberH - 10);
    [self addSubview:iconIma];
    
    
    sexIma = [[UIImageView alloc]init];
//    _creater = YES;
    if (self.cellTag == 1) {
        NSLog(@"呵呵好呵呵哈我和我 i 海外 i 和我");
        createrLab = [[UILabel alloc]init];
        createrLab.frame =CGRectMake(iconIma.x+iconIma.frame.size.width +10,(memberH-20)/2, iconIma.frame.size.width,20);
        createrLab.text = @"创建者";
        createrLab.textColor = [UIColor darkGrayColor];
        createrLab.font = font14;
        [self addSubview:createrLab];
        sexIma.frame = CGRectMake(createrLab.x+createrLab.frame.size.width+10, createrLab.y, 15, 15);
        
    }else{
        sexIma.frame = CGRectMake(iconIma.x+iconIma.frame.size.width +10,(memberH-20)/2 , 20, 20);
    }
    [self addSubview:sexIma];
    
    nameLab = [[UILabel alloc]init];
    nameLab.frame = CGRectMake(sexIma.x+25, sexIma.y, 50, 20);
    nameLab.textColor = [UIColor darkGrayColor];
    nameLab.font = font15;
    [self addSubview:nameLab]
    ;
    
    focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    focusBtn.frame = CGRectMake(kScreen_Width - 60, 15,50 , memberH - 30);
    [focusBtn setImage:LoadImageByName(@"yiguanzhu_03") forState:UIControlStateSelected];
    focusBtn.tag = self.cellTag;
    [focusBtn addTarget:self action:@selector(focusClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:focusBtn];
}
-(void)focusClick:(UIButton *)sender{
    sender.selected = YES;
}
-(void)setMemberModel:(TradeMemberModel *)memberModel{
    iconIma.image = LoadImageByName(memberModel.memberIcon);
    sexIma.image = LoadImageByName(memberModel.sex);
    nameLab.text = memberModel.name;
    [focusBtn setImage:LoadImageByName(memberModel.YNFocus) forState:UIControlStateNormal];
    CGFloat styleW = 35;
    CGFloat margin = 10;
    for (int i =0; i<memberModel.styleArr.count; i++) {
        styleIma = [[UIImageView alloc]init];
        styleIma.frame = CGRectMake(nameLab.x+60+(styleW+margin)*i, nameLab.y, styleW, 20);
        styleIma.image = LoadImageByName(memberModel.styleArr[i]);
        
        
        [self addSubview:styleIma];    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
