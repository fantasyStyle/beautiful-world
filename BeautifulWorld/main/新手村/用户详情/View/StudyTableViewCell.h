//
//  StudyTableViewCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/7.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudyStateModel.h"
@interface StudyTableViewCell : UITableViewCell
{
    UILabel * progressLab;
    UILabel * timeLab;
    UILabel * YNFinishLab;
    
    UIButton * zanBtn;
}
@property (nonatomic,strong)StudyStateModel * studyState;
@end
