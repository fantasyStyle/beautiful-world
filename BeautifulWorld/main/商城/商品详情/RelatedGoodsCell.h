//
//  RelatedGoodsCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/16.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RelatedGoodsModel.h"
@interface RelatedGoodsCell : UITableViewCell
{
    UIImageView * goodsIma1;
    UIImageView * goodsIma2;
    UIImageView * goodsIma3;
    
}
@property (nonatomic,strong)RelatedGoodsModel * relatedGoods;
@end
