//
//  HotCollectionCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/2/24.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "HotCollectionCell.h"
#define cellH    (kScreen_Width-15)/2
@implementation HotCollectionCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self creatCell];
    }
    return self;

}
-(void)creatCell{
    //图片
    _picShow = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,cellH, cellH/2)];
    [self.contentView addSubview:_picShow];
    
    //作品
    _worksLabel =[[UILabel alloc]initWithFrame:CGRectMake(5, cellH/2+5, cellH, 18)];
    _worksLabel.font = [UIFont systemFontOfSize:12];
    _worksLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_worksLabel];

    //作者
    _authorLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, _worksLabel.y +18, cellH, 18)];
    _authorLabel.font = [UIFont systemFontOfSize:12];
    _authorLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_authorLabel];
    //价格
    _priceLabel =[[UILabel alloc]initWithFrame:CGRectMake(5, _authorLabel.y +18, cellH, 18)];
    _priceLabel.font = [UIFont systemFontOfSize:12];
    _priceLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_priceLabel];

    
    
}
-(void)setMyHotModel:(HotModel *)myHotModel{
    [_picShow setImage:LoadImageByName(myHotModel.cover)];
    _worksLabel.text =[NSString stringWithFormat:@"作品名：%@", myHotModel.works];
    _authorLabel.text =[NSString stringWithFormat:@"作者：%@", myHotModel.author];
    _priceLabel.text = [NSString stringWithFormat:@"地区：%@", myHotModel.price];
}
@end
