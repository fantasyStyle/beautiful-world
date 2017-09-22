//
//  MineActivityController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/5/5.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "MineActivityController.h"
#import "HappyDetailViewController.h"//详情
@interface MineActivityController ()

@end

@implementation MineActivityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(235, 235, 241);
    [FTShowMessageView showStatusWithMessage:@"Loading..."];
    [self creatData];
    
    //
    if ([[UserInfo sharedUserInfo].isTeacher isEqualToString:@"0"]) {
        self.navigationItem.title = @"我参加的活动";
    }
    else{
        self.navigationItem.title = @"我发布的活动";
    }
    // Do any additional setup after loading the view.
}
-(void)creatData{
    
    _dataArr = [[NSMutableArray alloc]init];
    _datailArr = [[NSMutableArray alloc]init];
    _introArr = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:[UserInfo sharedUserInfo].user_id forKey:@"user_id"];
    [params setValue:self.activityType forKey:@"unique"];


    [[HttpClient shareInstance] requestApiWithurl:@"attendActivity"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        
        
        [FTShowMessageView dismiss];
        
        id dic = [response objectForKey:@"result"];
        NSLog(@"我发布的活动%@",dic);
        if (dic == [NSNull null]) {
            [HUD showAlertWithTitle:@"暂无作品"];
        }
        else{
            for (NSMutableDictionary * subDic in dic) {
                [_dataArr addObject:[NSString stringWithFormat:@"%@",subDic[@"name"]]];
                NSString * state = [NSString stringWithFormat:@"%@",subDic[@"state"]];
                if ([state isEqualToString:@"0"] ) {
                    [_datailArr addObject:@"未开始"];
                }
                if ([state isEqualToString:@"1"] ) {
                    [_datailArr addObject:@"进行中"];
                }
                if ([state isEqualToString:@"2"] ) {
                    [_datailArr addObject:@"已结束"];
                }
                [_introArr addObject:[NSString stringWithFormat:@"%@",subDic[@"introduce"]]];
                
                [_tableView reloadData];
                
                
            }
            [self creatUITableView];

        }
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        [FTShowMessageView dismiss];
        
        
    }];
    

}
#pragma mark - 创建表格视图
-(void)creatUITableView{
    _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _tableView.contentInset = UIEdgeInsetsMake(-StatusBar_Height, 0, Tabbar_Height+NavBar_Height+StatusBar_Height, 0) ;
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID = @"mineActCell";
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    
    cell.textLabel.text=_dataArr[indexPath.row];
    cell.detailTextLabel.text=_datailArr[indexPath.row];
    cell.textLabel.textColor=[UIColor darkGrayColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreen_Height/12;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HappyDetailViewController * happy = [[HappyDetailViewController alloc]init];
    happy.introUrl = self.introArr[indexPath.row];
    [self.navigationController pushViewController:happy animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
