//
//  DrawWorldViewController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/5/2.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "DrawWorldViewController.h"
#import "DrawTableViewCell.h"
#import "NewVideoCell.h"
#import "ReUserModel.h"
#import "ExhibitWorksController.h"
#import "OutVideoPlayViewController.h"
#import "TeacherSceneryController.h"
#import "OutVideoPlayViewController.h"
#import "CustHeadViewCell.h"

@interface DrawWorldViewController ()<UITableViewDelegate,UITableViewDataSource,tapDrawClickDelegate>
{
    NSMutableArray * _userArray;
    NSMutableArray * _shopArray;
    CustHeadViewCell * jHeadView;
}
@property (nonatomic,strong)UITableView * tableView;
@end

@implementation DrawWorldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [FTShowMessageView showStatusWithMessage:@"Loading..."];

    [self loadUserData];
    [self loadShopData];
 
    
    // Do any additional setup after loading the view.
}

-(void)loadUserData{
    _userArray = [[NSMutableArray alloc]init];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
          [params setValue:@([@"10" intValue]) forKey:@"limit"];
        [[HttpClient shareInstance] requestApiWithurl:@"drawing"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
             [FTShowMessageView dismiss];
          [self initTableView];
            NSMutableArray * dic = [response objectForKey:@"result"];
            NSLog(@"推荐用户的%@",dic);
            for (NSMutableDictionary * subDic in dic) {
    
                ReUserModel * user = [[ReUserModel alloc]init];
//                user.icon =@"yonghu_01_03";
                user.icon = subDic[@"img"];
                user.user_ID = subDic[@"id"];
                user.userName = subDic[@"name"];
                user.grade = subDic[@"rank"];
                user.user_ID = subDic[@"id"];
                [_userArray addObject:user];
                
                
                
                [_tableView reloadData];
    
            }
        } failuer:^(NSURLSessionDataTask *task, id response) {
            NSLog(@"推荐用户失败%@",response);
    
        }];
    
    
}
-(void)loadShopData{
    
    _shopArray = [[NSMutableArray alloc]init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
   // [params setValue:@([@"10" intValue]) forKey:@"limit"];
    
    [[HttpClient shareInstance] requestApiWithurl:@"newVideo"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        [FTShowMessageView dismiss];
        
        NSMutableArray * dic = [response objectForKey:@"result"];
        NSLog(@"最新视频的%@",dic);
        for (NSMutableDictionary * subDic in dic) {
            
            NSLog(@"最新视频的性别%@",subDic[@"sex"]);
            
            NewVideoModel * model = [[NewVideoModel alloc]init];
            model.icon = subDic[@"img"];
            model.video_id = subDic[@"id"];
            model.author =[NSString stringWithFormat:@"%@",subDic[@"name"]] ;
            NSString * sex =[NSString stringWithFormat:@"%@",subDic[@"sex"]];
        
            if ([sex isEqualToString:@"男"]) {
                model.sex = @"boy_03";
            }else{
                model.sex = @"girl_03";
            }
            model.introduce = subDic[@"explain"];
            model.imaName = subDic[@"picture"];
            model.visitCount =subDic[@"browse"];
            model.jfCount =subDic[@"score"] ;
            model.zanCount = subDic[@"praise"];
            [_shopArray addObject:model];

            
            
            
            
            [_tableView reloadData];
            
            
            
        }
        
        NSLog(@"最新视频的数组%@",_shopArray);
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"最新视频的失败%@",response);
        
    }];
    
}

-(void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-NavBar_Height-StatusBar_Height) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate =self;
    
    //_tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    //刷新
    _tableView.mj_header = [FTRefreshGifHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [FTShowMessageView showStatusWithMessage:@"Loading..."];
            // 刷新表格
            // [myTable reloadData];
            dispatch_main_sync_safe(^{
                [FTShowMessageView dismissSuccessView:@"Success"];
            });
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_tableView.mj_header endRefreshing];
            
        });
        
        
    }];
    _tableView.mj_footer = [FTRefreshGifFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 刷新表格
            // [myTable reloadData];
            [FTShowMessageView showStatusWithMessage:@"Loading..."];
            
            dispatch_main_sync_safe(^{
                [FTShowMessageView dismissSuccessView:@"Success"];
            });
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_tableView.mj_footer endRefreshing];
        });
        
        
    }];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 1;
    }
    else{
        return _shopArray.count;

        
    }
    }
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return kScreen_Height/6;
    }else{
        return kScreen_Height/5*2;
    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section ==1) {
        NewVideoModel * model = _shopArray[indexPath.row];
        OutVideoPlayViewController * video =[[OutVideoPlayViewController alloc]init];
        video.hidesBottomBarWhenPushed = YES;
        video.videoID = model.video_id;
        [self.navigationController pushViewController:video animated:YES];
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * drawCellID = @"drawCellID";
    DrawTableViewCell * drawCell = [tableView dequeueReusableCellWithIdentifier:drawCellID];
    if (!drawCell) {
        drawCell = [[DrawTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:drawCellID];
        
    }
    drawCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //视频
    NewVideoCell * videoCell = [tableView dequeueReusableCellWithIdentifier:@"video"];
    if (!videoCell) {
        videoCell = [[NewVideoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"video"];
        
    }
    videoCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if (indexPath.section ==0) {
        drawCell.classModelArray = _userArray;
        drawCell.drawDelegate = self;
        return drawCell;
    }else{
        videoCell.video =_shopArray[indexPath.row];
        return videoCell;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    jHeadView = [[CustHeadViewCell alloc]init];
    
    if (section == 0) {
        return nil;
    }
    else{
        jHeadView.backIma.backgroundColor = RGBColor(223, 0, 0);
        jHeadView.iconIma.image= LoadImageByName(@"zhiboshequ_03");
        jHeadView.headTitle.text = @"热门视频";
        jHeadView.headTitle.textColor = lightTextColor;
        jHeadView.moreTitle.hidden = YES;
        return jHeadView;
        

    }
    
  
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return 0.01;
    }else{
         return kScreen_Height/18;
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
#pragma mark - 推荐用户
-(void)tapDraw:(ReUserModel *)route andIntag:(NSInteger)tag{
    ReUserModel * model = _userArray[tag];
    ExhibitWorksController * detail = [[ExhibitWorksController alloc]init];
    //detail.teacher_id = model.user_ID;
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
