//
//  JourneyViewController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/2/21.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "JourneyViewController.h"
#import "RecommendGoodsCell.h"
#import "SDCycleScrollView.h"
#import "PYSearch.h"//搜索
#import "FTCustomField.h"
#import "FTSearchResultViewController.h"
#import "GoodsShoppingController.h"//商品展示页
#import "RouteModel.h"
#import "FamousTeacherController.h"//名师列表
#import "TradeController.h"//公会
#import "NewWorldViewController.h"//新世界专栏
#import "CustJourHeadView.h"
#import "CustHeadViewCell.h"//分组头视图
//#import "ActivityDetailController.h"//活动详情
#import "HappyIslandViewController.h"//详情
#import "ExpandStudyViewCell.h"//拓展学习
#import "TradeAllianceController.h"//公会联盟
#import "CustRouteTableViewCell.h"//光明学院
#import "TeacherSceneryController.h"//教师详情
@interface JourneyViewController ()<UITableViewDataSource,UITableViewDelegate,PYSearchViewControllerDelegate,UITextFieldDelegate,TapJorneyDelegate,UIScrollViewDelegate,tapRouteClickDelegate>{
    UIView * headView;//头视图
    NSInteger  _imgSelectIndex;
    UILabel * pageLab;
    CustHeadViewCell * jHeadView;
    NSMutableArray * routeSchoolArr;//名门师派
    NSMutableArray * teacherSchoolArr;//学院
    NSMutableArray * journeyTimeArr;
    UILabel * actTheme;//活动主题
    UILabel * actContent;//活动内容
    NSMutableArray * imageArr;//通告展示
    NSMutableArray * introArr;//通告展示
    NSMutableArray * nextPicArr;//通告展示
    NSMutableArray * introPicArr;//通告展示
    NSMutableArray * act_IDArr;//通告展示
    NSMutableArray * feeArr;//通告展示
     NSMutableArray * nameArr;//通告展示

    
        LoadFailView * failView;
    

}
@property (nonatomic,strong)UITableView * JourneyTable;
@property(nonatomic,strong)UIScrollView * cycleScrollView;

@property (nonatomic, strong) UITableView * schoolTable;//卡片
@property (nonatomic, strong) NSMutableArray * itmeArray;
@end

@implementation JourneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.navigationItem.title = @"旅程";
  
     [FTShowMessageView showStatusWithMessage:@"Loading..."];
    [self loadTeacherSchoolData];
    [self loadRouteSchoolData];
   

}

-(void)initJourneyTable{
    _JourneyTable =[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _JourneyTable.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height-NavBar_Height-StatusBar_Height-kScreen_Height/18-10);
    _JourneyTable.dataSource = self;
    _JourneyTable.delegate = self;
    [self.view addSubview:_JourneyTable];
    [self onPushClick];
    

    //刷新
    _JourneyTable.mj_header = [FTRefreshGifHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [FTShowMessageView showStatusWithMessage:@"Loading..."];
            // 刷新表格
            [self loadTeacherSchoolData];
            [self loadRouteSchoolData];
//            [self loadTimedata];
            [_JourneyTable reloadData];
            //            _worldTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
            dispatch_main_sync_safe(^{
                [FTShowMessageView dismissSuccessView:@"Success"];
            });
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_JourneyTable.mj_header endRefreshing];
            
        });
        
        
    }];
    
    
   

    

    
}
-(void)onPushClick{
    
    CGFloat KHhead =kScreen_Height/5*2;
    headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, KHhead)];
    _JourneyTable.tableFooterView = headView;
    
    
    //最上面的图片
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreen_Width,KHhead)];
    topView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:topView];
