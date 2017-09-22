//
//  OutDoorViewController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/3.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "OutDoorViewController.h"
#import "ClassLectureModel.h"
#import "After-classLetureCell.h"
#import "OutClassViewController.h"
@interface OutDoorViewController ()<UITableViewDelegate,UITableViewDataSource>{
  
}
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)UITableView * myTable;

@end

@implementation OutDoorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(235, 235, 241);
    self.navigationItem.title  =@"全部视频";
    [FTShowMessageView showStatusWithMessage:@"Loading..."];
    _dataArray = [NSMutableArray array];
    [self loadData];
    [self creatTable];
    
    // Do any additional setup after loading the view.
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}
-(void)loadData{
    
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:@([@"3" intValue]) forKey:@"limit"];
    
    [params setValue:@"1,2,3"  forKey:@"grade"];
    
    [[HttpClient shareInstance] requestApiWithurl:@"school"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"成功%@",response);

        
        
        NSMutableDictionary * dic = [response objectForKey:@"result"];
        NSLog(@"光明学堂的%@",dic);
        for (NSMutableDictionary * subDic in dic) {
            ClassLectureModel * class = [[ClassLectureModel alloc]init];
            class.classIma =[NSString stringWithFormat:@"%@%@",BaseImaUrl,subDic[@"picture"]];
            class.class_id = subDic[@"id"];
            class.className = subDic[@"name"];
            class.classDetail = subDic[@"count"];
            [_dataArray addObject:class];
            [_myTable reloadData];
            
        }
        
        
        [self loadData2];
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"失败%@",response);
        [FTShowMessageView dismiss];
        
        //[FTShowMessageView dismissErrorView:@"加载数据失败，请稍后重试"];
        
    }];
    
    
}
-(void)loadData2{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:@([@"3" intValue]) forKey:@"limit"];
    
    [params setValue:@"4,5,6"  forKey:@"grade"];
    
    [[HttpClient shareInstance] requestApiWithurl:@"school"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"成功%@",response);

        
        
        NSMutableDictionary * dic = [response objectForKey:@"result"];
        NSLog(@"光明学堂的%@",dic);
        for (NSMutableDictionary * subDic in dic) {
            ClassLectureModel * class = [[ClassLectureModel alloc]init];
            class.classIma =[NSString stringWithFormat:@"%@%@",BaseImaUrl,subDic[@"picture"]];
            class.class_id = subDic[@"id"];
            class.className = subDic[@"name"];
            class.classDetail = subDic[@"count"];
            [_dataArray addObject:class];
            [_myTable reloadData];
            
        }
        
        
        [self loadData3];
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"失败%@",response);
        [FTShowMessageView dismiss];
        
        //[FTShowMessageView dismissErrorView:@"加载数据失败，请稍后重试"];
        
    }];

}
-(void)loadData3{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:@([@"3" intValue]) forKey:@"limit"];
    
    [params setValue:@"7,8,9"  forKey:@"grade"];
    
    [[HttpClient shareInstance] requestApiWithurl:@"school"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"成功%@",response);
        [FTShowMessageView dismissSuccessView:@"Success"];
        
        
        NSMutableDictionary * dic = [response objectForKey:@"result"];
        NSLog(@"光明学堂的%@",dic);
        for (NSMutableDictionary * subDic in dic) {
            ClassLectureModel * class = [[ClassLectureModel alloc]init];
            class.classIma =[NSString stringWithFormat:@"%@%@",BaseImaUrl,subDic[@"picture"]];
            class.class_id = subDic[@"id"];
            class.className = subDic[@"name"];
            class.classDetail = subDic[@"count"];
            [_dataArray addObject:class];
            [_myTable reloadData];
            
        }
        
        
        
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"失败%@",response);
        [FTShowMessageView dismiss];
        
        //[FTShowMessageView dismissErrorView:@"加载数据失败，请稍后重试"];
        
    }];
    
}


-(void)creatTable{
    _myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-NavBar_Height-StatusBar_Height) style:UITableViewStyleGrouped];
    _myTable.dataSource = self;
    _myTable.delegate = self;
    [self.view addSubview:_myTable];
    
    //刷新
    _myTable.mj_header = [FTRefreshGifHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            // 刷新表格
            [_myTable reloadData];
            
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_myTable.mj_header endRefreshing];
            
        });
        
        
    }];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID  = @"outClassCell";
    After_classLetureCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[After_classLetureCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.myClass = self.dataArray[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreen_Height/8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 2;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ClassLectureModel * class = _dataArray[indexPath.section];
    OutClassViewController * classAll = [[OutClassViewController alloc]init];
    classAll.videoAllID = class.class_id;
    classAll.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:classAll animated:YES];

  
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
