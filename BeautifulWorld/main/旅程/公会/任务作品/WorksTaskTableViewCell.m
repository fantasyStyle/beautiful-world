//
//  WorksTaskTableViewCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/5/4.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "WorksTaskTableViewCell.h"
#define KWcell    (kScreen_Width-20)/3
#define cellH kScreen_Height/4
@implementation WorksTaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self creatCell];
        //self.backgroundColor = [UIColor redColor];
    }
    return self;
    
}
-(void)creatCell{
    imaShow = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,KWcell, KWcell)];
    
    [self.contentView addSubview:imaShow];
    
    icon = [[UIImageView alloc]init];
    icon.frame = CGRectMake(0, imaShow.frame.size.height+2, KWcell/4, KWcell/4);
    [self.contentView addSubview:icon];
    
    nameLab = [[UILabel alloc]init];
    nameLab.frame = CGRectMake(icon.frame.size.width+5, icon.y+5, 50, 20);
    nameLab.textColor = [UIColor darkGrayColor];
    nameLab.font = font15;
    [self.contentView addSubview:nameLab];
    
    
    collectionBtn = [[UIButton alloc]init];
    collectionBtn.frame = CGRectMake(KWcell-55 , nameLab.y, 50, 20);
    [collectionBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    collectionBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [collectionBtn setImage:LoadImageByName(@"xing_03") forState:UIControlStateNormal];
    [collectionBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    [collectionBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0,-5)];
    
    
    [self addSubview:collectionBtn];

    zanBtn = [[UIButton alloc]init];
    zanBtn.frame =CGRectMake(collectionBtn.x ,cellH-20, 50, 20);
    [zanBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    zanBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [zanBtn setImage:LoadImageByName(@"zan_03") forState:UIControlStateNormal];
    [zanBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    [zanBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0,-5)];
    [self addSubview:zanBtn];

    
    
}

-(void)setTask:(WorksTaskModel *)task{
    imaShow.image = LoadImageByName(task.imaName);
    icon.image = LoadImageByName(task.headIcon);
    nameLab.text = task.name;
    [collectionBtn setTitle:task.collectCount forState:UIControlStateNormal];
    [zanBtn setTitle:task.zanCount forState:UIControlStateNormal];
}


@end