//    NSMutableArray * imageArr =[[NSMutableArray alloc]initWithObjects:@"huodong_01",@"huodong_02",@"huodong_03", nil];
    imageArr = [[NSMutableArray alloc]init];
    introArr = [[NSMutableArray alloc]init];
    nextPicArr = [[NSMutableArray alloc]init];
    introPicArr = [[NSMutableArray alloc]init];
    act_IDArr  = [[NSMutableArray alloc]init];
    feeArr = [[NSMutableArray alloc]init];
    nameArr = [[NSMutableArray alloc]init];
    self.cycleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kScreen_Height/18, kScreen_Width, topView.frame.size.height - kScreen_Height/18-30)];
    self.cycleScrollView.pagingEnabled = YES;
    self.cycleScrollView.bounces = NO;
    [topView addSubview:self.cycleScrollView];
    
    //通告展示
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@([@"3" intValue]) forKey:@"limit"];
    [[HttpClient shareInstance] requestApiWithurl:@"activity"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        id dic = [response objectForKey:@"result"];
        NSLog(@"绿城通告展示的%@",dic);
        for (NSMutableDictionary * subDic in dic) {
            [imageArr addObject:subDic[@"img"]];
          //  [introArr addObject:subDic[@"intro"]];
            [nextPicArr addObject:subDic[@"picture"]];
            [introPicArr addObject:subDic[@"introduce"]];
            [act_IDArr addObject:subDic[@"id"]];
            [feeArr addObject:subDic[@"price"]];
            [nameArr addObject:subDic[@"name"]];
//            [imageArr addObject:subDic[@"picture"]];
            [_JourneyTable reloadData];
            
        }
        //计数器
        
        for (int i = 0 ;i<imageArr.count;i++) {
            
            //创建UIImageView
            UIImageView * imgView =[[UIImageView alloc]init];
            imgView.frame=CGRectMake(i* kScreen_Width, 0, kScreen_Width, _cycleScrollView.frame.size.height);
//            imgView.image=LoadImageByName(imageArr[i]);
            NSString * str = [NSString stringWithFormat:@"%@%@",BaseActUrl,imageArr[i]];
            [imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:LoadImageByName(@"huodong_02")];
            //用户事件响应
            imgView.userInteractionEnabled=YES;
            //图片充满
            imgView.contentMode=UIViewContentModeScaleToFill;
            imgView.tag=i+100;
            UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onActivityTap:)];
            [imgView addGestureRecognizer:tap];
            
            [_cycleScrollView addSubview:imgView];
            
            //滚动视图设置显示大小
            _cycleScrollView.contentSize=CGSizeMake(imageArr.count*kScreen_Width,_cycleScrollView.frame.size.height );        //定位到选中索引图片 根据偏移量
            _cycleScrollView.contentOffset= CGPointMake(0, 0);
            //设置代理
            _cycleScrollView.delegate=self;
            
        }

        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"通告展示失败%@",response);
        
        
    }];

    
    
    jHeadView = [[CustHeadViewCell alloc]init];
    jHeadView.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height/18);
    jHeadView.headTitle.text = @"世界那么大";
    jHeadView.iconIma.image  = LoadImageByName(@"huodong");
    jHeadView.backIma.backgroundColor = RGBColor(236, 0, 23);
    jHeadView.headTitle.textColor = RGBColor(89, 185, 241);
    jHeadView.moreTitle.hidden = YES;
