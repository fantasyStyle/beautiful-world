//
//  BalanceViewController.m
//  NewWorld
//
//  Created by fantasy  on 2017/2/16.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "BalanceViewController.h"

@interface BalanceViewController ()

@end

@implementation BalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(236, 236, 239);
    // Do any additional setup after loading the view.
    [self initBalanceView];
}
-(void)initBalanceView{
    UIImageView * MoneyIma = [[UIImageView alloc]init];
    MoneyIma.frame = CGRectMake(kScreen_Width/7*3, kScreen_Width/6, kScreen_Width/7, kScreen_Width/7);
    MoneyIma.image = LoadImageByName(@"余额");
    [self.view addSubview:MoneyIma];
    
    UILabel * moneyLab =[[UILabel alloc]init];
    moneyLab.frame = CGRectMake(kScreen_Width/3, kScreen_Width/3, kScreen_Width/3, 40);
   // NSString * str = [NSString stringWithFormat:@"¥ %@",@"13.14"];
    moneyLab.text = @"¥ 13.14";
    moneyLab.font = [UIFont systemFontOfSize:30];
    moneyLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:moneyLab];
    
    UIButton * moneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moneyBtn.frame = CGRectMake(kScreen_Width/8, kScreen_Width/2, kScreen_Width/4*3, kScreen_Height/15) ;
    moneyBtn.layer.masksToBounds = YES;
    moneyBtn.layer.cornerRadius = 8;
    moneyBtn.backgroundColor = RGBColor(40, 163, 33);
    [moneyBtn setTitle:@"充值" forState:UIControlStateNormal];
    [self.view addSubview:moneyBtn];
    
    //账单明细
    UIButton * detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    detailBtn.frame = CGRectMake(kScreen_Width/12*5, moneyBtn.y+kScreen_Height/15+10, kScreen_Width/6, 20);
    [detailBtn setTitle:@"账单明细" forState:UIControlStateNormal];
    detailBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [detailBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.view addSubview:detailBtn];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
