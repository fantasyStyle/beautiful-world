//
//  WorksTaskController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/5/3.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "WorksTaskController.h"
#import "WorksTaskTableViewCell.h"
#define Htrade kScreen_Height/5
@interface WorksTaskController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>{
    UIImageView * headIcon;
    UILabel * nameLab;
    UILabel * introduceLab;
    UILabel * demandLab;
    UILabel * timeLab;

}

//滚动视图数组
@property (nonatomic,strong)NSMutableArray *dataArr;

@property (nonatomic,strong)UICollectionView * collectionView;
@end

@implementation WorksTaskController

- (void)viewDidLoad {
    [super viewDidLoad];
     //[FTShowMessageView showStatusWithMessage:@"Loading..."];
     [self creatData];
    [self creatCollectionView];
    // Do any additional setup after loading the view.
}
-(NSMutableArray*)dataArray{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}
-(void)creatData{
    
    _dataArr = [[NSMutableArray alloc]init];
    
    for (int i=0; i<6; i++) {
        WorksTaskModel * model = [[WorksTaskModel alloc]init];
        model.imaName = @"renwu_01_03";
        model.headIcon = @"head_yue_03";
        model.collectCount = @"30";
        model.name = @"玥";
        model.zanCount = @"23";
        [_dataArr addObject:model];
    }
    
    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    
//    [params setValue:@([@"10" intValue]) forKey:@"limit"];
//    //人物作品
//    [[HttpClient shareInstance] requestApiWithurl:@"task"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
//        NSLog(@"成功%@",response);
//        [FTShowMessageView dismiss];
//        [self creatCollectionView];
//        
//        NSMutableDictionary * dic = [response objectForKey:@"result"];
//        NSLog(@"人物作品的%@",dic);
//        for (NSMutableDictionary * subDic in dic) {
//           
//            [_collectionView reloadData];
//            
//        }
//        NSLog(@"%ld",_dataArr.count);
//        //[HUD showAlertWithTitle:@"登录成功"];
//        
//    } failuer:^(NSURLSessionDataTask *task, id response) {
//        NSLog(@"失败%@",response);
//        
//    }];
    
}
-(void)creatCollectionView{
    UICollectionViewFlowLayout * layout =[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((kScreen_Width-20)/3,kScreen_Height/4);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing=0;
    
    layout.sectionInset = UIEdgeInsetsMake(5,5,5,5);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    
    _collectionView.backgroundColor=[UIColor whiteColor];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];

    [_collectionView registerClass:[WorksTaskTableViewCell class] forCellWithReuseIdentifier:@"WorksTaskTableViewCell"];
    self.collectionView.alwaysBounceVertical = YES;
    [self.view addSubview:_collectionView];
    
    //刷新
    _collectionView.mj_header = [FTRefreshGifHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [FTShowMessageView showStatusWithMessage:@"Loading..."];
            [self creatData];
            // 刷新表格
            [_collectionView reloadData];
            //            [_freedomView reloadData];
            dispatch_main_sync_safe(^{
                [FTShowMessageView dismissSuccessView:@"Success"];
            });
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_collectionView.mj_header endRefreshing];
            
        });
        
        
    }];
    _collectionView.mj_footer = [FTRefreshGifFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 刷新表格
            // [myTable reloadData];
            [FTShowMessageView showStatusWithMessage:@"Loading..."];
            [self creatData];
            // 刷新表格
            [_collectionView reloadData];
            //             [_freedomView reloadData];
            dispatch_main_sync_safe(^{
                [FTShowMessageView dismissSuccessView:@"Success"];
            });
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_collectionView.mj_footer endRefreshing];
        });
        
        
    }];
    
    
}
- (NSInteger)collectionView:( UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  
        return _dataArr.count;
}
- (UICollectionViewCell*)collectionView:( UICollectionView *)collectionView cellForItemAtIndexPath:( NSIndexPath *)indexPath{
    WorksTaskTableViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WorksTaskTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    cell.task = _dataArr[indexPath.row];
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:( UICollectionView *)collectionView{
    return 1;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView * headerView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView" forIndexPath:indexPath];
    
    UIView * backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.frame = CGRectMake(20, 0, kScreen_Width - 40, Htrade);
    [headerView addSubview:backView];
    
    headIcon = [[UIImageView  alloc]init];
    headIcon.frame = CGRectMake(10, 10, kScreen_Width/12, kScreen_Width/12);
    headIcon.layer.masksToBounds = YES;
    headIcon.image = LoadImageByName(@"head_04");
    headIcon.layer.cornerRadius = headIcon.frame.size.width/2;
    [backView addSubview:headIcon];
    
    
    nameLab = [[UILabel alloc]init];
    nameLab.frame =CGRectMake(headIcon.x+headIcon.frame.size.width+5, 15, kScreen_Width/3, 18);
    nameLab.font = font14;
    nameLab.text =@"李爱娴老师";
    nameLab.textColor = [UIColor darkGrayColor];
    [backView addSubview:nameLab];
    
    
    introduceLab = [[UILabel alloc]init];
    introduceLab.frame = CGRectMake(headIcon.x+8, headIcon.y+headIcon.frame.size.height+10, kScreen_Width/3*2, 20);
    introduceLab.font = font13;
    introduceLab.text = @"以【花鸟】为主题作画一幅";
    introduceLab.textColor = [UIColor darkGrayColor];
    [backView addSubview:introduceLab];
    
    demandLab = [[UILabel alloc]init];
    demandLab.frame = CGRectMake(introduceLab.x, introduceLab.y+30, kScreen_Width/3*2, 20);
    demandLab.font = font13;
    demandLab.textColor = [UIColor darkGrayColor];
    demandLab.text = @"要求：注重表现基本的技法技巧";
    [backView addSubview:demandLab];
    
    
    timeLab = [[UILabel alloc]init];
    timeLab.frame=CGRectMake(demandLab.x, Htrade-30, kScreen_Width/3*2, 20);
    timeLab.font = font13;
    timeLab.text = @"2017.04.08 - 2017.04.20";
    timeLab.textColor = [UIColor darkGrayColor];
    [backView addSubview:timeLab];

    return headerView;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreen_Width, kScreen_Height /5);
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
