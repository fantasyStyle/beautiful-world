//
//  TradeDetailViewController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/14.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "TradeDetailViewController.h"
#import "TradeDetailCell.h"
#import "TradeMemberViewController.h"
#import "WorksTaskController.h"//任务详情
#import "IssueGrowViewController.h"//发布
@interface TradeDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic,strong)UITableView * myTab;
@end

@implementation TradeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(235, 235, 241);
    [self loadData];
    [self initView];
    // Do any additional setup after loading the view.
}
-(void)loadData{
    _dataArr = [[NSMutableArray alloc]init];
    TradeDetailModel * model1 = [[TradeDetailModel alloc]init];
    model1.imaName = @"head_04";
    model1.name = @"李爱娴老师";
    model1.title = @"以【花鸟】为主题作画一幅";
    model1.demand = @"注重表现基本的技法技巧";
    model1.time = @"2017.03.01 - 2017.03.15";
    [_dataArr addObject:model1];
    
    TradeDetailModel * model2 = [[TradeDetailModel alloc]init];
    model2.imaName = @"head_04";
    model2.name = @"李爱娴老师";
    model2.title = @"以水墨画的表现方法作画一幅，题材不限";
    model2.demand = @"注重表现基本的技法技巧";
    model2.time = @"2017.04.08 - 2017.04.20";
    [_dataArr addObject:model2];

}
-(void)initView{

    _myTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-NavBar_Height - StatusBar_Height-60) style:UITableViewStyleGrouped];
    _myTab.dataSource = self;
    _myTab.delegate =self;
    [self.view addSubview:_myTab];
    _myTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIImageView * topIma = [[UIImageView alloc]init];
    topIma.image = LoadImageByName(@"xinxi_02");
    topIma.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height/5);
    [topIma addTapTraget:self withAction:@selector(enterMember)];
    _myTab.tableHeaderView = topIma;
    
    
    UIButton * submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(20, kScreen_Height-NavBar_Height-StatusBar_Height-60, kScreen_Width-40, 40);
    submitBtn.backgroundColor = RGBColor(50, 158, 224);
    UIImageView * ima = [[UIImageView alloc]init];
    ima.frame = CGRectMake(submitBtn.frame.size.width/3, 13, 14, 14);
    ima.image = LoadImageByName(@"fabu_03");
    [submitBtn addSubview:ima];
    [submitBtn setTitle:@"发布任务" forState:UIControlStateNormal];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 10;
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(issueClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];

    
    
    
}
-(void)enterMember{
    TradeMemberViewController * member = [[TradeMemberViewController alloc]init];
    [self.navigationController pushViewController:member animated:YES];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionP{
    return 1;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreen_Height/5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID = @"tradeDetailCell";
    TradeDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[TradeDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.tradeDetail = _dataArr[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel * timeLab  = [[UILabel alloc]init];
    timeLab.frame = CGRectMake(kScreen_Width/8*3, 8, kScreen_Width/4, 24);
    timeLab.backgroundColor = [UIColor grayColor];
    timeLab.text = @"2017.03.18";
    timeLab.textAlignment = NSTextAlignmentCenter;
    timeLab.layer.masksToBounds = YES;
    timeLab.layer.cornerRadius = 5;
    timeLab.font = font15;
    timeLab.textColor = [UIColor whiteColor];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 40)];
    [view addSubview:timeLab];
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WorksTaskController * task = [[WorksTaskController alloc]init];
    [self.navigationController pushViewController:task animated:YES];
}
-(void)issueClick{
    IssueGrowViewController * issue = [[IssueGrowViewController alloc]init];
    [self.navigationController pushViewController:issue animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
