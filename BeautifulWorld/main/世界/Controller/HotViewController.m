//
//  HotViewController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/2/23.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "HotViewController.h"
#import "RecommendHeadView.h"
#import "HotGoodsTableCell.h"
#import "ReUserTableCell.h"
#import "HotModel.h"
#import "ReUserModel.h"
#import "SDCycleScrollView.h"
#import "CustJourHeadView.h"
#import "RecommendUsersController.h"//推荐用户展示
#import "UserForDetailsController.h"//用户详情
#import "CommunityLiveCell.h"//社区直播
#import "CustHeadViewCell.h"
#import "ActivityDetailController.h"
#import "CustMarketCell.h"//市场
#import "NewVideoCell.h"//新视频
#import "DrawWorldViewController.h"
#import "PurchaseViewController.h"//求购
#import "LoveViewController.h"//售卖
#import "ExhibitWorksController.h"//用户作品
#import "OutVideoPlayViewController.h"//播放视频
#import "SDCycleScrollView.h"

@interface HotViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,onClickGoodsDelegate,TapUserClickDelegate,TapmarketDelegate>{
    CustJourHeadView *_cellHeadView;
    NSMutableArray * _shopArray;
    NSMutableArray * _userArray;
    NSMutableArray * _marketArray;
    UIView * headView;//头视图
    UIView * _headView;
NSMutableArray *_titleArray;
    UILabel * pageLab;
    CustHeadViewCell * jHeadView;
    
    UILabel * actTheme;//活动主题
    UILabel * actContent;//活动内容
    
    
    NSMutableArray * topImaArr;
    NSMutableArray * topIDArr;

    
    LoadFailView * failView;

}
@property(nonatomic,strong)UIScrollView * cycleScrollView;
@property (nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)SDCycleScrollView * topView;
@end

@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"世界";
   [FTShowMessageView showStatusWithMessage:@"Loading..."];
    [self loadUserData];

}

 //绘画江湖的
-(void)loadUserData{
    _userArray = [[NSMutableArray alloc]init];
//    NSArray * ima = @[@"yonghu_01_03",@"yonghu_02_03"];
    
    
    
    topImaArr = [[NSMutableArray alloc]init];
    topIDArr = [[NSMutableArray alloc]init];
    
    
    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
    
    [params1 setValue:@([@"5" intValue]) forKey:@"limit"];
    
    //顶部
    [[HttpClient shareInstance] requestApiWithurl:@"top"  parmar:params1 success:^(NSURLSessionDataTask *task, id response) {
        NSMutableArray * dic = [response objectForKey:@"result"];
        NSLog(@"商城顶部的%@",dic);
        for (NSMutableDictionary * subDic in dic) {
            [topImaArr addObject:[NSString stringWithFormat:@"%@%@",worldsell,subDic[@"picture"]]];
            [topIDArr addObject:subDic[@"id"]];
            [_tableView reloadData];
            
        }
        
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        [FTShowMessageView dismiss];
        failView = [[LoadFailView alloc]init];
        [failView.retryBtn addTarget:self action:@selector(retry) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:failView];
        
        
    }];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:@([@"2" intValue]) forKey:@"limit"];
    
    [[HttpClient shareInstance] requestApiWithurl:@"drawing"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        
        
     

        NSMutableArray * dic = [response objectForKey:@"result"];
        NSLog(@"绘画江湖%@",dic);
        for (NSMutableDictionary * subDic in dic) {
            
            ReUserModel * user = [[ReUserModel alloc]init];
            //user.icon =@"yonghu_01_03";
            user.icon = subDic[@"img"];
            user.userName = subDic[@"name"];
            user.grade = subDic[@"rank"];
            user.user_ID = subDic[@"id"];
            [_userArray addObject:user];

          
            
            [_tableView reloadData];
            
        }
         //[self initTableView];
        [self loadShopData];
        NSLog(@"直播社区的数组为%@",_userArray);
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        [FTShowMessageView dismiss];
        failView = [[LoadFailView alloc]init];
        [failView.retryBtn addTarget:self action:@selector(retry) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:failView];
        

        
    }];

}
-(void)retry{
    [FTShowMessageView showStatusWithMessage:@"Loading..."];
    
    
    [self loadUserData];
//    [self loadShopData];
//    [self loadMarketData];
}

//最新视频

