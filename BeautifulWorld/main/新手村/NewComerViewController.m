//
//  WorldViewController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/2/21.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "NewComerViewController.h"
#import "GradeCell.h"

#import "OutVideoPlayViewController.h"

#import "PlanCell.h"
#import "LoginViewController.h"
#import "ClassLectureModel.h"
#import "ClassLectureTableCell.h"
#import "RecommendHeadView.h"
#import "OutDoorViewController.h"

#import "StudyRankViewController.h"//学习排名
#import "OutClassViewController.h"//课外讲堂更多

#import "CustHeadViewCell.h"//组头视图

#import "CustMyFormulateController.h"//制定学习计划

#import "ExhibitModel.h"
#import "ExhibitWorksCell.h"//作品展览
#import "ExhibitWorksController.h"//进入作品展览
#import "HappyGardenCell.h"//互动乐园
#import "HappyIslandViewController.h"//游乐园
#import "WorksDetailsViewController.h"//作品详情
static NSString * gradeIdentifiy = @"gradeCell";
static NSString * classIdentifiy = @"classCell";
static NSString * planIdentifiy = @"planCell";
static NSString * exhibitIdentifiy = @"exhibitCell";

@interface NewComerViewController ()<UITableViewDataSource,UITableViewDelegate,TapClassClickDelegate,UIGestureRecognizerDelegate,TapRankDelegate,makeFormulateDelegate,TapWorksClickDelegate>{
       NSArray * classArr;
    NSMutableArray * _exhibitArr;
    NSMutableArray * classImaArray;
    NSMutableArray * _classArray;
    NSMutableArray * happyGardenArr;
    HappyGardenCell * happy;
        RecommendHeadView *_cellHeadView;
    CustHeadViewCell * _sectionHeadView;
    
    LoadFailView * failView;
    UIView * headView;//头视图
    int page;


}
@property (nonatomic,strong)UITableView * worldTable;//

@end

@implementation NewComerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"初心";
    

  
    [FTShowMessageView showStatusWithMessage:@"Loading..."];
    page =1;
    
          [self loadClassDataWithType:@"1,2,3"];
        [self loadExhibitData];
        [self loadHappyGardenData];
      [self initWorldTable];



    
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     _worldTable.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height-NavBar_Height - StatusBar_Height-kScreen_Height/18-10);
    
    
   }
-(void)loadHappyGardenData{
    
    happyGardenArr = [[NSMutableArray alloc]init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:@([@"1" intValue]) forKey:@"limit"];
    
    [[HttpClient shareInstance] requestApiWithurl:@"park"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        NSMutableDictionary * dic = [response objectForKey:@"result"];
        NSLog(@"游乐园的%@",dic);
        for (NSMutableDictionary * subDic in dic) {

            HappyGardenModel * model = [[HappyGardenModel alloc]init];
            model.happyIma =subDic[@"img"];
            model.happy_id = subDic[@"id"];
            model.name = subDic[@"name"];
            model.intro_Url = subDic[@"introduce"];
            model.next_Url = subDic[@"picture"];
            model.price = subDic[@"price"];
            [happyGardenArr addObject:model];
        }
        
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"游乐园失败%@",response);
        
    }];

}

-(void)loadExhibitData{
    _exhibitArr = [[NSMutableArray alloc]init];


    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
 
    [params setValue:@([@"3" intValue]) forKey:@"limit"];
//       [params setValue:[UserInfo sharedUserInfo].user_id forKey:@"user_id"];
    
    
    [[HttpClient shareInstance] requestApiWithurl:@"worlks"  parmar:params success:^(NSURLSessionDataTask *task, id response) {

        id  dic = [response objectForKey:@"result"];
        NSLog(@"作品展览的%@",dic);
        if (dic == [NSNull null]) {
            
        }else{
            for (NSMutableDictionary * subDic in dic) {
                ExhibitModel * model = [[ExhibitModel alloc]init];
                model.imaName = subDic[@"picture"];
                model.time =subDic[@"time"];
                model.collectCount = subDic[@"likes"];
                
                model.works_id = subDic[@"id"];
                model.worksUser_id = subDic[@"user_id"];
                [_exhibitArr  addObject:model];
                [_worldTable reloadData];
                
            }

        }
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"失败%@",response);
        NSArray * ima = @[@"zuopin_01_03",@"zuopin_02_03",@"zuopin_03_03"];
        
        NSArray * timeArr = @[@"2017-02-01",@"2017-03-02",@"2017-03-23"];
        NSArray * collectArr = @[@"10",@"22",@"33"];
        for (int i = 0; i<3; i++) {
            
            ExhibitModel * model = [[ExhibitModel alloc]init];
            model.imaName = ima[i];
            
            model.time =timeArr[i];
            model.collectCount = collectArr[i];
            [_exhibitArr  addObject:model];
        }

        
    }];

    
}

