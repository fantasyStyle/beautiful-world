//
//  TeacherSceneryController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/7.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "TeacherSceneryController.h"
#import "TeacherSceneryCell.h"
#import "TeacherDetailController.h"
#import "ApprenticeView.h"
#import "BecomeMemberController.h"
#import "OutVideoPlayViewController.h"//播放视频
@interface TeacherSceneryController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>{
    ApprenticeView * apprentice;
    UIView *backgroundView;
    UIView * headerView;//头视图
      BOOL  isApprence;//拜师
    UIButton *_apprenticedBtn;
    int page;
    BOOL ismore;

}

@property (nonatomic,strong)NSMutableArray *dataArr;
//数组
@property (nonatomic,strong)NSMutableArray * detailArr;

@property (nonatomic,strong)UICollectionView * collectionView;
@end

@implementation TeacherSceneryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(235, 235, 241);
    [FTShowMessageView showStatusWithMessage:@"Loading..."];
    NSLog(@"%@",self.teacher_id);
    self.navigationItem.title = @"全部教师";
    _dataArr = [NSMutableArray array];
    page = 1;
    ismore = NO;

    [self initHeadView];
   [self creatData];
    [self creatCollectionView];
    // Do any additional setup after loading the view.
}
-(NSMutableArray*)dataArr{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}
-(void)creatData{
    
   

    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:@([@"10" intValue]) forKey:@"limit"];
    if (ismore == YES) {
        page++;
        
        
        NSLog(@"上啦页数%d",page);
        [params setValue:@(page) forKey:@"page"];
    }else{
        [params setValue:@([@"1" intValue]) forKey:@"page"];
    }

      [params setValue:@([self.teacher_id intValue]) forKey:@"pid"];
    
    [[HttpClient shareInstance] requestApiWithurl:@"teacherWorks"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        [FTShowMessageView dismissSuccessView:@"Success"];
        NSLog(@"教师作品的%@",response);
 
        id  dic = [response objectForKey:@"result"];

        if (dic == [NSNull null]) {
            if (page >1) {
                [_collectionView.mj_footer endRefreshing];
                [HUD showAlertWithTitle:@"没有更多数据了"];
            }else{
                [HUD showAlertWithTitle:@"暂无数据了"];
            }

            
                   }else{
            
            for (NSMutableDictionary * subDic in dic) {
                TeacherSceneryModel * jmodel = [[TeacherSceneryModel alloc]init];
                jmodel.cover = subDic[@"picture"];
                jmodel.title = subDic[@"name"];
                jmodel.time = subDic[@"time"];
                jmodel.model_id = subDic[@"id"];
                [_dataArr addObject:jmodel];
              
               
                
            }
          [_collectionView reloadData];
        }
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"失败%@",response);
        
        [FTShowMessageView dismissErrorView:@"加载数据失败，请稍后重试"];
        
    }];
    


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)creatCollectionView{
    UICollectionViewFlowLayout * layout =[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((kScreen_Width-30)/2,(kScreen_Width-15)/2 );
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing=0;
    
    layout.sectionInset = UIEdgeInsetsMake(5,10,5,10);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kScreen_Height/5, kScreen_Width, kScreen_Height-NavBar_Height-StatusBar_Height-kScreen_Height/4) collectionViewLayout:layout];
    _collectionView.frame = CGRectMake(0, kScreen_Height/5, kScreen_Width, kScreen_Height-NavBar_Height-StatusBar_Height);
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    

    _collectionView.backgroundColor=[UIColor whiteColor];
    [_collectionView registerClass:[TeacherSceneryCell class] forCellWithReuseIdentifier:@"TeacherSceneryCell"];
    [self.view addSubview:_collectionView];
    
    
    //刷新
    _collectionView.mj_header = [FTRefreshGifHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            ismore =NO;
            if (self.dataArr.count !=0) {
                [self.dataArr removeAllObjects];
            }
            [self creatData];
            

            // 刷新表格
            [self creatData];
             [_collectionView reloadData];
       
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_collectionView.mj_header endRefreshing];
            
        });
        
        
    }];
    _collectionView.mj_footer = [FTRefreshGifFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            ismore = YES;
            [self creatData];
            // 刷新表格
            [_collectionView reloadData];
            
            

                      // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_collectionView.mj_footer endRefreshing];
        });
        
        
    }];
    
}
-(void)initHeadView{
    headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height/5);
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UIImageView * headIcon = [[UIImageView alloc]init];
    headIcon.frame = CGRectMake(20, 10, kScreen_Width/5, kScreen_Width/5);