-(void)loadShopData{
    
    
    
    _shopArray = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:@([@"1" intValue]) forKey:@"limit"];
    [params setValue:@"time desc" forKey:@"order"];
    
    
    [[HttpClient shareInstance] requestApiWithurl:@"newVideo"  parmar:params success:^(NSURLSessionDataTask *task, id response) {

       id dic = [response objectForKey:@"result"];
        NSLog(@"最新视频的%@",dic);
        if (dic  == NULL) {
            
        }
        else{
            for (NSMutableDictionary * subDic in dic) {
                
                NSLog(@"最新视频的性别%@",subDic[@"sex"]);
                
                NewVideoModel * model = [[NewVideoModel alloc]init];
                //            model.icon = @"yue_03";
                model.icon = subDic[@"head"];
                if (subDic[@"name"]) {
                   model.author = subDic[@"name"];
                }else{
                     model.author = @"";
                }
                

                
                if (subDic[@"sex"]) {
                    if ([subDic[@"sex"] isEqualToString:@"男"]) {
                        model.sex = @"boy_03";
                    }else{
                        model.sex = @"girl_03";
                    }

                }
                
                model.introduce = subDic[@"explain"];
                //            model.imaName = @"video_01_03";
                model.imaName = subDic[@"picture"];
                model.visitCount =subDic[@"browse"];
                model.jfCount =subDic[@"score"] ;
                model.zanCount = subDic[@"praise"];
                model.video_id = subDic[@"id"];
                [_shopArray addObject:model];
                //
                [_tableView reloadData];
            }
            
            [self loadMarketData];
//            if (_shopArray.count == 0) {
//                [self.tableView removeFromSuperview];
//            failView = [[LoadFailView alloc]init];
//        [failView.retryBtn addTarget:self action:@selector(retry) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:failView];
//            }else{
//                //[self initTableView];
//            }

        }
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"最新视频的失败%@",response);
        
    }];

    


    
}
-(void)loadMarketData{
    _marketArray = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:@([@"2" intValue]) forKey:@"limit"];
    
    
    [[HttpClient shareInstance] requestApiWithurl:@"worldTrade"  parmar:params success:^(NSURLSessionDataTask *task, id response) {

    
        NSMutableArray * dic = [response objectForKey:@"result"];
        NSLog(@"贸易中心的%@",dic);
        int i = 0;
          CustMarketModel * model = [[CustMarketModel alloc]init];
        for (NSMutableDictionary * subDic in dic) {
            
            NSLog(@"贸易中心%@",subDic[@"sex"]);

            [_tableView reloadData];
          
           NSLog(@"定的i的值%d",i);
            if (i==0) {
            model.ima1 = @"qiugou_07";
            }
            if (i==1) {
                model.ima2 = @"shoumai_07";

            }
            i++;
           
            [_marketArray addObject:model];
            [_tableView reloadData];
            
        }
        [FTShowMessageView dismiss];
         [self initHeadView];
        [self initTableView];
        
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"贸易中心的失败%@",response);
        
    }];
 }