#pragma  mark - 课外讲堂
-(void)loadClassDataWithType:(NSString *)type{
    _classArray = [[NSMutableArray alloc]init];
    classImaArray = [[NSMutableArray alloc]init];

    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    [params setValue:@([@"3" intValue]) forKey:@"limit"];

    [params setValue:type  forKey:@"grade"];
    
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
                    [_classArray addObject:class];
            [_worldTable reloadData];
            
        }

      
        NSLog(@"%ld",_classArray.count);

        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"失败%@",response);
        [FTShowMessageView dismiss];
        failView = [[LoadFailView alloc]init];
        [failView.retryBtn addTarget:self action:@selector(retry) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:failView];
        
        //[FTShowMessageView dismissErrorView:@"加载数据失败，请稍后重试"];
        
    }];
    
    
    
    

    
  }
-(void)retry{
    [FTShowMessageView showStatusWithMessage:@"Loading..."];
    

    [self loadClassDataWithType:@"1,2,3"];
    [self loadExhibitData];
    [self loadHappyGardenData];
}
#pragma mark - 课外讲堂代理
-(void)TapClassCellDelegate:(ClassLectureModel *)classData AndINtag:(NSInteger)tag{

    if ([[UserInfo sharedUserInfo].isLogin isEqualToString:@"0"]) {
      [HUD showAlertWithTitle:@"敬请登录"];        //
    }else{
        ClassLectureModel * class = _classArray[tag];
        OutClassViewController * classAll = [[OutClassViewController alloc]init];
        classAll.videoAllID = class.class_id;
        classAll.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:classAll animated:YES];

        
    }

  //    video.videoURL = @"http://www.jxgbwlxy.gov.cn/tm/course/041629011/sco1/1.mp4";

   }
#pragma mark - 作品展览室代理
-(void)TapWorksCellDelegate:(ExhibitModel *)exhibit AndINtag:(NSInteger)tag{
    
    if ([[UserInfo sharedUserInfo].isLogin isEqualToString:@"0"]) {
       [HUD showAlertWithTitle:@"敬请登录"];
        //
    }else{
        
        ExhibitModel * model =_exhibitArr[tag];
        WorksDetailsViewController * works = [[WorksDetailsViewController alloc]init];
        works.user_id = model.worksUser_id;
        works.works_id = model.works_id;
        works.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:works animated:YES];
        
    }

    
    
    NSLog(@"%ld",tag);
    if (tag == 0) {
        NSLog(@"点击了第一个");
    }
    if (tag == 1) {
        NSLog(@"点击了第二个");
    }
    if (tag ==2) {
        NSLog(@"点击了第三个");
    }

}
-(void)initWorldTable{
    _worldTable =[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _worldTable.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height-NavBar_Height - StatusBar_Height-kScreen_Height/18-10);
    _worldTable.delegate = self;
    _worldTable.dataSource =self;
    [self.view addSubview:_worldTable];
    UIView * zeroHead = [[UIView alloc]init];
    zeroHead.frame = CGRectMake(0, 0, kScreen_Width, 10);
    _worldTable.tableHeaderView = zeroHead;
    
    headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/18)];
    _worldTable.tableFooterView = headView;
    
    _sectionHeadView = [[CustHeadViewCell alloc]init];
    _sectionHeadView.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height/18);
    _sectionHeadView.backIma.backgroundColor = RGBColor(10, 212, 70);
    _sectionHeadView.iconIma.image = LoadImageByName(@"hudongleyuan_03");
    _sectionHeadView.headTitle.text = @"光明游乐园";
      _sectionHeadView.headTitle.textColor =RGBColor(89, 185, 241);
    _sectionHeadView.moreTitle.hidden = YES;
    [_sectionHeadView addTapTraget:self withAction:@selector(onPushClick)];
    [headView addSubview:_sectionHeadView];
    
    
    //刷新
    _worldTable.mj_header = [FTRefreshGifHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [FTShowMessageView showStatusWithMessage:@"Loading..."];
            // 刷新表格
            [self loadClassDataWithType:@"1,2,3"];
            [self loadExhibitData];
            [self loadHappyGardenData];
            [_worldTable reloadData];
//            _worldTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
            dispatch_main_sync_safe(^{
                [FTShowMessageView dismissSuccessView:@"Success"];
            });
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_worldTable.mj_header endRefreshing];
            
        });
        
        
    }];

    

}
-(void)onPushClick{
    
    CGFloat KHhead =kScreen_Height/4+kScreen_Height/18;
    headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, KHhead)];
    headView.backgroundColor = [UIColor whiteColor];
    _worldTable.tableFooterView = headView;
    
     [_worldTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    _sectionHeadView = [[CustHeadViewCell alloc]init];
    _sectionHeadView.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height/18);
    _sectionHeadView.backIma.backgroundColor = RGBColor(10, 212, 70);
    _sectionHeadView.iconIma.image = LoadImageByName(@"hudongleyuan_03");
    _sectionHeadView.headTitle.text = @"假期去哪";
      _sectionHeadView.headTitle.textColor =RGBColor(89, 185, 241);
    _sectionHeadView.moreTitle.hidden = YES;
    [_sectionHeadView addTapTraget:self withAction:@selector(initWorldTable)];
    [headView addSubview:_sectionHeadView];
    
    HappyGardenModel * model = happyGardenArr[0];
   UIImageView * imaShow = [[UIImageView alloc]init];
   imaShow.frame = CGRectMake(10, kScreen_Height/18+5, kScreen_Width-20, kScreen_Height/4-10);
    NSString * str = [NSString stringWithFormat:@"%@%@",BaseActUrl,model.happyIma];
    [imaShow sd_setImageWithURL:[NSURL URLWithString:str]];