//    [jHeadView addTapTraget:self withAction:@selector(initJourneyTable)];
    [topView addSubview:jHeadView];
    
    pageLab = [[UILabel alloc]init];
    pageLab.frame = CGRectMake(kScreen_Width-50, 5, 40, 20);
    pageLab.textColor = [UIColor darkGrayColor];
    pageLab.text = @"1/3";
    pageLab.font = [UIFont systemFontOfSize:13];
    [jHeadView addSubview:pageLab];
    
    //活动内容
    actContent = [[UILabel alloc]init];
    actContent.frame = CGRectMake(30, topView.frame.size.height-20, kScreen_Width-60, 20);
    actContent.textColor =[UIColor darkGrayColor];
    actContent.font = [UIFont systemFontOfSize:13];
    [topView addSubview:actContent];
    


}
#pragma mark - 加载数据
-(void)loadTeacherSchoolData{
    
    teacherSchoolArr = [[NSMutableArray alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    [params setValue:@([@"2" intValue]) forKey:@"limit"];
    
    
    [[HttpClient shareInstance] requestApiWithurl:@"teacherSchool"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        [FTShowMessageView dismiss];
         [self initJourneyTable];
        NSMutableDictionary * dic = [response objectForKey:@"result"];
        NSLog(@"名门师派的%@",dic);
        for (NSMutableDictionary * subDic in dic) {
//            RecommendModel * model = [[RecommendModel alloc]init];
//            model.goodsImaName1 = @"zuopin_01_03";
//            model.goodsImaName2 =subDic[@"time"];
            
            [teacherSchoolArr addObject:subDic[@"picture"]];
            
            
                [_JourneyTable reloadData];
            
        }
        NSLog(@"名门数组为%@",teacherSchoolArr);
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"名门师派失败%@",response);
        [FTShowMessageView dismiss];
        failView = [[LoadFailView alloc]init];
        [failView.retryBtn addTarget:self action:@selector(retry) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:failView];

        
    }];

}
-(void)retry{
    [FTShowMessageView showStatusWithMessage:@"Loading..."];
    
    
    [self loadTeacherSchoolData];
    [self loadRouteSchoolData];
//    [self loadTimedata];
}
//光明学院
-(void)loadRouteSchoolData{
    
    routeSchoolArr = [[NSMutableArray alloc]init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    [[HttpClient shareInstance] requestApiWithurl:@"routeSchool"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"成功%@",response);
        NSMutableDictionary * dic = [response objectForKey:@"result"];
        NSLog(@"光明学院的%@",dic);
        for (NSMutableDictionary * subDic in dic) {
           
            RouteModel * model = [[RouteModel alloc]init];
            model.imaName = subDic[@"picture"];
            model.teacher_id = subDic[@"id"];
            [routeSchoolArr addObject:model];
            
            
            [_JourneyTable reloadData];
            
        }
        NSLog(@"光明学院数组为%@",teacherSchoolArr);
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"光明学院失败%@",response);
        
        for (int i =0; i<6; i++) {
            RouteModel * model = [[RouteModel alloc]init];
            model.imaName = @"新世界5";
            
            [routeSchoolArr addObject:model];
            

        }
        
    }];
    

}
//-(void)loadTimedata{
//    journeyTimeArr = [[NSMutableArray alloc]init];
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    
//    [params setValue:@([@"1" intValue]) forKey:@"limit"];
//    
//    
//    [[HttpClient shareInstance] requestApiWithurl:@"time"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
//        NSLog(@"成功%@",response);
//        NSMutableDictionary * dic = [response objectForKey:@"result"];
//        NSLog(@"时空穿越的的%@",dic);
//        for (NSMutableDictionary * subDic in dic) {
//                [journeyTimeArr addObject:subDic[@"picture"]];
//            
//            
//            [_JourneyTable reloadData];
//            
//        }
//        NSLog(@"时空穿越的数组为%@",journeyTimeArr);
//        
//    } failuer:^(NSURLSessionDataTask *task, id response) {
//        NSLog(@"时空穿越的失败%@",response);
//        
//    }];
//    
//    
// NSLog(@"时空穿越www的数组为%@",journeyTimeArr);
//}
#pragma mark - 活动详情
-(void)onActivityTap:(UITapGestureRecognizer *)tap{
      HappyIslandViewController * activity = [[HappyIslandViewController alloc]init];
    switch (tap.view.tag) {
        case 100:
            activity.activityUrl =nextPicArr[0];
            activity.introUrl = introPicArr[0];
            activity.happy_Pid = act_IDArr[0];
            activity.payFee = feeArr[0];
            activity.titleName =nameArr[0];
            break;
        case 101:
            activity.activityUrl =nextPicArr[1];
            activity.introUrl = introPicArr[1];
            activity.happy_Pid = act_IDArr[1];
            activity.payFee = feeArr[1];
            activity.titleName =nameArr[1];

            break;

        case 102:
            activity.activityUrl =nextPicArr[2];
            activity.introUrl = introPicArr[2];
            activity.happy_Pid = act_IDArr[2];
            activity.payFee = feeArr[2];
            activity.titleName =nameArr[1];

            break;

            
        default:
            break;
    }
    
    if ([[UserInfo sharedUserInfo].isLogin isEqualToString:@"0"]) {
      [HUD showAlertWithTitle:@"敬请登录"];
        //
    }else{
        NSLog(@"活动%@详情%@",activity.activityUrl,activity.introUrl);
        activity.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:activity animated:YES];
        
    }

  }
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page =scrollView.contentOffset.x/kScreen_Width;
    pageLab.text=[NSString stringWithFormat:@"%ld/%d",page+1,3];
   // NSArray * actArr = @[@"2017年3月28日，在西安美术学院有手绘插画比赛",@"2017年4月3号早上9:00钟，在大雁塔广场涂鸦比赛..........",@"2017年4月5号下午2:00，在西安美术学院有创意绘画比赛........."];
    //actContent.text = introArr[page];
}
#pragma mark - 教师风采 公会
-(void)TapJourneyCell{

    if ([[UserInfo sharedUserInfo].isLogin isEqualToString:@"0"]) {
     [HUD showAlertWithTitle:@"敬请登录"];        //
    }else{
        FamousTeacherController * teacher = [[FamousTeacherController alloc]init];
        teacher.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:teacher animated:YES];
    }

  }
