//
//  CustMarketCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/30.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustMarketModel.h"
@protocol TapmarketDelegate <NSObject>
-(void)tapBuyMarket;
-(void)tapSellMarket;
@end
@interface CustMarketCell : UITableViewCell
{
    UIImageView * imaShow1;
    UIImageView * imaShow2;
}
@property (nonatomic,strong)CustMarketModel * market;
@property (nonatomic,strong)id<TapmarketDelegate>marketDelegate;
@end