//    imaShow.image= LoadImageByName(@"hudong_03");
    [imaShow addTapTraget:self withAction:@selector(enterHappy)];
    [headView addSubview:imaShow];
    


    
    
}
-(void)enterHappy{
    
    
    if ([[UserInfo sharedUserInfo].isLogin isEqualToString:@"0"]) {
       [HUD showAlertWithTitle:@"敬请登录"];        //
    }else{
        
        HappyGardenModel * model = happyGardenArr[0];
        
        
        HappyIslandViewController * island = [[HappyIslandViewController alloc]init];
        island.happy_Pid = model.happy_id;
        island.activityUrl = model.next_Url;
        island.introUrl = model.intro_Url;
        island.titleName = model.name;
        island.payFee = model.price;
        island.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:island animated:YES];
    }
    

  
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return 1;
  
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //学习等级
    GradeCell * gradeCell = [tableView dequeueReusableCellWithIdentifier:gradeIdentifiy];
    if (!gradeCell) {
        gradeCell = [[GradeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:gradeIdentifiy];
    }
    gradeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    

    //课外讲堂
    ClassLectureTableCell * classCell = [tableView dequeueReusableCellWithIdentifier:classIdentifiy];
    if (!classCell) {
        classCell = [[ClassLectureTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:classIdentifiy];
    }
    classCell.selectionStyle=UITableViewCellSelectionStyleNone;
    //学习计划
    PlanCell * planCell = [tableView dequeueReusableCellWithIdentifier:planIdentifiy];
    if (!planCell) {
        planCell = [[PlanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:planIdentifiy];
    }
    
    //作品展览
    ExhibitWorksCell * exhibitCell = [tableView dequeueReusableCellWithIdentifier:exhibitIdentifiy];
    if (!exhibitCell) {
        exhibitCell = [[ExhibitWorksCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:exhibitIdentifiy];
    }

    if (indexPath.section ==0) {
        GradeModel * model = [[GradeModel alloc]init];
        if ([UserInfo sharedUserInfo].userRank) {
            model.rank = [UserInfo sharedUserInfo].userRank;
        }else{
            model.rank = @"0";
        }
        
        gradeCell.myGrade = model;
        gradeCell.rankDelegate = self;
        
               return gradeCell;
    }
    if (indexPath.section == 1) {
        classCell.classModelArray = _classArray;
        classCell.classDelegate =self;
        return classCell;
    }
//    if (indexPath.section == 2) {
//        planCell.delegate =self;
//        planCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return planCell;
//    }
    if (indexPath.section == 2) {
        exhibitCell.exhibitArray = _exhibitArr;
        exhibitCell.worksDelegate = self;
        return exhibitCell;
    }

    return planCell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _sectionHeadView = [[CustHeadViewCell alloc]init];
    if (section == 0) {
        return nil;
    
     }
    if (section == 1) {
     
      
            UIView * head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/9)];
            head.backgroundColor = [UIColor whiteColor];
            
            NSString * str =[UserInfo sharedUserInfo].countrySideStyle;
            NSLog(@"学堂的风格%@",[str substringToIndex:1]);
            
            _sectionHeadView.headTitle.text = @"孩子画画不用愁";
          _sectionHeadView.headTitle.textColor =RGBColor(89, 185, 241);
            _sectionHeadView.backIma.backgroundColor = RGBColor(233, 177, 23);
            _sectionHeadView.iconIma.image = LoadImageByName(@"guangmingxuetang_03");
            _sectionHeadView.moreTitle.tag = 201;
        [_sectionHeadView.moreTitle addTapTraget:self withAction:@selector(onClickMore:)];
            [head addSubview:_sectionHeadView];
            
            
            CGFloat titleW = 40;
            CGFloat kMargin = kScreen_Width/4;
            CGFloat margin = (kScreen_Width-kMargin*3)/2;
            btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            btn1.frame = CGRectMake(margin, kScreen_Height/18+(kScreen_Height/18-16)/2, 16, 16);
        if (page ==1) {
            [btn1 setImage:LoadImageByName(@"table_ok") forState:UIControlStateNormal];

        }else{
             [btn1 setImage:LoadImageByName(@"table_no") forState:UIControlStateNormal];
        }
        
            //        [btn1 setBackgroundImage:LoadImageByName(@"table_ok") forState:UIControlStateSelected];
            btn1.tag = 20;
            btn1.selected = YES;
            //        self.selectedBtn = btn1;
            [btn1 addTarget:self action:@selector(onStyleSelect:) forControlEvents:UIControlEventTouchUpInside];
            [head addSubview:btn1];
            
            UILabel * lab1 = [[UILabel alloc]init];
            lab1.frame = CGRectMake(btn1.x+20, btn1.y, 40, 16);
            lab1.font = font15;
            lab1.text = @"少儿";
            [head addSubview:lab1];
            
            
            btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
            btn2.frame = CGRectMake(margin+kMargin, kScreen_Height/18+(kScreen_Height/18-16)/2, 16, 16);
        if (page ==2) {
            [btn2 setImage:LoadImageByName(@"table_ok") forState:UIControlStateNormal];
            
        }else{
            [btn2 setImage:LoadImageByName(@"table_no") forState:UIControlStateNormal];
        }

            //        [btn2 setBackgroundImage:LoadImageByName(@"table_ok") forState:UIControlStateSelected];
            btn2.tag = 21;
            [btn2 addTarget:self action:@selector(onStyleSelect:) forControlEvents:UIControlEventTouchUpInside];
            [head addSubview:btn2];
            UILabel * lab2 = [[UILabel alloc]init];
            lab2.frame = CGRectMake(btn2.x+20, btn1.y, 40, 16);
            lab2.text = @"小学";
            lab2.font = font15;
            [head addSubview:lab2];
            
            btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
            btn3.frame = CGRectMake(margin+kMargin*2, kScreen_Height/18+(kScreen_Height/18-16)/2, 16, 16);
        if (page ==3) {
            [btn3 setImage:LoadImageByName(@"table_ok") forState:UIControlStateNormal];
            
        }else{
            [btn3 setImage:LoadImageByName(@"table_no") forState:UIControlStateNormal];
        }

            //        [btn3 setBackgroundImage:LoadImageByName(@"table_ok") forState:UIControlStateSelected];
            btn3.tag = 22;
            [btn3 addTarget:self action:@selector(onStyleSelect:) forControlEvents:UIControlEventTouchUpInside];
            [head addSubview:btn3];
            UILabel * lab3 = [[UILabel alloc]init];
            lab3.frame = CGRectMake(btn3.x+20, btn1.y, 40, 16);
            lab3.text = @"艺考";
            lab3.font = font15;
            [head addSubview:lab3];
             return head;

        
        
        
   
        
  }
//    if (section == 2) {
//        _sectionHeadView.backIma.backgroundColor = RGBColor(250, 128, 51);
//        _sectionHeadView.iconIma.image = LoadImageByName(@"xuexijihua_03");
//        _sectionHeadView.headTitle.text = @"学习自习室";
//       
//        _sectionHeadView.moreTitle.hidden = YES;
//
//    
//
//    }
    if (section == 2) {
        _sectionHeadView.backIma.backgroundColor = RGBColor(67, 43, 231);
        _sectionHeadView.iconIma.image = LoadImageByName(@"zuopinzhanlan_03");
        _sectionHeadView.headTitle.text = @"我的画廊";
        _sectionHeadView.moreTitle.tag = 203;
       
        
               

    }

     [_sectionHeadView.moreTitle addTapTraget:self withAction:@selector(onClickMore:)];
    _sectionHeadView.headTitle.textColor =RGBColor(89, 185, 241);
       return _sectionHeadView;
}
-(void)onStyleSelect:(UIButton *)sender{
    
    switch (sender.tag) {
        case 20:
        {
            [self loadClassDataWithType:@"1,2,3"];
            page =1;
        }
            break;
        case 21:
        {
             [self loadClassDataWithType:@"4,5,6"];
            page =2;
            
            
        }
            break;
        case 22:
        {
            [self loadClassDataWithType:@"7,8,9"];
            page = 3;
            
        }
            break;
            
        default:
            break;
    }
}
-(void)moreClass{
    NSLog(@"更多视频");
    
    
    if ([[UserInfo sharedUserInfo].isLogin isEqualToString:@"0"]) {
      [HUD showAlertWithTitle:@"敬请登录"];
        //
    }else{
        
        OutClassViewController * class = [[OutClassViewController alloc]init];
        class.hidesBottomBarWhenPushed = YES;
        class.title =@"课外讲堂";
        [self.navigationController pushViewController:class animated:YES];
    }
    

    
}
-(void)onClickMore:(UITapGestureRecognizer *)tap{
     NSLog(@"更多视频");
    switch (tap.view.tag) {
        case 200:
            
            break;
        case 201:
        {
            
            
            if ([[UserInfo sharedUserInfo].isLogin isEqualToString:@"0"]) {
                [HUD showAlertWithTitle:@"敬请登录"];
                
                //
            }else{
                OutDoorViewController * class = [[OutDoorViewController alloc]init];
                class.hidesBottomBarWhenPushed = YES;
                class.title =@"视频大讲堂";
                [self.navigationController pushViewController:class animated:YES];

            }
           
            
        }
            break;
        case 202:
            
            break;
        case 203:{
            
            if ([[UserInfo sharedUserInfo].isLogin isEqualToString:@"0"]) {
               [HUD showAlertWithTitle:@"敬请登录"];
                //
            }else{
                
                ExhibitWorksController * exhibit = [[ExhibitWorksController alloc]init];
                exhibit.user_id = [UserInfo sharedUserInfo].user_id;
                exhibit.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:exhibit animated:YES];
                
            }
        }
            
            break;
        case 204:
            
            break;
            
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 40;
    }
    if (indexPath.section == 1) {
        return kScreen_Height/8*3;
    }
//    if (indexPath.section == 2) {
//        return kHeight/2;
//    }
    if (indexPath.section == 2) {
         return kScreen_Height/4;
    }
    else{
        return kScreen_Height/4;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }
    if (section == 1) {
        return kScreen_Height/9;
    }
    if (section == 2) {
         return kScreen_Height/18;
    }
    if (section == 3) {
         return kScreen_Height/18;
    }
    
    return kScreen_Height/18;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

//作品展览室代理方法实现
-(void)TapWorksCellDelegate:(ExhibitModel *)exhibit{
    
    if ([[UserInfo sharedUserInfo].isLogin isEqualToString:@"0"]) {
       [HUD showAlertWithTitle:@"敬请登录"];
        //
    }else{
        
        WorksDetailsViewController * works = [[WorksDetailsViewController alloc]init];
        works.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:works animated:YES];
    }

  
}
//等级排名代理
-(void)TapRankCellDelegate{
//    StudyRankViewController * rank = [[StudyRankViewController alloc]init];
//    rank.hidesBottomBarWhenPushed= YES;
//    [self.navigationController pushViewController:rank animated:YES];
}
#pragma mark - 制定学习计划
-(void)makeFormulate{
    NSLog(@"制定学习计划");
    CustMyFormulateController * formulate = [[CustMyFormulateController alloc]init];
    formulate.hidesBottomBarWhenPushed = YES;
    formulate.isShowHeadView = NO;
    [self.navigationController pushViewController:formulate animated:YES];
}
#pragma mark - 点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
            
        case 3:
        {
            
        }
            break;
  
            
        case 4:
        {
            
            
            
//            HappyIslandViewController * island = [[HappyIslandViewController alloc]init];
//            island.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:island animated:YES];
        }
            break;
            
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
