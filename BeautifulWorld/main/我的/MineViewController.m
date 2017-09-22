//
//  MineViewController.m
//  NewWorld
//
//  Created by fantasy  on 2017/2/7.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "MineViewController.h"
#import "SettingViewController.h"//设置
#import "HonourViewController.h"//个人荣

//菜单导航工具
#import "ERNavViewController.h"
#import "BalanceViewController.h"//余额
#import "FansViewController.h"//粉丝
#import "AttentionViewController.h"//关注
#import "VisitViewController.h"//来访
#import "FeedBackViewController.h"//意见反馈
#import "AboutUSController.h"//关于我们
#import "BuyRecordController.h"//交易记录
#import "ResourceBuyController.h"//购买的资源
#import "IconForUserController.h"//头像选择
#import "PersonInfoViewController.h"//个人详情
#import "BackpackViewController.h"//背包
#import "MineActivityController.h"//活动
#import "BuyRecordViewCell.h"//更多商品

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate,SavePerInfoDelegate>{
       NSString * myIcon;
    NSMutableArray *countArr;
    
    UIButton * selectBtn;//四个图标分类
}



@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(onRight)];
    self.navigationItem.rightBarButtonItem =right;
[FTShowMessageView showStatusWithMessage:@"Loading..."];
//    
     //[self creatData];
    [self creatUITableView];
}

-(void)onRight{
    PersonInfoViewController * info = [[PersonInfoViewController alloc]init];
    [self.navigationController pushViewController:info animated:YES];
}

-(void)onMessage:(UIButton *)sender{

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self.myTable removeFromSuperview];
    [self creatUITableView];

}

-(void)creatData{

    if ([[UserInfo sharedUserInfo].isTeacher isEqualToString:@"0"]) {
         _dataArray=[NSMutableArray arrayWithObjects:@"背包",@"我参加的活动",@"关于我们",@"意见反馈",@"设置", nil];
    }else{
        _dataArray=[NSMutableArray arrayWithObjects:@"背包",@"我发布的活动",@"关于我们",@"意见反馈",@"设置", nil];
    }
   
    
}
#pragma mark - 创建表格视图
-(void)creatUITableView{
    _myTable = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _myTable.contentInset = UIEdgeInsetsMake(0, 0, Tabbar_Height+NavBar_Height+StatusBar_Height, 0) ;
   
    _myTable.delegate = self;
    _myTable.dataSource = self;
    _headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/5*2)];
    _headView.backgroundColor = [UIColor whiteColor];
    _myTable.tableHeaderView = _headView;
    
    //顶部图片
    _picShow = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, _headView.frame.size.height/4*3)];
    _picShow.image = [UIImage imageNamed:@"bg_head_02"];
    [_headView addSubview:_picShow];
    
  
    //头像
    _userIcon = [[UIImageView alloc]init];
    _userIcon.contentMode = UIViewContentModeScaleAspectFit;
//    [_userIcon setBackgroundImage:LoadImageByName(@"head_06") forState:UIControlStateNormal];
    [_userIcon setFrame:CGRectMake(kScreen_Width/75*26, CGRectGetHeight(_picShow.frame)/420*135, kScreen_Width/75*23, kScreen_Width/75*23)];
//
//    if ([UserInfo sharedUserInfo].iconUser) {
//        [_userIcon setBackgroundImage:LoadImageByName([UserInfo sharedUserInfo].iconUser) forState:UIControlStateNormal];
//
//    }
//    if (myIcon) {
//        [_userIcon setBackgroundImage:[UIImage imageNamed:myIcon] forState:UIControlStateNormal];
//    }

