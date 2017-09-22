//
//  RelatedGoodsCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/16.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "RelatedGoodsCell.h"
#define KHCell kScreen_Height/6
@implementation RelatedGoodsCell

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
    CGFloat margin = 15;
    CGFloat kIma = (kScreen_Width - margin *4)/3;
    goodsIma1 = [[UIImageView alloc]initWithFrame:CGRectMake(margin, 10, kIma, KHCell-20)];
    [self addSubview:goodsIma1];
    
    goodsIma2 = [[UIImageView alloc]initWithFrame:CGRectMake(margin*2+kIma, 10, kIma, KHCell-20)];
    [self addSubview:goodsIma2];
    
    goodsIma3 = [[UIImageView alloc]initWithFrame:CGRectMake(margin*3+kIma*2, 10, kIma, KHCell-20)];
    [self addSubview:goodsIma3];
}
-(void)setRelatedGoods:(RelatedGoodsModel *)relatedGoods{
    goodsIma1.image = LoadImageByName(relatedGoods.goods1);
    goodsIma2.image = LoadImageByName(relatedGoods.goods2);
    goodsIma3.image = LoadImageByName(relatedGoods.goods3);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
