//
//  FamousTeacherController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/14.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "FamousTeacherController.h"
#import "FamousTeacherCell.h"
#import "TeacherSceneryController.h"//教师风采
#import "ApprenticeView.h"
@interface FamousTeacherController ()<UITableViewDelegate,UITableViewDataSource>{
    ApprenticeView * apprentice;
    UIView *backgroundView;
    int page;
    BOOL ismore;
}
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UITableView * myTab;

@end

@implementation FamousTeacherController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"教师风采";
    self.view.backgroundColor = RGBColor(235, 235, 241);
    [FTShowMessageView showStatusWithMessage:@"Loading..."];
   
     _dataArr = [[NSMutableArray alloc]init];
    [self creatTable];

   // [self loadData];
    //[self creatTable];
    // Do any additional setup after loading the view.
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr  = [[NSMutableArray alloc]init];
        
    }
    return _dataArr;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    page = 1;
    ismore = NO;
    if (self.dataArr.count !=0) {
        [self.dataArr removeAllObjects];
    }

     [self loadData];
}
-(void)loadData{
   

    NSArray * style1 = @[@"dongman_03",@"shuifen_03"];
    NSArray * style2 = @[@"shuifen_03",@"sumiao_03"];
    NSArray * styleArr = @[style1,style2,style1];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:@([@"10" intValue]) forKey:@"limit"];
    [params setValue:[UserInfo sharedUserInfo].user_id forKey:@"user_id"];
    [params setValue:@"time desc" forKey:@"order"];
    if (ismore == YES) {
        page++;
        
        
        NSLog(@"上啦页数%d",page);
        [params setValue:@(page) forKey:@"page"];
    }else{
        [params setValue:@([@"1" intValue]) forKey:@"page"];
    }

    [params setValue:@([@"教师" intValue]) forKey:@"unique"];
    
    
    [[HttpClient shareInstance] requestApiWithurl:@"teachers"  parmar:params success:^(NSURLSessionDataTask *task, id response) {

        [FTShowMessageView dismissSuccessView:@"Success"];
        
        
        id  dic = [response objectForKey:@"result"];
        if (dic == [NSNull null]) {
            if (page >1) {
                [_myTab.mj_footer endRefreshing];
                [HUD showAlertWithTitle:@"没有更多数据了"];
            }else{
                [HUD showAlertWithTitle:@"暂无数据了"];
            }
        }else{
            NSLog(@"碰撞名师的%@",dic);
            for (NSMutableDictionary * subDic in dic) {
                FamousTeacherModel * model = [[FamousTeacherModel alloc]init];
                model.imaName = subDic[@"img"];
                model.name = subDic[@"name"];
                model.age =[NSString stringWithFormat:@"%@", subDic[@"age"]];
                if ([subDic[@"sex"] isEqualToString:@"男"]) {
                    model.sex =@"boy_03";
                }else{
                    model.sex =@"girl_03";
                }
                //            NSLog(@"教师的性别为%@",subDic[@"sex"]);
                model.teacher_id= [NSString stringWithFormat:@"%@",subDic[@"id"]];
                model.YNAppretticed = subDic[@"judge"];
                model.school =subDic[@"school"];
                model.studentCount = subDic[@"student"];
//                model.styleArr = styleArr[0];
                [_dataArr addObject:model];
                
                
            }
            [_myTab reloadData];
            NSLog(@"碰撞名师的数组个数%ld",_dataArr.count);
            

        }

        
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"失败%@",response);
        
        [FTShowMessageView dismissErrorView:@"加载数据失败，请稍后重试"];
        
    }];

}
-(void)creatTable{
    _myTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - StatusBar_Height - NavBar_Height) style:UITableViewStyleGrouped];
    _myTab.dataSource = self;
    _myTab.delegate = self;
    [self.view addSubview:_myTab];
    
    //刷新
    [self refresh];
    
}
-(void)refresh{
    //刷新
    _myTab.mj_header = [FTRefreshGifHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [FTShowMessageView showStatusWithMessage:@"Loading..."];
            ismore =NO;
            if (self.dataArr.count !=0) {
                [self.dataArr removeAllObjects];
            }
            [self loadData];
            

            // 刷新表格
            [_myTab reloadData];

            dispatch_main_sync_safe(^{
                [FTShowMessageView dismissSuccessView:@"Success"];
            });
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_myTab.mj_header endRefreshing];
            
        });
        
        
    }];
    
    _myTab.mj_footer = [FTRefreshGifFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            ismore = YES;
            [self loadData];
            // 刷新表格
            [_myTab reloadData];
            
            
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_myTab.mj_footer endRefreshing];
            
        });
        
    }];


}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID = @"famousTeacherCell";
    FamousTeacherCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[FamousTeacherCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.teacherModel = _dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.apprenticedBtn.tag = indexPath.row;
    [cell.apprenticedBtn addTarget:self action:@selector(apprenticeClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreen_Height/6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
 
        return 0.01;
}
-(void)apprenticeClick:(UIButton *)sender{
    NSLog(@"点击的是%ld",sender.tag);
     apprentice =[[ApprenticeView alloc]init];
    
    backgroundView = [[UIView alloc] init];
    backgroundView.frame = CGRectMake(0, 0,kScreen_Width,kScreen_Height);
    backgroundView.backgroundColor  =  [[UIColor blackColor]colorWithAlphaComponent:0.4f];
    [self.view addSubview:backgroundView];
    [backgroundView addSubview:apprentice];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    FamousTeacherModel * model = _dataArr[sender.tag];
    [params setValue:[UserInfo sharedUserInfo].user_id forKey:@"user_id"];
    [params setValue:@([model.teacher_id intValue]) forKey:@"teacher"];
    
    
    [[HttpClient shareInstance] requestApiWithurl:@"baiShi"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"拜师成功%@",response);
        
        NSMutableDictionary * dic = [response objectForKey:@"result"];
       
        [sender removeFromSuperview];
        [_myTab reloadData];
        [apprentice removeFromSuperview];
        [backgroundView removeFromSuperview];

        
        
        
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"拜师失败%@",response);
        
        [FTShowMessageView dismissErrorView:@"加载数据失败，请稍后重试"];
        
    }];



}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TeacherSceneryController * teacher = [[TeacherSceneryController alloc]init];
    FamousTeacherModel * model = _dataArr[indexPath.row];
    teacher.teacher_id = model.teacher_id;
    teacher.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:teacher animated:YES];
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
