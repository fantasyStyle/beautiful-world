//
//  ResourceBuyController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/17.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "ResourceBuyController.h"
#import "BuyGoodsViewController.h"
#import "ResourcesBuyTableViewCell.h"
#import "IntroduceResourceViewController.h"//购买说明
#import "ConvertGoldCoinViewController.h"//兑换金币
#import "BuyDetailIntroduceViewController.h"
@interface ResourceBuyController ()<UITableViewDelegate,UITableViewDataSource>{
    
}
@property (nonatomic,strong)UITableView * table;
@property (nonatomic,strong)NSMutableArray * dataArr;


@end

@implementation ResourceBuyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(235, 235, 241);
    [FTShowMessageView showStatusWithMessage:@"Loading..."];
    [self loadData];
    
    self.navigationItem.title = @"购买资源";
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithTitle:@"购买说明" style:UIBarButtonItemStylePlain target:self action:@selector(onRight)];
    self.navigationItem.rightBarButtonItem =right;

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}
-(void)loadData{
    _dataArr = [[NSMutableArray alloc]init];

    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    //顶部
    [[HttpClient shareInstance] requestApiWithurl:@"Myresource"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        id  dic = [response objectForKey:@"result"];
         [FTShowMessageView dismiss];
        NSLog(@"我的资源%@",dic);

               if (dic == [NSNull null]) {
            
        }else{
            NSMutableDictionary * subdic = dic[0];
            ResourcesBuyModel * model = [[ResourcesBuyModel alloc]init];
            model.count = subdic[@"jewel"];
            ResourcesBuyModel * model1 = [[ResourcesBuyModel alloc]init];
            model1.count = subdic[@"gold"];
            [UserInfo sharedUserInfo].userJewel =subdic[@"jewel"];
            [UserInfo sharedUserInfo].userGold =subdic[@"gold"];
            [[UserInfo sharedUserInfo]saveUserInofFromSanbox];
            [_dataArr addObject:model];
            [_dataArr addObject:model1];
            [_table reloadData];
            
            [self creatTable];


        }
          } failuer:^(NSURLSessionDataTask *task, id response) {
        [FTShowMessageView dismiss];
        
    }];

  }
-(void)creatTable{
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,kScreen_Width, kScreen_Height- StatusBar_Height - NavBar_Height) style:UITableViewStyleGrouped];
    _table.dataSource =self;
    _table.delegate = self;
    [self.view addSubview:_table];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(void)onRight{
    IntroduceResourceViewController * introduce = [[IntroduceResourceViewController alloc]init];
    [self.navigationController pushViewController:introduce animated:YES];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = @"resourcecell";
    ResourcesBuyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ResourcesBuyTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.buyModel = _dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        [cell.payBtn setTitle:@"购买" forState:UIControlStateNormal];
        [cell.payIcon setImage:LoadImageByName(@"zuan_04")];
    }else{
         [cell.payBtn setTitle:@"兑换" forState:UIControlStateNormal];
        [cell.payIcon setImage:LoadImageByName(@"jinbi_05")];
    }
    
       return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreen_Height/10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
      return 0.1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        BuyDetailIntroduceViewController * detail = [[BuyDetailIntroduceViewController alloc]init];
     [[HttpClient shareInstance] requestApiWithurl:@"getType" parmar:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable response) {
         NSLog(@"%@",response);
        
             
             detail.type  = response[@"type"];
             detail.content = response[@"text"];
//
         
        
         [self.navigationController pushViewController:detail animated:YES];
         
         
     } failuer:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable response) {
         
         
     }];
//        BuyGoodsViewController * buy = [[BuyGoodsViewController alloc]init];
//        //ResourcesBuyModel * model =self.dataArr[0];
//        buy.maxCount =@"10000";
//        NSLog(@"%@",buy.maxCount);
//       [self.navigationController pushViewController:buy animated:YES];
    }else{
        ResourcesBuyModel * model = _dataArr[0];
        ConvertGoldCoinViewController * convert = [[ConvertGoldCoinViewController alloc]init];
        convert.jewelCount = model.count;
        [self.navigationController pushViewController:convert animated:YES];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