//    headIcon.image = LoadImageByName(@"fan_03");
    [headerView addSubview:headIcon];
    
    
    UILabel *  nameLab = [[UILabel alloc]init];
    nameLab.frame = CGRectMake(headIcon.x + headIcon.frame.size.width +20, 10, 50, 20);
    nameLab.font = font15;
    nameLab.textColor = [UIColor darkGrayColor];
    [headerView addSubview:nameLab];
    
    UIImageView *  sexIma = [[UIImageView alloc]init];
    sexIma.frame = CGRectMake(nameLab.x + 60, 10, 20, 20);
    sexIma.image = LoadImageByName(@"boy_03");
    [headerView addSubview:sexIma];
    
    
    UILabel * ageLab = [[UILabel alloc]init];
    ageLab.frame = CGRectMake(sexIma.x + 30, 10, 50, 20);
    ageLab.textColor = [UIColor darkGrayColor];
    ageLab.font = font14;
    
    [headerView addSubview:ageLab];
    
    UILabel * introduceLab = [[UILabel alloc]init];
    introduceLab.frame = CGRectMake(nameLab.x, nameLab.y+22, kScreen_Width/3*2, 36);
    introduceLab.numberOfLines = 2;
    introduceLab.font = font13;
    introduceLab.textColor = [UIColor darkGrayColor];
    [headerView addSubview:introduceLab];
    
    
    UILabel * schoolLab = [[UILabel alloc]init];
    schoolLab.frame = CGRectMake(nameLab.x, introduceLab.y+40, kScreen_Width/3*2, 20);
    schoolLab.textColor = [UIColor darkGrayColor];
    schoolLab.font = font13;
    
    [headerView addSubview:schoolLab];
    
    UILabel *  studentLab = [[UILabel alloc]init];
    studentLab.frame = CGRectMake(nameLab.x, schoolLab.y+22,kScreen_Width/3 , 20);
    studentLab.textColor = [UIColor darkGrayColor];
    studentLab.font = font13;
    
    [headerView addSubview:studentLab];
    
    _apprenticedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _apprenticedBtn.frame = CGRectMake(kScreen_Width - 60, 10, 50, 22);
    [_apprenticedBtn setImage:LoadImageByName(@"baishi_03") forState:UIControlStateNormal];
    [_apprenticedBtn addTarget:self action:@selector(apprenticeClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    CGFloat styleW = 35;
//    CGFloat margin = 10;
//    NSArray * styleArr = @[@"shuifen_03",@"sumiao_03"];
//    for (int i = 0; i<2; i++) {
//        UIImageView * styleIma = [[UIImageView alloc]init];
//        styleIma.frame = CGRectMake(nameLab.x+(styleW + margin)*i, headerView.frame.size.height-20, styleW, 18);
//        styleIma.image = LoadImageByName(styleArr[i]);
//        [headerView addSubview:styleIma];
//        
//    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:@([self.teacher_id intValue]) forKey:@"id"];
    
    [[HttpClient shareInstance] requestApiWithurl:@"teacherdetails"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        
        NSMutableDictionary * dic = [response objectForKey:@"result"];
        NSLog(@"教师详情的%@",dic);
        for (NSMutableDictionary * subDic in dic) {
            NSString * stricon = [NSString stringWithFormat:@"%@%@",teacherUrl,subDic[@"img"]];
            [headIcon sd_setImageWithURL:[NSURL URLWithString:stricon]];
            nameLab.text =[NSString stringWithFormat:@"%@",subDic[@"name"]] ;
            ageLab.text =[NSString stringWithFormat:@"%@",subDic[@"age"]];
            introduceLab.text =[NSString stringWithFormat:@"%@",subDic[@"introduce"]];
            schoolLab.text =[NSString stringWithFormat:@"%@", subDic[@"school"]];
            studentLab.text =[NSString stringWithFormat:@"%@", subDic[@"student"]]; ;
            NSString * str = [NSString stringWithFormat:@"%@",subDic[@"judge"]];
            NSLog(@"是否拜师%@",str);
            if ([str isEqualToString:@"0"]) {
                _apprenticedBtn.hidden = NO;
                isApprence = NO;
            }
            else{
                _apprenticedBtn.hidden = YES;
                
            }
            
            [headerView addSubview:_apprenticedBtn];

//
            
            
            
           // [_collectionView reloadData];
            
        }
        
        
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"失败%@",response);
        
        //[FTShowMessageView dismissErrorView:@"加载数据失败，请稍后重试"];
        
    }];

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

    [params setValue:[UserInfo sharedUserInfo].user_id forKey:@"user_id"];
    [params setValue:self.teacher_id forKey:@"teacher"];
    
    
    [[HttpClient shareInstance] requestApiWithurl:@"baiShi"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"拜师成功%@",response);
        
        NSMutableDictionary * dic = [response objectForKey:@"result"];
        
        //[sender removeFromSuperview];
        [_collectionView reloadData];
        sender.hidden = YES;
        
        
        [apprentice removeFromSuperview];
        [backgroundView removeFromSuperview];
        
        
        
        
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"拜师失败%@",response);
        
        [FTShowMessageView dismissErrorView:@"加载数据失败，请稍后重试"];
        
    }];
}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(kScreen_Width, kScreen_Height /5);
//}

- (NSInteger)collectionView:( UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (UICollectionViewCell*)collectionView:( UICollectionView *)collectionView cellForItemAtIndexPath:( NSIndexPath *)indexPath{
    TeacherSceneryCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TeacherSceneryCell" forIndexPath:indexPath];
       cell.teacherModel=_dataArr[indexPath.row];
    if (_apprenticedBtn.hidden == YES) {
        cell.suoIma.hidden = YES;
    }
    else{
        cell.suoIma.hidden = NO;
    }
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:( UICollectionView *)collectionView{
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    TeacherDetailController * detail = [[TeacherDetailController alloc]init];
//    [self.navigationController pushViewController:detail animated:YES];
    
    if (_apprenticedBtn.hidden == NO) {
        [HUD showAlertWithTitle:@"您还没有拜师，前往拜师即可观看！"];
    }else{
        TeacherSceneryModel * model = _dataArr[indexPath.row];
        OutVideoPlayViewController * play = [[OutVideoPlayViewController alloc]init];
        play.videoID =model. model_id;
        [self.navigationController pushViewController:play animated:YES];
        
    }
//    BecomeMemberController * member =[[BecomeMemberController alloc]init];
//    [self.navigationController pushViewController:member animated:YES];
//    
}

@end
