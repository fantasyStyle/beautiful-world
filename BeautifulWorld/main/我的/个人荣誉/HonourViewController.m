//
//  HonourViewController.m
//  NewWorld
//
//  Created by fantasy  on 2017/2/14.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "HonourViewController.h"

@interface HonourViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray * arr;
  
}
@property (nonatomic,strong)UITableView * myTable;
@property (nonatomic,strong)  NSMutableArray * detailArr;


@end

@implementation HonourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatDataSouse];
    [self initTable];
    // Do any additional setup after loading the view.
}
-(NSMutableArray *)arr{
    if (arr == nil) {
        arr = [NSMutableArray arrayWithCapacity:0];
    }
    return arr;
}
-(NSMutableArray *)detailArr{
    if (!_detailArr) {
        _detailArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _detailArr;
}
-(void)creatDataSouse{
    
    arr = [NSMutableArray arrayWithObjects:@"今日成就",@"本周排名",@"本月排名", nil];
    _detailArr = [NSMutableArray arrayWithObjects:@"第三名",@"第五名",@"第七名", nil];
}
-(void)initTable{
    _myTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _myTable.dataSource = self;
    _myTable.delegate = self;
    [self.view addSubview:_myTable];
    
    
    
    UIView * headView = [[UIView alloc]init];
    headView.frame =CGRectMake(0, 0, kScreen_Width, kScreen_Height/8);
    headView.backgroundColor =[UIColor whiteColor];
    _myTable.tableHeaderView = headView;
    
    UIImageView * icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, kScreen_Width/8, kScreen_Width/8)];
    icon.image = LoadImageByName(@"用户2");
    [headView addSubview:icon];
    
    
    UILabel * name = [[UILabel alloc]init];
    name.frame = CGRectMake(20+kScreen_Width/8, 12, kScreen_Width/3, 20);
    name.text = @"朱军";
    name.font  = font14;
    [headView addSubview:name];
    
    UILabel * grade = [[UILabel alloc]initWithFrame:CGRectMake(name.x, 35, 100, 20)];
    grade.textColor = [UIColor redColor];
    grade.text = @"28级";
    grade.font = font13;
    [headView addSubview:grade];
    
    UILabel * detail = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width/2, 30, kScreen_Width/2, 20)];
    detail.text = @"西安美术学院学生";
    detail.textAlignment = NSTextAlignmentRight;
    detail.font = font13;
    [headView addSubview:detail];
    
    
    UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/8)];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, kScreen_Width, 20)];
    label.textColor = BlueTitileColor;
    label.font = font14;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"您的进步很大，请再接再厉";
    [footView addSubview:label];
    _myTable.tableFooterView = footView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1  reuseIdentifier:cellID];
    }
    cell.textLabel.text = arr[indexPath.row];
    cell.detailTextLabel.text = self.detailArr[indexPath.row];
    cell.detailTextLabel.textColor = [UIColor redColor];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreen_Height/15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