-(void)TapTradeCell{
     //[HUD showAlertWithTitle:@"暂未开放"];
    
    TradeAllianceController * trade = [[TradeAllianceController alloc]init];
    trade.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:trade animated:YES];
}
#pragma  mark - 新世界
-(void)scrolIndex:(NSInteger)index{
    NSLog(@"第%ld",index);
}
-(void)onImaClick:(NSInteger)index{
    NSLog(@"点击了第%ld",index);
    
    if ([[UserInfo sharedUserInfo].isLogin isEqualToString:@"0"]) {
       [HUD showAlertWithTitle:@"敬请登录"];
        //
    }else{
        NewWorldViewController * worldNew = [[NewWorldViewController alloc]init];
        worldNew.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:worldNew animated:YES];

        
    }

    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  
   
        return 2;
   
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
         NSString * cellIdentifiy = @"recommendCell";
        RecommendGoodsCell * goodsCell =[tableView dequeueReusableCellWithIdentifier:cellIdentifiy];
        if (!goodsCell) {
            goodsCell = [[RecommendGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifiy];
        }
//        //拓展学习
//        ExpandStudyViewCell * expand = [tableView dequeueReusableCellWithIdentifier:@"expandCell"];
//        if (!expand) {
//            expand = [[ExpandStudyViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"expandCell"];
//        }
//        expand.selectionStyle = UITableViewCellSelectionStyleNone;
    
        RecommendModel * model =[[RecommendModel alloc]init];
        model.goodsImaName1 = @"jiaoshifengcai";
        model.goodsImaName2 = @"gonghuilianmeng";
        goodsCell.myGoodsModel = model;
        goodsCell.jCellTapDelegate = self;
        
        goodsCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    NSString * routeID = @"routeCellID";
    CustRouteTableViewCell * routeCell = [tableView dequeueReusableCellWithIdentifier:routeID];
    if (!routeCell) {
        routeCell = [[CustRouteTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:routeID];
    }
    
    
        
   if (indexPath.section == 0) {
            return goodsCell;
        }
    else{
        routeCell.classModelArray =routeSchoolArr;
        routeCell.routeDelegate = self;
        return routeCell;
    }
//    if (indexPath.section == 2) {
//        return expand;
//    }
//    return expand;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        [HUD showAlertWithTitle:@"此功能暂未开放" duration:2.0];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (indexPath.section ==1) {
        return kScreen_Height/5;
    }else{
          return kScreen_Height/4;
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
              return 10;
    
    
  }
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
    
   
         return kScreen_Height/18;
   
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
          jHeadView = [[CustHeadViewCell alloc]init];
        if (section == 0) {
            NSString * str =[UserInfo sharedUserInfo].countrySideStyle;
            NSLog(@"学堂的风格%@",[str substringToIndex:1]);
            if ([[str substringToIndex:1] isEqualToString:@"光"]) {
            }else{
                
            }
            jHeadView.headTitle.text = @"我和名师有个约定";
            jHeadView.iconIma.image  = LoadImageByName(@"mingmenshipai");
            jHeadView.backIma.backgroundColor = RGBColor(29, 118, 251);
            jHeadView.headTitle.textColor = RGBColor(89, 185, 241);
            jHeadView.moreTitle.hidden = YES;
        }
    if (section == 1) {
        jHeadView.headTitle.text = @"秒变大神";
        jHeadView.iconIma.image  = LoadImageByName(@"guangmingxuetang");
        jHeadView.backIma.backgroundColor = RGBColor(120, 181, 30);
        jHeadView.headTitle.textColor = RGBColor(89, 185, 241);
        jHeadView.moreTitle.hidden = YES;

    }
//        if (section == 2) {
//            jHeadView.headTitle.text = @"时空穿越";
//            jHeadView.iconIma.image  = LoadImageByName(@"tuozhanxuexi_03");
//            jHeadView.backIma.backgroundColor = RGBColor(243, 41, 0);
//            jHeadView.headTitle.textColor = RGBColor(89, 185, 241);
//            jHeadView.moreTitle.hidden = YES;
//            
//        }
        return jHeadView;
        

   }
#pragma mark -光明学院实现方法
-(void)tapRoute:(RouteModel *)route andIntag:(NSInteger)tag{
    
    if ([[UserInfo sharedUserInfo].isLogin isEqualToString:@"0"]) {
        [HUD showAlertWithTitle:@"敬请登录"];        //
    }else{
        RouteModel * model = routeSchoolArr[tag];
        TeacherSceneryController * teacher = [[TeacherSceneryController alloc]init];
        teacher.teacher_id = model.teacher_id;
        teacher.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:teacher animated:YES];
        
    }

    
      NSLog(@"点击的是%ld",tag);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
