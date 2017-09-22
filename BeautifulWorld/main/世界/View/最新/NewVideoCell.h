//
//  NewVideoCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/29.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewVideoModel.h"
@interface NewVideoCell : UITableViewCell
{
    UIImageView * headIcon;
    UILabel * nameLab;
    UIImageView * sexIma;
    UILabel * interoduceLab;
    UIImageView * newIma;
    UIImageView * videoIma;
    UIButton * visitBtn;
    UIButton * zanBtn;
    UIButton * jfBtn;

}
@property (nonatomic,strong)NewVideoModel * video;
@end
