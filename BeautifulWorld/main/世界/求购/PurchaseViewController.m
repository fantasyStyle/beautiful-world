//
//  PurchaseViewController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/5/4.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "PurchaseViewController.h"
#import "PurchaseTableViewCell.h"
@interface PurchaseViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation PurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"求购";
    [FTShowMessageView showStatusWithMessage:@"Loading..."];
    self.view.backgroundColor = RGBColor(235, 235, 241);
    [self loadData];
    self.view.backgroundColor = [UIColor whiteColor];
   
    // Do any additional setup after loading the view.
}
#pragma mark - 懒加载
-(NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _dataArr;
}
-(void)createUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - Tabbar_Height-NavBar_Height - StatusBar_Height)];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:@"PurchaseTableViewCell" bundle:nil] forCellReuseIdentifier:@"PurchaseTableViewCell"];
  
    [self.view addSubview:_tableView];
    
    UIView * headView =[[UIView alloc]init];
    headView.backgroundColor = RGBColor(50, 158, 224);
    headView.frame = CGRectMake(0, 0, kScreen_Width, 50);
  //  _tableView.tableHeaderView = headView;
    
    UIImageView * notify = [[UIImageView alloc]init];
    notify.frame = CGRectMake(20, 10, 70, 31);
    notify.image =LoadImageByName(@"tongzhi_03");
    [headView addSubview:notify];
    
    UILabel * notifyLab = [[UILabel alloc]init];
    notifyLab.frame = CGRectMake(100, 15, kScreen_Width-100, 20);
    notifyLab.textColor = [UIColor whiteColor];
    notifyLab.font = font15;
    notifyLab.text = @"用户馨于2017.04.26完成交易";
    [headView addSubview:notifyLab];
}
#pragma mark - 加载数据
-(void)loadData{

    
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
       //顶部
    [[HttpClient shareInstance] requestApiWithurl:@"askInfo"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        id  dic = [response objectForKey:@"result"];
         [FTShowMessageView dismiss];
        NSLog(@"求购信息的的%@",dic);
        for (NSMutableDictionary * subdic in dic) {
            PurchaseModel * comment1 = [[PurchaseModel alloc]init];
            comment1.icon = subdic[@"head"];
            comment1.title = subdic[@"name"];
            comment1.date = subdic[@"time"];
            comment1.detail = subdic[@"content"];
            comment1.phoneNumber = subdic[@"phone"];
            
            [self.dataArr addObject:comment1];
            [_tableView reloadData];

        }
        [self createUI];
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        [FTShowMessageView dismiss];
//        failView = [[LoadFailView alloc]init];
//        [failView.retryBtn addTarget:self action:@selector(retry) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:failView];
//        
        
    }];

}
#pragma mark - tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
            return self.dataArr.count;
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    PurchaseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PurchaseTableViewCell" forIndexPath:indexPath];
    [cell setContents:self.dataArr[indexPath.row]];
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PurchaseTableViewCell cellHeight:self.dataArr[indexPath.row ]];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
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
