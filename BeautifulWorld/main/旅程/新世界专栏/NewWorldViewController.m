//
//  NewWorldViewController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/8.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "NewWorldViewController.h"
#import "NewWorldCell.h"
@interface NewWorldViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UIView * headView;
}
@property (nonatomic,strong)UITableView * WorldNewTab;
@property (nonatomic,strong)NSMutableArray * dataArr;
@end

@implementation NewWorldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataSource];
    [self initTabView];
    // Do any additional setup after loading the view.
}
-(NSMutableArray*)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
                }
    return _dataArr;
}
-(void)loadDataSource{
    _dataArr = [NSMutableArray array];
    for (NSInteger i =0; i<6; i++) {
        NewWorldModel * model = [[NewWorldModel alloc]init];
        NSString * ima = [NSString stringWithFormat:@"%ld.jpg",i];
        model.imaName = ima;
        model.imaTitle = @"周日有画展周日有画展周日画展周日有画展";
        model.zanCount = @"2";
        model.commentCount =@"4";
        [_dataArr addObject:model];
        
    }

}
-(void)initTabView{
    _WorldNewTab = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _WorldNewTab.delegate =self;
    _WorldNewTab.dataSource =self;
    [self.view addSubview:_WorldNewTab];
    
    headView = [[UIView alloc]init];
    headView.frame =CGRectMake(0, 0, kScreen_Height, kHeight);
    headView.backgroundColor = [UIColor whiteColor];
    _WorldNewTab.tableHeaderView = headView;
    
    UIImageView * ima = [[UIImageView alloc]init];
    ima.frame = headView.bounds;
    ima.image  = LoadImageByName(@"3.jpg");
    [headView addSubview:ima];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"worldCell";
    NewWorldCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NewWorldCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.myNewModel = _dataArr[indexPath.row];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreen_Height/8;
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
