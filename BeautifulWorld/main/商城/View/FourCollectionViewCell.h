//
//  FourCollectionViewCell.h
//  NewWorld
//
//  Created by fantasy  on 2017/2/9.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDataModel.h"
#import "GoodsModel.h"
@interface FourCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)ShopDataModel * shopModel;
@property (nonatomic,strong)GoodsModel * myGoods;
@end
