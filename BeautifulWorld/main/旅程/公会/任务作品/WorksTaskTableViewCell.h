//
//  WorksTaskTableViewCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/5/4.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorksTaskModel.h"
@interface WorksTaskTableViewCell : UICollectionViewCell
{
    
    UIImageView * imaShow;
    UIImageView * icon;
    UILabel * nameLab;
    UIButton * collectionBtn;
    UIButton * zanBtn;
//    UIButton * commentBtn;
    
    
}
@property (nonatomic,strong)WorksTaskModel * task;
@end
