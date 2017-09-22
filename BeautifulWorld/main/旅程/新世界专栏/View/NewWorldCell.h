//
//  NewWorldCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/8.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewWorldModel.h"
@interface NewWorldCell : UITableViewCell{
    UIImageView * imaShow;
    UILabel * imaTitleLab;
    UILabel * zanLab;
    UILabel * commentLab;
    UIButton * zanbtn;
    
}
@property (nonatomic,strong)NewWorldModel* myNewModel;
@end
