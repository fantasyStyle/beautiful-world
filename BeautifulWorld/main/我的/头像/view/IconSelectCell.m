//
//  IconSelectCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/15.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "IconSelectCell.h"
#define KWcell    (kScreen_Width-80)/3
#define cellH kScreen_Height/5
@implementation IconSelectCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self creatCell];
        //self.backgroundColor = [UIColor redColor];
    }
    return self;
    
}
-(void)creatCell{
    //图片
    iconShow = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5,KWcell, KWcell)];
    iconShow.layer.masksToBounds =YES;
    iconShow.layer.cornerRadius = KWcell/2;
    [self.contentView addSubview:iconShow];
    
    
}
-(void)setUserIcon:(IconModel *)userIcon{
   iconShow.image = LoadImageByName(userIcon.icon);
    
//    NSString * str = [NSString stringWithFormat:@"%@%@",BaseShopUrl,userIcon.icon];
//    [iconShow sd_setImageWithURL:[NSURL URLWithString:str]];
}
@end