//    [_userIcon addTarget:self action:@selector(iconBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_picShow addSubview:_userIcon];

    //昵称
    _nameLab= [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_picShow.frame)-30 , kScreen_Width/2, 20)];
    _nameLab.textAlignment = NSTextAlignmentCenter;
    _nameLab.textColor=[UIColor darkGrayColor];
    _nameLab.text = @"玥";
    [_picShow addSubview:_nameLab];
    
    UILabel * grade =[[UILabel alloc]init];
    grade.frame = CGRectMake(kScreen_Width/2, _nameLab.y, kScreen_Width/2, 20);
    grade.textAlignment = NSTextAlignmentCenter;
    grade.textColor = [UIColor darkGrayColor];
    grade.text = @"等级：28级";
    [_picShow addSubview:grade];
    
    

    
    //分割线
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _headView.frame.size.height/4*3+1, kScreen_Width, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.alpha = 0.5;
    [_headView addSubview:lineView];
    
    
    
    //四个选项
    NSArray * titleArr = @[@"粉丝",@"关注",@"访客"];
    //NSMutableArray * countArr =[NSMutableArray arrayWithObjects:@"126",@"154",@"34",nil];
    countArr = [[NSMutableArray alloc]init];
    CGFloat margin = 3;
    CGFloat danW = (kScreen_Width - margin*3)/3;
    
   
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
   
    [params setValue:[UserInfo sharedUserInfo].user_id forKey:@"user_id"];

    
    
    [[HttpClient shareInstance] requestApiWithurl:@"personHome"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        
        
        NSMutableDictionary * dic = [response objectForKey:@"result"];
        NSLog(@"个人信息%@",dic);
//        for (NSMutableDictionary * subDic in dic) {
        if (dic[@"fans"]) {
            [countArr addObject:[NSString stringWithFormat:@"%@",dic[@"fans"]]];
            [countArr addObject:[NSString stringWithFormat:@"%@",dic[@"attention"]]];
            [countArr addObject:[NSString stringWithFormat:@"%@",dic[@"caller"]]];

        }
        [UserInfo sharedUserInfo].iconUser = dic[@"img"];
        NSString * str = [NSString stringWithFormat:@"%@%@",BaseShopUrl,dic[@"img"]];
        [_userIcon sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:LoadImageByName(@"head_06")];
      
        
            _nameLab.text = [NSString stringWithFormat:@"%@",dic[@"name"]];
            grade.text = [NSString stringWithFormat:@"等级：%@",dic[@"rank"]];
            if ([[NSString stringWithFormat:@"等级：%@",dic[@"unique"]] isEqualToString:@"老师"]) {
                [UserInfo sharedUserInfo].isTeacher =@"1";
            }else{
                [UserInfo sharedUserInfo].isTeacher =@"0";
            }
            
            [_myTable reloadData];
            
//        }
        for (NSInteger i = 0; i < 3; i++) {
            selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            selectBtn.frame = CGRectMake((danW+margin)*i, _headView.frame.size.height/4*3+5,danW , _headView.frame.size.height/3-5);
            
            //按钮分割线
            UIImageView * line = [[UIImageView alloc]initWithFrame:CGRectMake((danW+margin)*(i+1) , _headView.frame.size.height/4*3+10, 1, _headView.frame.size.height/6)];
            line.image = LoadImageByName(@"line_04");
            [_headView addSubview:line];
            //文字说明
            UILabel * btnLab = [[UILabel alloc]init];
            btnLab.frame = CGRectMake(0, 5,danW , (_headView.frame.size.height/4-5)/5*2);
            btnLab.text = titleArr[i];
            btnLab.textColor = [UIColor darkGrayColor];
            btnLab.textAlignment = NSTextAlignmentCenter;
            //数量显示
            UILabel * countLab = [[UILabel alloc]init];
            countLab.frame = CGRectMake(0, (_headView.frame.size.height/3-5)/5, danW, (_headView.frame.size.height/3-5)/5*3);
            countLab.textAlignment = NSTextAlignmentCenter;
            countLab.textColor = RGBColor(0, 154, 222);
            if (countArr.count>0) {
                countLab.text = countArr[i];

            }else{
                countLab.text = 0;
            }
                       [selectBtn addSubview:countLab];
            [selectBtn addSubview:btnLab];
            selectBtn.tag = i+100;
            [selectBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_headView addSubview:selectBtn];
        }
             [FTShowMessageView dismiss];
             [self creatData];
              [self.view addSubview:_myTable];
        

        NSLog(@"个人欣%@",countArr);
        
      NSLog(@"个人信息%@",dic);
        
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"个人信息失败%@",response);
        
        [FTShowMessageView dismissErrorView:@"加载数据失败，请稍后重试"];
        
    }];
    

    
  

    
}
-(void)onClickSaveWithHeadIcon:(NSString *)imaIcon{
    myIcon =imaIcon;
    [_myTable removeFromSuperview];
    [self creatUITableView];
}
-(void)btnClick:(UIButton *)sender{
    NSLog(@"点击了按钮第%ld个",(long)sender.tag);
    switch (sender.tag) {
        case 100:{
            BalanceViewController * balance = [[BalanceViewController alloc]init];
            balance.hidesBottomBarWhenPushed = YES;
            balance.navigationItem.title = @"余额";
           // [self.navigationController pushViewController:balance animated:YES];

        }
            
            break;
        case 101:{
            FansViewController * fans = [[FansViewController alloc]init];
            fans.hidesBottomBarWhenPushed = YES;
            fans.navigationItem.title = @"粉丝";
           // [self.navigationController pushViewController:fans animated:YES];

        }
            
            break;
        case 102:{
            AttentionViewController * attention = [[AttentionViewController alloc]init];
            attention.hidesBottomBarWhenPushed = YES;
            attention.navigationItem.title = @"关注";
           // [self.navigationController pushViewController:attention animated:YES];

        }
            break;
        case 103:{
            VisitViewController * visit = [[VisitViewController alloc]init];
            visit.hidesBottomBarWhenPushed = YES;
            visit.navigationItem.title = @"来访";
            //[self.navigationController pushViewController:visit animated:YES];

        }
      
            break;
        
        default:
            break;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID = @"myCell";
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
  
    
    cell.textLabel.text=_dataArray[indexPath.row];
    cell.textLabel.textColor=[UIColor darkGrayColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreen_Height/12;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        BackpackViewController * pack = [[BackpackViewController alloc]init];
        [self.navigationController pushViewController:pack animated:YES];
    }
    if (indexPath.row == 1) {
        MineActivityController * act = [[MineActivityController alloc]init];
        act.hidesBottomBarWhenPushed = YES;
        if ([[UserInfo sharedUserInfo].isTeacher isEqualToString:@"0"]) {
            act.activityType = @"学生";
        }else{
            act.activityType = @"教师";
        }
        [self.navigationController pushViewController:act animated:YES];
    }
    if (indexPath.row == 2) {
        AboutUSController * us = [[AboutUSController alloc]init];
        us.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:us animated:YES];
    }
    if (indexPath.row == 3) {
       
        FeedBackViewController * feed = [[FeedBackViewController alloc]init];
        feed.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:feed animated:YES];
        

    }
    if (indexPath.row == 4) {
        
        SettingViewController * setting = [[SettingViewController alloc]init];
        setting.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setting animated:YES];
        

         }
    
}
-(void)iconBtnClick
{
    IconForUserController * selectIcon = [[IconForUserController alloc]init];
    selectIcon.saveInfoDelegate = self;
    [self.navigationController pushViewController:selectIcon animated:YES];
    
    
}
@end
