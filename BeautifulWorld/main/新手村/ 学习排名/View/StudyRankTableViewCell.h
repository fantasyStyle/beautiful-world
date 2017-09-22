//
//  StudyRankTableViewCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/6.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudyRankModel.h"
@interface StudyRankTableViewCell : UITableViewCell
{
    
    UIImageView * iconIma;
    UIImageView * sexIma;
    UILabel * nameLab;
    UIImageView * styleIma;
    UILabel * gradeLab;
}
@property (nonatomic,strong)StudyRankModel * rankModel;
@property (nonatomic,strong)UIImageView * rankIma;
@property (nonatomic,strong)UILabel * rankLab;
-(void)initRankIma;
-(void)initRankLab;
@end
