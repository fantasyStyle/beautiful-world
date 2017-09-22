//
//  RecommendUsersController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/15.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "RecommendUsersController.h"
#import "RecommendUsersCell.h"
#import "UserForDetailsController.h"
@interface RecommendUsersController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic,strong)UITableView * myTab;
@end

@implementation RecommendUsersController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self creatTable];
    
    // Do any additional setup after loading the view.
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}
-(void)loadData{
    RecommendUsersModel * model = [[RecommendUsersModel alloc]init];
    model.iconName = @"用户1";
    model.name = @"陈奕迅";
    model.reccommend = @"QQ音乐推荐";
    model.ima1 = @"活动1";
    model.ima2 = @"活动2";
    model.ima3 = @"活动3";
    [self.dataArr addObject:model];
    RecommendUsersModel * model1 = [[RecommendUsersModel alloc]init];
    model1.iconName = @"用户2";
    model1.name = @"陈小春";
    model1.reccommend = @"QQ音乐推荐";
    model1.ima1 = @"活动4";
    model1.ima2 = @"活动5";
    model1.ima3 = @"WechatIMG33";
    [self.dataArr addObject:model1];

    RecommendUsersModel * model2 = [[RecommendUsersModel alloc]init];
    model2.iconName = @"用户1";
    model2.name = @"陈晓东";
    model2.reccommend = @"QQ音乐推荐";
    model2.ima1 = @"活动1";
    model2.ima2 = @"活动2";
    model2.ima3 = @"活动3";
    [self.dataArr addObject:model2];

}
-(void)creatTable{
    _myTab  = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _myTab.dataSource = self;
    _myTab.delegate = self;
    [self.view addSubview:_myTab];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellId = @"cellUsers";
    RecommendUsersCell * userCell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!userCell) {
        userCell = [[RecommendUsersCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    userCell.usersModel = self.dataArr[indexPath.row];
    userCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return userCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreen_Height/7*2;
}
- (void)didReceiveMemoryWarning {
 
[super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UserForDetailsController * user = [[UserForDetailsController alloc]init];
    [self.navigationController pushViewController:user animated:YES];
}
@end
