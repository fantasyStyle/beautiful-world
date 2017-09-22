//
//  TeacherSceneryCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/7.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeacherSceneryModel.h"
@interface TeacherSceneryCell : UICollectionViewCell
{
    UIImageView * _picShow;
    UILabel * _timeLab;
    UILabel * _titleLab;
}
@property (nonatomic,strong)TeacherSceneryModel * teacherModel;
@property (nonatomic,strong)UIImageView * suoIma;
@end
