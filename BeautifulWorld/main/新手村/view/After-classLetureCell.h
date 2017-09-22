//
//  After-classLetureCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/1.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassLectureModel.h"
@interface After_classLetureCell : UITableViewCell
{
    UIImageView * _classShow;
    UILabel * _classNameLab;//用户名
    UILabel * _classDetailLab;//关注按钮
}
@property (nonatomic,strong)ClassLectureModel * myClass;
@end
