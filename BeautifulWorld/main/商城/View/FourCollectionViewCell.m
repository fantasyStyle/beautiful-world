//
//  FourCollectionViewCell.m
//  NewWorld
//
//  Created by fantasy  on 2017/2/9.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "FourCollectionViewCell.h"
@interface FourCollectionViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *Title;

@end

@implementation FourCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setShopModel:(ShopDataModel *)shopModel{
    self.imageView.image = LoadImageByName(shopModel.imageName);

    self.Title.text = shopModel.title;
}
-(void)setMyGoods:(GoodsModel *)myGoods{

//    self.imageView.image = LoadImageByName(myGoods.goodsImage);
    NSString * str = [NSString stringWithFormat:@"%@%@",BaseShopUrl,myGoods.goodsImage];
    NSURL * url = [NSURL URLWithString:str];
    [self.imageView sd_setImageWithURL:url placeholderImage:LoadImageByName(@"liwu_bangbangtang_03")];
    self.Title.text = myGoods.goodsTitle;
}
@end
