//
//  BuyGoodsViewController.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/5/5.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyGoodsViewController : UIViewController
@property (strong,nonatomic)UITextField * TF;
@property(nonatomic,strong)UIButton * addButn;
@property(nonatomic,strong)UIButton * deleteButn;
@property (nonatomic,strong)UIImageView  * payStyle;
@property (nonatomic,strong)UILabel  * payCountLab;
@property (nonatomic,strong)UILabel  * payCount;

@property (nonatomic,copy)NSString * maxCount;

@end
