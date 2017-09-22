//
//  HappyGardenCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/1.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HappyGardenModel.h"
@interface HappyGardenCell : UITableViewCell{
    UIImageView * imaShow;
}
@property (nonatomic,strong)HappyGardenModel * gardenModel;
@end
