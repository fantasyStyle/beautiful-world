//
//  RecommendGoodsCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/2/23.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "RecommendGoodsCell.h"

@implementation RecommendGoodsCell

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
    CGFloat margin = kScreen_Width/8;
    CGFloat marginM = kScreen_Width/9;//两个图片的间隙
    CGFloat KWIma = (kScreen_Width-margin*2-marginM)/2;//图片单个直径
    //商品1
    goodsIma1 = [[UIImageView alloc]init];
    goodsIma1.frame = CGRectMake(margin, 5, KWIma, kScreen_Height/4-20);
    goodsIma1.tag = 1;
    [goodsIma1 addTapTraget:self withAction:@selector(onTap:)];
    [self addSubview:goodsIma1];
    
       //商品2
    goodsIma2 = [[UIImageView alloc]init];
    goodsIma2.frame = CGRectMake(margin+KWIma+marginM, 5, KWIma, kScreen_Height/4-20);
    goodsIma2.tag =2;
    [goodsIma2 addTapTraget:self withAction:@selector(onTap:)];

    [self addSubview:goodsIma2];
    

}
-(void)onTap:(UITapGestureRecognizer *)tap{
    if (tap.view.tag == 1) {
        if ([self.jCellTapDelegate respondsToSelector:@selector(TapJourneyCell)]) {
            [self.jCellTapDelegate TapJourneyCell];
        }
    }
    else{
        if ([self.jCellTapDelegate respondsToSelector:@selector(TapTradeCell)]) {
            [self.jCellTapDelegate TapTradeCell];
        }
    }
}
-(void)setMyGoodsModel:(RecommendModel *)myGoodsModel{
    goodsIma1.image = LoadImageByName(myGoodsModel.goodsImaName1);
    goodsIma2.image = LoadImageByName(myGoodsModel.goodsImaName2);
   
}

@end
