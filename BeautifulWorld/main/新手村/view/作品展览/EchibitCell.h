//
//  EchibitCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/31.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExhibitModel.h"
@interface EchibitCell : UICollectionViewCell
{
    //发布图片
    UIImageView * imaShow;
    UILabel * timeLab;
    UILabel * collectionLab;
    UILabel * worksLab;
    
}
@property (nonatomic,strong)ExhibitModel * exhibit;

@end
