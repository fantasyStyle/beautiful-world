//
//  HappyIslandViewController.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/12.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HappyIslandViewController : UIViewController{
    BOOL isSelected;
}
@property (nonatomic,strong)UIButton * btn1;
@property (nonatomic,strong)UIButton * btn2;
@property (nonatomic,strong)UIButton * selectedBtn;
@property (nonatomic,copy)NSString * happy_Pid;
@property (nonatomic,copy)NSString * activityUrl;
@property (nonatomic,copy)NSString * introUrl;
@property (nonatomic,copy)NSString * titleName;
@property (nonatomic,copy)NSString * payFee;
@end
