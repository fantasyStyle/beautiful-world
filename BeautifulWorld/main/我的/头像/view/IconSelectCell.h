//
//  IconSelectCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/15.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconModel.h"
@interface IconSelectCell : UICollectionViewCell
{
    UIImageView * iconShow;
    
    
}

@property (nonatomic,strong)IconModel * userIcon;
@end
