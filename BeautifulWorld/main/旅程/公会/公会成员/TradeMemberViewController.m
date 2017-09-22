//
//  TradeMemberViewController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/14.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "TradeMemberViewController.h"
#import "TradeMemberCell.h"
@interface TradeMemberViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic,strong)UITableView * myTab;
@end

@implementation TradeMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self creatTable];
    // Do any additional setup after loading the view.
}
-(void)loadData{
    _dataArr = [[NSMutableArray alloc]init];
    NSArray * iconArr = @[@"head_01_03",@"head_wu_03",@"head_xi_03",@"head_xin_03",@"head_yang_03",@"head_yue_03",@"head_xi_03",@"head_wei_03"];
    NSArray * nameArr =@[@"张爱娴",@"舞",@"韫",@"玥",@"玺",@"鑫",@"蔚",@"殇"];
    NSArray * style2 = @[@"shuifen_03",@"sumiao_03",@"suxie_03"];
    NSArray * style3 = @[@"shuifen_03",@"sumiao_03"];
    
    NSArray * styleArr = @[style3,style2,style3,style2,style3,style3,style2,style3];
    NSArray * focusArr =@[@"yiguanzhu_03",@"guanzhu_05",@"guanzhu_05",@"guanzhu_05",@"guanzhu_05",@"guanzhu_05",@"yiguanzhu_03",@"guanzhu_05"];
    NSArray * sex =@[@"girl_03",@"girl_03",@"boy_03",@"girl_03",@"boy_03",@"girl_03",@"boy_03",@"girl_03"];
    
    for (int i = 0; i<iconArr.count; i++) {
        TradeMemberModel * model  = [[TradeMemberModel alloc]init];
        model.memberIcon = iconArr[i];
        model.sex  = sex[i];
        model.name = nameArr[i];
        model.styleArr = styleArr[i];
        model.YNFocus = focusArr[i];
        [_dataArr addObject:model];
    }

}
-(void)creatTable{
    _myTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height- NavBar_Height - StatusBar_Height) style:UITableViewStyleGrouped];
    _myTab.dataSource = self;
    _myTab.delegate =self;
    [self.view addSubview:_myTab];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID = @"memberCell";
    TradeMemberCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[TradeMemberCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    if (indexPath.row  == 0) {
           cell.cellTag = 0;
    }else{
        cell.cellTag = 1;
    }
//    else{
//        cell.creater = NO;
//    }
    cell.memberModel= _dataArr[indexPath.row];
   // cell.cellTag = indexPath.row;
     cell.creater = YES;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreen_Height/12;
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
