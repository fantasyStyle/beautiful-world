//
//  BackpackCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/21.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "BackpackCell.h"
//#define backH 
@implementation BackpackCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self creatCell];
    }
    return self;
}
-(void)creatCell{
    packIma = [[UIImageView alloc]init];
    packIma.image = LoadImageByName(@"kuang_03");
    
    packIma.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
      [self addSubview:packIma];
    
    headIma = [[UIImageView alloc]init];
    headIma.frame = CGRectMake(0, 0, packIma.frame.size.width/4*3, packIma.frame.size.width/4*3);
    headIma.center = packIma.center;
    headIma.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:headIma];
    
    
    
    
}
-(void)setBackModel:(BackpackModel *)backModel{
     NSString * str = [NSString stringWithFormat:@"%@%@",BaseShopUrl,backModel.packName];
    [headIma sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:LoadImageByName(@"taoyi_03")];
}
@end
