//
//  PayStyleViewController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/15.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "PayStyleViewController.h"

@interface PayStyleViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    //文字数组
    NSMutableArray *_dataArray;
    
    //图片数组
    NSMutableArray *_picImaArray;
    //脚视图
    UIView * footView;
    //表视图
    UITableView * myTable;
    
    
    
    
}



@end

@implementation PayStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatData];
    [self creatUITableView];
    // Do any additional setup after loading the view.
}
-(void)creatData{
    _dataArray = [[NSMutableArray alloc]init];
    
    _dataArray=[NSMutableArray arrayWithObjects:@"微信支付",@"支付宝支付", nil];
    _picImaArray = [NSMutableArray arrayWithObjects:@"ico_weixin",@"ico_zhifubao", nil];
    
    
}
#pragma mark -创建表格视图
-(void)creatUITableView{
    myTable =[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:myTable];
    myTable.delegate=self;
    myTable.dataSource=self;
//    myTable.backgroundColor=RGBColor(244, 251, 255);
    
    UIView * headView = [[UIView alloc]init];
    headView.backgroundColor  = [UIColor whiteColor];
    headView.frame = CGRectMake( 0, 0, kScreen_Width, 30);
    myTable.tableHeaderView = headView;
    
    _moneyLab = [[UILabel alloc]init];
    _moneyLab.frame = CGRectMake(5, 5, kScreen_Width/3, 20);
    _moneyLab.textColor = [UIColor redColor];
    _moneyLab.font = font13;
    [headView addSubview:_moneyLab];
    
    
    
    [self addFootViewCust];
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    
    static NSString  *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
    }
    

            cell.imageView.image = LoadImageByName([_picImaArray objectAtIndex:row]);
            cell.textLabel.text = [_dataArray objectAtIndex:row];
    
 
    
    return cell;
}

#pragma mark - 添加脚视图
-(void)addFootViewCust{
    footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/2)];
    myTable.tableFooterView = footView;
    
    //支付按钮
    UIButton * registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setFrame:CGRectMake(10, 40, kScreen_Width-20, kScreen_Height/15)];
//    [registerBtn setBackgroundImage:LoadImageByName(@"按钮") forState:UIControlStateNormal];
    registerBtn.backgroundColor = [UIColor greenColor];
    [registerBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    registerBtn.layer.masksToBounds = YES;
    registerBtn.layer.cornerRadius = 5;
    [footView addSubview:registerBtn];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
