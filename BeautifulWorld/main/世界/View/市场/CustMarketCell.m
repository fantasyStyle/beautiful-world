//
//  CustMarketCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/30.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "CustMarketCell.h"

@implementation CustMarketCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initRecommendCell];
    }
    return self;
}
-(void)initRecommendCell{
    //商品
    CGFloat margin = 15;
    CGFloat KWIma = (kScreen_Width-margin*3)/2;//图片单个直径
    //商品1
    imaShow1 = [[UIImageView alloc]init];
    imaShow1.frame = CGRectMake(margin, 5, KWIma, kScreen_Height/5-20);
    imaShow1.tag = 1;
    [imaShow1 addTapTraget:self withAction:@selector(onTap:)];
    [self addSubview:imaShow1];
    
    //商品2
    imaShow2 = [[UIImageView alloc]init];
    imaShow2.frame = CGRectMake(margin*2+KWIma, 5, KWIma, kScreen_Height/5-20);
    imaShow2.tag =2;
    [imaShow2 addTapTraget:self withAction:@selector(onTap:)];
    
    [self addSubview:imaShow2];
    
    

}
-(void)onTap:(UITapGestureRecognizer *)tap{
    
  
    if (tap.view.tag == 1) {
        if ([self.marketDelegate respondsToSelector:@selector(tapBuyMarket)]) {
            [self.marketDelegate tapBuyMarket];
        }
    }
    else{
        if ([self.marketDelegate respondsToSelector:@selector(tapSellMarket)]) {
            [self.marketDelegate tapSellMarket];
        }    }
}
-(void)setMarket:(CustMarketModel *)market{
    imaShow1.image = LoadImageByName(market.ima1);
    imaShow2.image = LoadImageByName(market.ima2);
    
}



@end
