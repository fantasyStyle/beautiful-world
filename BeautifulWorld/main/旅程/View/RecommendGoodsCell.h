//
//  RecommendGoodsCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/2/23.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"
@protocol TapJorneyDelegate <NSObject>

-(void)TapJourneyCell;
-(void)TapTradeCell;

@end
@interface RecommendGoodsCell : UITableViewCell
{
    UIImageView * goodsIma1;
    UIImageView * goodsIma2;

}
@property (nonatomic,strong) UIView * sectionView;
@property (nonatomic,strong)RecommendModel * myGoodsModel;
@property (nonatomic,strong)id<TapJorneyDelegate>jCellTapDelegate;
@end
