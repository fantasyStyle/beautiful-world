//
//  EchibitCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/31.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "EchibitCell.h"
#define KWcell    (kScreen_Width-20)/3
#define cellH kScreen_Height/4
@implementation EchibitCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self creatCell];
        //self.backgroundColor = [UIColor redColor];
    }
    return self;
    
}
-(void)creatCell{
    imaShow = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,KWcell-5, KWcell)];
    
    [self.contentView addSubview:imaShow];
    
    
}
-(void)setExhibit:(ExhibitModel *)exhibit{
//    imaShow.image = LoadImageByName(exhibit.imaName);
    NSString * str = [NSString stringWithFormat:@"%@%@",BaseWorksUrl,exhibit.imaName];
    [imaShow sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:LoadImageByName(@"taoyi_03")];
//    timeLab.text = exhibit.time;
//    collectionLab.text = exhibit.collectCount;
    if (exhibit.worksName) {
        UIImageView * icon = [[UIImageView alloc]init];
        icon.frame = CGRectMake(2, KWcell+5, 13, 13);
        icon.image = LoadImageByName(@"renwu_03");
        [self.contentView addSubview:icon];
        
        worksLab = [[UILabel alloc]init];
        worksLab.frame = CGRectMake(20, icon.y, KWcell - 20, 15);
        worksLab.text = exhibit.worksName;
        worksLab.textColor = [UIColor darkGrayColor];
        worksLab.font = font13;
        [self.contentView addSubview:worksLab];
        
        
        UIImageView * icon1 = [[UIImageView alloc]init];
        icon1.frame = CGRectMake(0, KWcell+20, 13, 13);
        icon1.image  = LoadImageByName(@"time_03");
        [self.contentView addSubview:icon1];
        
        timeLab = [[UILabel alloc]initWithFrame:CGRectMake(13, icon1.y, KWcell-13, 15)];
        timeLab.textColor = [UIColor darkGrayColor];
        timeLab.font = font12;
           NSString * time = [NSDate dateFormTimestampStringForDay:exhibit.time];
        timeLab.text = time;
    
        timeLab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:timeLab];
        
        UIImageView * icon2 = [[UIImageView alloc]init];
        icon2.frame = CGRectMake(0, KWcell+35, 13, 13);
        icon2.image  = LoadImageByName(@"jifen_03");
        [self.contentView addSubview:icon2];
        
        collectionLab = [[UILabel alloc]initWithFrame:CGRectMake(20, icon2.y, KWcell-20, 15)];
        collectionLab.textColor = [UIColor darkGrayColor];
         collectionLab.text = exhibit.collectCount;
        collectionLab.font = font12;
        [self.contentView addSubview:collectionLab];

    }else{
        UIImageView * icon1 = [[UIImageView alloc]init];
        icon1.frame = CGRectMake(2, KWcell+5, 13, 13);
        icon1.image  = LoadImageByName(@"time_03");
        [self.contentView addSubview:icon1];
        
        timeLab = [[UILabel alloc]initWithFrame:CGRectMake(20, icon1.y, KWcell-20, 15)];
        timeLab.textColor = [UIColor darkGrayColor];
        timeLab.font = font12;
          NSString * time = [NSDate dateFormTimestampStringForDay:exhibit.time];
        timeLab.text = time;

        [self.contentView addSubview:timeLab];
        
        UIImageView * icon2 = [[UIImageView alloc]init];
        icon2.frame = CGRectMake(0, KWcell+20, 13, 13);
        icon2.image  = LoadImageByName(@"jifen_03");
        [self.contentView addSubview:icon2];
        
        collectionLab = [[UILabel alloc]initWithFrame:CGRectMake(20, icon2.y, KWcell-20, 15)];
        collectionLab.text = exhibit.collectCount;

        collectionLab.textColor = [UIColor darkGrayColor];
        collectionLab.font = font12;
        [self.contentView addSubview:collectionLab];

    }
}
@end
