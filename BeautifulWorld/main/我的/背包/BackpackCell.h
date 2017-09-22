//
//  BackpackCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/21.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackpackModel.h"
@interface BackpackCell : UICollectionViewCell
{
    UIImageView * packIma;
    UIImageView * headIma;
}
@property (nonatomic,strong)BackpackModel * backModel;
@end
