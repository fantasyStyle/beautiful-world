//
//  TradeAllianceController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/13.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "TradeAllianceController.h"
#import "AllianceTableViewCell.h"
#import "CreatTradeController.h"//创建公会
#import "TradeDetailViewController.h"//公会详情
@interface TradeAllianceController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *dataArr;
//数组
@property (nonatomic,strong)NSMutableArray * detailArr;
@property (nonatomic,strong)UITableView * myTab;
@end

@implementation TradeAllianceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 35, 35);
    [rightBtn addTarget:self action:@selector(onIssue) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:LoadImageByName(@"chuangjiangonghui_03") forState:UIControlStateNormal];
    UIBarButtonItem * helpBar = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem =helpBar;

    [self loadData];
    [self creatTable];
    // Do any additional setup after loading the view.
}
-(void)onIssue{
    CreatTradeController * creatTrade = [[CreatTradeController alloc]init];
    [self.navigationController pushViewController:creatTrade animated:YES];
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr  = [[NSMutableArray alloc]init];
        
    }
    return _dataArr;
}
-(void)loadData{
    _dataArr = [[NSMutableArray alloc]init];
    NSArray * imaArr = @[@"renwu_01_03",@"renwu_02_03",@"renwu_03_03",@"renwu_04_03",@"renwu_05_03"];
    NSArray * titieArr = @[@"色彩联盟",@"大神联盟",@"线条联盟",@"大神联盟",@"线条联盟"];
    NSArray * timeArr = @[@"2016.12.14",@"2017.01.11",@"2017.01.18",@"2017.01.30",@"2017.03.12"];
    
    NSArray * style1 = @[@"dongman_03",@"shuifen_03",@"sumiao_03",@"suxie_03"];
    NSArray * style2 = @[@"shuifen_03",@"sumiao_03",@"suxie_03"];
    NSArray * style3 = @[@"shuifen_03",@"sumiao_03"];
    
    NSArray * styleArr = @[style1,style2,style3,style1,style3];
    
    NSArray * horArr = @[@"2",@"3",@"2",@"2",@"3"];
    for (int i = 0; i<5; i++) {
        AllianceModel * model = [[AllianceModel alloc]init];
        model.tradeIma = imaArr[i];
        model.tradeTitle = titieArr[i];
        model.tradeTime = timeArr[i];
        model.styleArr = styleArr[i];
        model.hotRate = [horArr[i] intValue];
        model.visitCount = @"259";
        [_dataArr addObject:model];
    }
}
-(NSMutableArray *)detailArr{
    if (!_detailArr) {
        _detailArr = [[NSMutableArray alloc]init];
    }
    return _detailArr;
}
-(void)creatTable{
    _myTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - StatusBar_Height - NavBar_Height) style:UITableViewStyleGrouped];
    _myTab.dataSource = self;
    _myTab.delegate = self;
    [self.view addSubview:_myTab];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
        
    }
    else{
        return 2;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID = @"allianceCell";
    AllianceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[AllianceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (indexPath.section == 0) {
        cell.myAlliance = _dataArr[indexPath.row];
        cell.joinLab.hidden = YES;
       
    }
    else{
        cell.myAlliance = _dataArr[indexPath.row + 3];
        cell.joinLab.hidden = NO;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreen_Height/5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else{
        return 30;

    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
       UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 30)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel * lab = [[UILabel alloc]init];
    lab.frame = CGRectMake(20, 5, kScreen_Width/3, 20);
    lab.text = @"推荐公会";
    lab.font = font15;
    [view addSubview:lab];
    
    if (section == 0) {
        return nil;
    }
    else{
        return view;
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TradeDetailViewController * detail = [[TradeDetailViewController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
    
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
