//
//  RecommendUserCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/2/24.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReUserModel.h"
@interface RecommendUserCell : UICollectionViewCell
{
    UIImageView * _iconShow;
    UILabel * _userName;//用户名
    UILabel * _gradeLab;//等级
    UIButton * _attentionBtn;//关注按钮
 
    
}
@property (nonatomic,strong)ReUserModel * reUserModel;
@end
