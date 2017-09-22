//
//  StudyRankViewController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/6.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "StudyRankViewController.h"
#import "StudyRankTableViewCell.h"
#import "UserForDetailsController.h"//用户详情
@interface StudyRankViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * gradeArr; //文字数组
@property(nonatomic,strong)UITableView * myTable;
@property(nonatomic,strong)UIView * headView;
@property(nonatomic,strong)UIImageView * picShow;//顶部图片
@property(nonatomic,strong)UIButton * userIcon; //头像
@end

@implementation StudyRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self initTableView];
    // Do any additional setup after loading the view.
}
-(void)initTableView{
    _myTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _myTable.delegate =self;
    _myTable.dataSource =self;
    [self.view addSubview:_myTable];
    
    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 40)];
    header.backgroundColor = [UIColor whiteColor];
    _myTable.tableHeaderView = header;
    
    UIImageView * time = [[UIImageView alloc]init];
    time.frame = CGRectMake(kScreen_Width/4, 12, 16,16);
    time.image = LoadImageByName(@"time_03");
    [header addSubview:time];
    
    UILabel * timeLab = [[UILabel alloc]init];
    timeLab.frame = CGRectMake(time.x+20, 10, kScreen_Width/2, 20);
    timeLab.text = @"2017.04.17 - 2017.04.23";
    timeLab.textColor = [UIColor darkGrayColor];
    [header addSubview:timeLab];
    
}
-(void)loadData{
    _dataArray = [[NSMutableArray alloc]init];
//    NSArray * iconArr = @[@"head_wu_03",@"head_xi_03",@"head_xin_03",@"head_yang_03",@"head_yue_03",@"head_xi_03",@"head_wei_03"];
    NSArray * nameArr =@[@"舞",@"韫",@"玥",@"玺",@"鑫",@"蔚",@"殇"];
    NSArray * style2 = @[@"shuifen_03",@"sumiao_03",@"suxie_03"];
    NSArray * style3 = @[@"shuifen_03",@"sumiao_03"];
    
    NSArray * styleArr = @[style3,style2,style3,style2,style3,style3,style2];
    NSArray * sex =@[@"girl_03",@"girl_03",@"boy_03",@"girl_03",@"boy_03",@"girl_03",@"boy_03"];

    for (NSInteger i = 0; i< nameArr.count; i++) {
        StudyRankModel * model = [[StudyRankModel alloc]init];
        model.personName = nameArr[i];
        model.personIcon = @"head_wu_04";
        model.grade = @"12";
        model.sex  = sex[i];
        model.styleArr = styleArr[i];
        [_dataArray addObject:model];
    }
    
    _gradeArr = [NSMutableArray arrayWithObjects:@"1_03",@"2_03",@"3_03", nil];
                 
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StudyRankTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[StudyRankTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        
    }
    cell.rankModel = _dataArray[indexPath.row];
    if (indexPath.row < 3) {
        cell.rankIma.hidden = NO;
        cell.rankLab.hidden = YES;
        cell.rankIma.image  = LoadImageByName(_gradeArr[indexPath.row]);
        
    }else{
        cell.rankIma.hidden = YES;
        cell.rankLab.hidden = NO;
        cell.rankLab.text =[NSString stringWithFormat:@"%ld",indexPath.row+1];
       
        
    }
    cell.tag = indexPath.row;
    //[cell initRankIma];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
          return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    _headView = [[UIView alloc]init];
    _headView.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height/10);
    _headView.backgroundColor = RGBColor(241, 241, 242);
    UILabel * rank = [[UILabel alloc]init];
    rank.frame = CGRectMake(10,( CGRectGetHeight(_headView.frame)-20)/2, 20, 20);
    rank.text = @"10";
    rank.font = font15;
    [_headView addSubview:rank];
    
    UIImageView * icon = [[UIImageView alloc]init];
    icon.frame = CGRectMake(40, 8, CGRectGetHeight(_headView.frame)-16, CGRectGetHeight(_headView.frame)-16);
    icon.image = LoadImageByName(@"head_01_03");
    [_headView addSubview:icon];
    
    UILabel * meLab = [[UILabel alloc]init];
    meLab.frame = CGRectMake(icon.x+CGRectGetHeight(icon.frame)+10, rank.y, 40, 20);
    meLab.font = font15;
    meLab.text = @"我";
    [_headView addSubview:meLab];
  
    
       return _headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreen_Height/10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UserForDetailsController * user = [[UserForDetailsController alloc]init];
    [self.navigationController pushViewController:user animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kScreen_Height/10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
