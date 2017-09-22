//
//  PlanCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/2/21.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol makeFormulateDelegate <NSObject>
-(void)makeFormulate;
@end
@interface PlanCell : UITableViewCell{
    UILabel * planLab;
    UILabel * YNLab;//显示是否有学习计划
    UIImageView * spirit;//精灵
    UIImageView * frameView;//对话框
}
@property (nonatomic,strong)id<makeFormulateDelegate>delegate;
@end
