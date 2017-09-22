//
//  CommunityLiveCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/29.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityLiveModel.h"
@interface CommunityLiveCell : UITableViewCell
{
    UIImageView * imaShow;
    UILabel * NameLab;
    UIImageView * sexIma;
    UIImageView * styleIma1;
    UIImageView * styleIma2;
    UIImageView * styleIma3;

    UILabel * contentLab;
}
@property (nonatomic,strong)CommunityLiveModel * liveModel;
@end
