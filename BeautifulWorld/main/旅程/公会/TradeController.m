//
//  TradeController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/8.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "TradeController.h"
#import "IssueGrowViewController.h"
#import "CreatTradeController.h"
@interface TradeController ()

@end

@implementation TradeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTradeView];
    // Do any additional setup after loading the view.
}
-(void)initTradeView{
    
    //商品
    CGFloat margin = kScreen_Width/6;
    CGFloat marginM = kScreen_Width/10;//两个图片的间隙
    CGFloat KWIma = (kScreen_Width-margin*2-marginM)/2;//图片单个直径
    //商品1
    mineTrade = [[UIImageView alloc]init];
    mineTrade.frame = CGRectMake(margin, 20, KWIma, KWIma);
    mineTrade.tag = 1;
    [mineTrade addTapTraget:self withAction:@selector(onTap:)];
    mineTrade.layer.masksToBounds = YES;
    mineTrade.layer.cornerRadius = KWIma/2;
    mineTrade.image = LoadImageByName(@"0.jpg");
    [self.view addSubview:mineTrade];
    
    tradeLab = [[UILabel alloc]init];
    tradeLab.frame = CGRectMake(margin, mineTrade.y+KWIma+5, KWIma, 20);
    tradeLab.textAlignment = NSTextAlignmentCenter;
    tradeLab.textColor = [UIColor darkGrayColor];
    tradeLab.font = [UIFont systemFontOfSize:14];
    tradeLab.text = @"创建公会";
    [self.view addSubview:tradeLab];
    
    //商品2
    issueIma = [[UIImageView alloc]init];
    issueIma.frame = CGRectMake(margin+KWIma+marginM, 20, KWIma, KWIma);
    issueIma.tag =2;
    [issueIma addTapTraget:self withAction:@selector(onTap:)];
    issueIma.image = LoadImageByName(@"1.jpg");
    issueIma.layer.masksToBounds = YES;
    issueIma.layer.cornerRadius = KWIma/2;
    [self.view addSubview:issueIma];
    
    issueLab = [[UILabel alloc]init];
    issueLab.frame = CGRectMake(issueIma.x, issueIma.y+KWIma+5, KWIma, 20);
    issueLab.textAlignment = NSTextAlignmentCenter;
    issueLab.textColor = [UIColor darkGrayColor];
    issueLab.text =  @"发布任务";
    issueLab.font =[UIFont systemFontOfSize:14];
    [self.view addSubview:issueLab];
    
    
    
}
-(void)onTap:(UIGestureRecognizer *)tap{
    if (tap.view.tag == 2) {
        IssueGrowViewController * issue = [[IssueGrowViewController alloc]init];
        [self.navigationController pushViewController:issue animated:YES];
    }else{
        NSLog(@"创建公会");
        CreatTradeController * trade =[[CreatTradeController alloc]init];
        [self.navigationController pushViewController:trade animated:YES];
    }
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