-(void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-NavBar_Height*2-StatusBar_Height) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    
    _tableView.delegate =self;
     _tableView.tableHeaderView = _headView;
    [self.view addSubview:_tableView];
    //刷新
    _tableView.mj_header = [FTRefreshGifHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [FTShowMessageView showStatusWithMessage:@"Loading..."];


            // 刷新表格
             [_tableView reloadData];
            dispatch_main_sync_safe(^{
                [FTShowMessageView dismissSuccessView:@"Success"];
            });
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_tableView.mj_header endRefreshing];
            
        });
        
        
    }];

    
    
}
-(void)initHeadView
{
   
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/4+10)];
    _topView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 10, kScreen_Width, kScreen_Height/4) imageURLStringsGroup:topImaArr];
    _topView.titlesGroup=_titleArray;
    _topView.placeholderImage=[UIImage imageNamed:@"Img_default"];
    _topView.delegate=self;
    _topView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    _topView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _topView.titleLabelTextFont=[UIFont systemFontOfSize:17];
    [_headView addSubview:_topView];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        return 3;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
      
            return kScreen_Height/6;

    }
    if (indexPath.section ==1) {
        return kScreen_Height/5*2;

    }
    
    if (indexPath.section == 2) {
        return kScreen_Height/5;

    }
   
    return 2;
    

   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    //推荐用户
    static NSString * userId=@"userTableCell";
    ReUserTableCell * userCell =[tableView dequeueReusableCellWithIdentifier:userId];
    if (!userCell) {
        userCell = [[ReUserTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:userId];
    }
    //新视频
    NSString * videoID = @"newVideoCell";
    NewVideoCell * videoCell =[tableView dequeueReusableCellWithIdentifier:videoID];
    if (!videoCell) {
        videoCell = [[NewVideoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:videoID];
        
    }
    videoCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //市场
    NSString * goodID = @"RecommendMarketCell";
    CustMarketCell * goodsCell =[tableView dequeueReusableCellWithIdentifier:goodID];
    if (!goodsCell) {
        goodsCell = [[CustMarketCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodID];
    }
    if (indexPath.section == 0) {
        

            userCell.selectionStyle = UITableViewCellSelectionStyleNone;
            userCell.userModelArray = _userArray;
            userCell.userDelegate = self;
            return userCell;
    }
    if (indexPath.section == 1) {
        
        videoCell.video = _shopArray[0];
        return videoCell;
    }

    if (indexPath.section == 2) {
        goodsCell.market =_marketArray[indexPath.row];
        goodsCell.marketDelegate = self;
        goodsCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return goodsCell;
        

    }
    
    
    
    return goodsCell;

    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kScreen_Height/18;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    jHeadView = [[CustHeadViewCell alloc]init];
    jHeadView.moreTitle.tag =section+1;
    [jHeadView.moreTitle addTapTraget:self withAction:@selector(moreClick:)];
    
    if (section==0) {
        
        jHeadView.backIma.backgroundColor = RGBColor(133, 206, 0);
        jHeadView.iconIma.image= LoadImageByName(@"huihuajianghu_03");
        jHeadView.headTitle.text = @"活跃用户";
        
    }
    if (section == 1) {
        jHeadView.backIma.backgroundColor = RGBColor(223, 0, 0);
        jHeadView.iconIma.image= LoadImageByName(@"zhiboshequ_03");
        jHeadView.headTitle.text = @"我们都爱看";
        jHeadView.moreTitle.hidden = YES;
    }

    if (section == 2) {
        jHeadView.backIma.backgroundColor = RGBColor(254, 225, 11);
        jHeadView.moreTitle.hidden = YES;
        jHeadView.iconIma.image= LoadImageByName(@"jiaoyishiji_03");
        jHeadView.headTitle.text = @"粉丝夺宝";
    }
    jHeadView.headTitle.textColor = lightTextColor;
    return jHeadView;
}
-(void)moreClick:(UITapGestureRecognizer *)tap{
    switch (tap.view.tag) {
        case 1:
        {
            NSLog(@"推荐用户");
            if ([[UserInfo sharedUserInfo].isLogin isEqualToString:@"0"]) {
                [HUD showAlertWithTitle:@"敬请登录"];
                //
            }else{
                DrawWorldViewController * draw = [[DrawWorldViewController alloc]init];
                draw.hidesBottomBarWhenPushed  = YES;
                [self.navigationController pushViewController:draw animated:YES];            }

          
        }
            break;
        case 2:{
            NSLog(@"推荐作品");
        }
            
        default:
            break;
    }
}
#pragma mark - 交易市场实现方法
-(void)tapBuyMarket{
    if ([[UserInfo sharedUserInfo].isLogin isEqualToString:@"0"]) {
        [HUD showAlertWithTitle:@"敬请登录"];
        //
    }else{
        PurchaseViewController * purchase = [[PurchaseViewController alloc]init];
        purchase.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:purchase animated:YES];
        
    }

   }
-(void)tapSellMarket{
    if ([[UserInfo sharedUserInfo].isLogin isEqualToString:@"0"]) {
        [HUD showAlertWithTitle:@"敬请登录"];
        //
    }else{
        LoveViewController * love =[[LoveViewController alloc]init];
        love.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:love animated:YES];
        
    }

  }
-(void)tapHeadView:(UIGestureRecognizer*)sender
{
    
    
}
-(void)TapHotCellDelegate:(HotModel *)chaneldata{
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1) {
  
             NewVideoModel * model = _shopArray[0];
            OutVideoPlayViewController * play = [[OutVideoPlayViewController alloc]init];
            play.videoID = model.video_id;
            play.hidesBottomBarWhenPushed = YES;
            if ([[UserInfo sharedUserInfo].isLogin isEqualToString:@"0"]) {
                [HUD showAlertWithTitle:@"敬请登录"];
                //
            }else{
               [self.navigationController pushViewController:play animated:YES];
                
            }

           
            
        
    }
}
-(void)TapUserCellDelegate:(ReUserModel *)userData andIntag:(NSInteger)tag{
    ReUserModel * model = _userArray[tag];
    NSLog(@"点击的是%@",model.user_ID);
    ExhibitWorksController * detail = [[ExhibitWorksController alloc]init];
    detail.hidesBottomBarWhenPushed = YES;
    detail.user_id = model.user_ID;
    
    if ([[UserInfo sharedUserInfo].isLogin isEqualToString:@"0"]) {
        [HUD showAlertWithTitle:@"敬请登录"];

        //
    }else{
        [self.navigationController pushViewController:detail animated:YES];

        
    }

   }
#pragma mark -轮播图点击
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if ([[UserInfo sharedUserInfo].isLogin isEqualToString:@"0"]) {
        [HUD showAlertWithTitle:@"敬请登录"];
        //
    }else{
        
        //        GoodsDetailViewController * goods = [[GoodsDetailViewController alloc]init];
        //        goods.hidesBottomBarWhenPushed = YES;
        //        [self.navigationController pushViewController:goods animated:YES];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
