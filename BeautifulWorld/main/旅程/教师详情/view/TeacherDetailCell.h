//
//  TeacherDetailCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/7.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeacherDetailModel.h"
@interface TeacherDetailCell : UITableViewCell
{
    UIImageView * imaShow;
    UILabel * NameLab;
    UILabel * introduceLab;

}
@property (nonatomic,strong)TeacherDetailModel * course;
@end
