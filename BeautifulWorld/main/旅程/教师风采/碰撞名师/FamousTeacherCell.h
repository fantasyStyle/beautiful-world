//
//  FamousTeacherCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/14.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FamousTeacherModel.h"
@interface FamousTeacherCell : UITableViewCell
{
    UIImageView * headIma;
    UILabel * nameLab;
    UIImageView * sexIma;
    UILabel * ageLab;
    UILabel * schoolLab;
    UILabel * studentLab;
    UIImageView * styleIma;
}
@property (nonatomic,strong)UIButton * apprenticedBtn;
@property (nonatomic,strong)FamousTeacherModel * teacherModel;

@end
