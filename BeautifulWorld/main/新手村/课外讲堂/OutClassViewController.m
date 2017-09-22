//
//  OutClassViewController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/21.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "OutClassViewController.h"
#import "ClassLectureModel.h"
#import "After-classLetureCell.h"

#import "OutVideoPlayViewController.h"//视频播放
@interface OutClassViewController ()<UITableViewDelegate,UITableViewDataSource>{
    int page;
    BOOL ismore;
}
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)UITableView * myTable;
@end

@implementation OutClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(235, 235, 241);
    self.navigationItem.title  =@"全部视频";
     [FTShowMessageView showStatusWithMessage:@"Loading..."];
    _dataArray = [NSMutableArray array];
    page = 1;
    ismore = NO;
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
    
    [params setValue:@([@"10" intValue]) forKey:@"limit"];
    if (ismore == YES) {
        page++;


        NSLog(@"上啦页数%d",page);
        [params setValue:@(page) forKey:@"page"];
    }else{
         [params setValue:@([@"1" intValue]) forKey:@"page"];
    }
   
    if (self.videoAllID) {
        [params setValue:@([self.videoAllID intValue]) forKey:@"type_id"];
    }
    [[HttpClient shareInstance] requestApiWithurl:@"schoolAll"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
       [FTShowMessageView dismiss];
        
        id dic = [response objectForKey:@"result"];
        NSLog(@"光明学堂的%@",dic);
       
        if (dic == [NSNull null]) {
            if (page >1) {
                [_myTable.mj_footer endRefreshing];
                [HUD showAlertWithTitle:@"没有更多数据了"];
            }else{
                 [HUD showAlertWithTitle:@"暂无数据了"];
            }
            

        }else{
            for (NSMutableDictionary * subDic in dic) {
                ClassLectureModel * class = [[ClassLectureModel alloc]init];
                class.classIma =[NSString stringWithFormat:@"%@%@",relateVideoUrl,subDic[@"picture"]];
                class.class_id = subDic[@"id"];
                class.className = subDic[@"name"];
                class.classDetail = subDic[@"numbers"];
                class.teacherName = subDic[@"teachername"];
                
              
                [_dataArray addObject:class];
                
                
            }
            [_myTable reloadData];

        }
        
                     NSLog(@"%ld",_dataArray.count);
        //[HUD showAlertWithTitle:@"登录成功"];
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"失败%@",response);
          [FTShowMessageView dismissErrorView:@"加载数据失败，请稍后重试"];
        
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
    
            ismore =NO;
            if (self.dataArray.count !=0) {
                [self.dataArray removeAllObjects];
            }
            [self loadData];
          
            // 刷新表格
            [_myTable reloadData];
   
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_myTable.mj_header endRefreshing];
            
        });
        
        
    }];
    _myTable.mj_footer = [FTRefreshGifFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
 
            ismore = YES;
            [self loadData];
            // 刷新表格
            [_myTable reloadData];
     


            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_myTable.mj_footer endRefreshing];
      
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
    OutVideoPlayViewController * play = [[OutVideoPlayViewController alloc]init];
    play.hidesBottomBarWhenPushed  = YES;
    play.videoID = class.class_id;

    [self.navigationController pushViewController:play animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
