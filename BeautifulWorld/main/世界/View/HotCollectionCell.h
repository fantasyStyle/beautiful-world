//
//  HotCollectionCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/2/24.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotModel.h"
@interface HotCollectionCell : UICollectionViewCell
{
    UIImageView * _picShow;
    UILabel * _worksLabel;//作品
    UILabel * _authorLabel;//作者
    UILabel * _priceLabel;//价格
    
}
@property(nonatomic,strong)HotModel * myHotModel;

@end
