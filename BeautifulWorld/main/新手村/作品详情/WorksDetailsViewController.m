//
//  WorksDetailsViewController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/5/2.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "WorksDetailsViewController.h"
#import "WorksDetailsCell.h"
@interface WorksDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * myTab;
@property (nonatomic,strong)NSMutableArray * dataArr;
@end

@implementation WorksDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"作品详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [FTShowMessageView showStatusWithMessage:@"Loading..."];
    [self loadData];

    // Do any additional setup after loading the view.
}
-(void)loadData{
    _dataArr = [[NSMutableArray alloc]init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
   
    [params setValue:self.works_id forKey:@"id"];
    
    [[HttpClient shareInstance] requestApiWithurl:@"worlksInfo"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        id dic = [response objectForKey:@"result"];
        NSLog(@"作品详情的%@",dic);
        if (dic == [NSNull null]) {
            [FTShowMessageView dismiss];
            [HUD showAlertWithTitle:@"暂无详情"];

        }else{
            [FTShowMessageView dismiss];
            WorksDetailsModel * model = [[WorksDetailsModel alloc]init];
            model.iconName =[NSString stringWithFormat:@"%@",dic[@"userpicture"]];
            
            model.name =[NSString stringWithFormat:@"%@",dic[@"name"]] ;
            model.time =[NSString stringWithFormat:@"%@",dic[@"time"]] ;
            model.introduce = [NSString stringWithFormat:@"%@",dic[@"imgname"]];
            
            model.imaName = [NSString stringWithFormat:@"%@",dic[@"picture"]];;
            [_dataArr addObject:model];
            [FTShowMessageView dismiss];
            [self creatTable];

        }
              } failuer:^(NSURLSessionDataTask *task, id response) {
        [FTShowMessageView dismiss];
               
    }];

}
-(void)creatTable{
    _myTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-NavBar_Height-StatusBar_Height) style:UITableViewStyleGrouped];
    _myTab.delegate = self;
    _myTab.dataSource = self;
    [self.view addSubview:_myTab];
    UIView * head = [[UIView alloc]init];
    head.frame = CGRectMake(0, 0, kScreen_Width, 40);
    head.backgroundColor = [UIColor whiteColor];
    UILabel * lab = [[UILabel alloc]init];
    lab.frame = CGRectMake(15, 10, kScreen_Width-20, 20);
    lab.text = @"公会：色彩联盟";
    lab.textColor = [UIColor darkGrayColor];
    lab.font = font14;
    [head addSubview:lab];
    
    if (_isShowHeadView == YES) {
        _myTab.tableHeaderView = head;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return kScreen_Height/5*3;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorksDetailsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"works"];
    if (!cell) {
        cell = [[WorksDetailsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"works"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.works = _dataArr[0];
    return cell;
}


@end
