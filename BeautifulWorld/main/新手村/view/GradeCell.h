//
//  GradeCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/2/21.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GradeModel.h"
@protocol TapRankDelegate <NSObject>

-(void)TapRankCellDelegate;

@end

@interface GradeCell : UITableViewCell{
    UILabel * gradeLab;//等级
    UILabel * learnLab;//学习任务
    UILabel * haveNoLearn;//未完成任务
    UILabel * rankLab;//排名

    
}
@property (nonatomic,strong)GradeModel * myGrade;
@property (nonatomic,strong)id<TapRankDelegate>rankDelegate;
@end
