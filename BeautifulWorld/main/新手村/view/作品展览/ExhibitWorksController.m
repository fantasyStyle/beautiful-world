//
//  ExhibitWorksController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/10.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "ExhibitWorksController.h"
#import "EchibitCell.h"
#import "WorksDetailsViewController.h"//作品详情

@interface ExhibitWorksController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>{

    int page;
    BOOL ismore;
    int freepage;
    BOOL freemore;
}
//滚动视图数组
@property (nonatomic,strong)NSMutableArray *dataArr;
//数组
@property (nonatomic,strong)NSMutableArray * detailArr;

@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)UICollectionView * freedomView;

@end

@implementation ExhibitWorksController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavi];
    self.navigationItem.title = @"全部作品";
    [FTShowMessageView showStatusWithMessage:@"Loading..."];
    _dataArr = [[NSMutableArray alloc]init];
    
    page = 1;
    ismore = NO;
    [self creatData];
//    [self creatCollectionView];
 
}
-(NSMutableArray*)dataArray{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}

-(NSMutableArray*)detailArr{
    if (_detailArr == nil) {
        _detailArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _detailArr;
}
-(void)creatData{


    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:@([@"10" intValue]) forKey:@"limit"];
//    if (ismore == YES) {
//        page++;
//        
//        
//        NSLog(@"上啦页数%d",page);
//        [params setValue:@(page) forKey:@"page"];
//    }else{
//        [params setValue:@([@"1" intValue]) forKey:@"page"];
//    }
//
    //人物作品
    [[HttpClient shareInstance] requestApiWithurl:@"task"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"成功%@",response);
        [FTShowMessageView dismiss];
        
        id  dic = [response objectForKey:@"result"];
        NSLog(@"人物作品的%@",dic);
        if (dic == [NSNull null]) {
            if (page >1) {
                [_collectionView.mj_footer endRefreshing];
                [HUD showAlertWithTitle:@"没有更多数据了"];
            }else{
                [HUD showAlertWithTitle:@"暂无数据了"];
            }

        }else{
            for (NSMutableDictionary * subDic in dic) {
                ExhibitModel * model = [[ExhibitModel alloc]init];
                model.imaName = subDic[@"picture"];
                model.time = subDic[@"time"];
                model.collectCount =subDic[@"likes"];
                model.worksName = subDic[@"name"];
                model.works_id = subDic[@"id"];
                model.worksUser_id = subDic[@"user_id"];
                
                [_dataArr addObject:model];
                
                
            }
           [_collectionView reloadData];
            [self creatCollectionView];
        }
     

        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"失败%@",response);
        
    }];
  
}
-(void)creatFreeData{
   
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
//    [params setValue:@([@"10" intValue]) forKey:@"limit"];
//    if (freemore == YES) {
//        freepage++;
//        
//        
//        NSLog(@"上啦页数%d",freepage);
//        [params setValue:@(freepage) forKey:@"page"];
//    }else{
//        [params setValue:@([@"1" intValue]) forKey:@"page"];
//    }
//

    //自由作品
    [[HttpClient shareInstance] requestApiWithurl:@"freedom"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        [FTShowMessageView dismiss];

        id dic = [response objectForKey:@"result"];
        NSLog(@"自由作品的%@",dic);
        if (dic == [NSNull null]) {
            if (freepage >1) {
                [_freedomView.mj_footer endRefreshing];
                [HUD showAlertWithTitle:@"没有更多数据了"];
            }else{
                [HUD showAlertWithTitle:@"暂无数据了"];
            }
            

        }else{
            for (NSMutableDictionary * subDic in dic) {
                ExhibitModel * model = [[ExhibitModel alloc]init];
                 model.imaName = subDic[@"picture"];
                model.time = subDic[@"time"];
                model.collectCount =subDic[@"likes"];
                model.works_id = subDic[@"id"];
                model.worksUser_id = subDic[@"user_id"];
                
                [_detailArr addObject:model];
                
             
                
            }
          [_freedomView reloadData];
        }

  
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"失败%@",response);
      [FTShowMessageView dismissErrorView:@"加载数据失败，请稍后重试"];
        
    }];
    

}

-(void)initNavi{
    UISegmentedControl * seg = [[UISegmentedControl alloc]initWithItems:@[@"任务作品",@"自由作品"]];
    seg.frame=CGRectMake(0, 0, kScreen_Width/2, 30);
    [seg setUserInteractionEnabled:YES];
    [seg addTarget:self  action:@selector(onChange:) forControlEvents:UIControlEventValueChanged];
    seg.selectedSegmentIndex = 0;
    [seg setBackgroundColor:[UIColor whiteColor]];
    seg.tintColor=RGBColor(50, 157, 223);
    self.navigationItem.titleView = seg;
    
    
//    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithImage:LoadImageByName(@"camera_03") style:UIBarButtonItemStylePlain target:self action:@selector(onPhoto)];
//    
//    self.navigationItem.rightBarButtonItem = right;
}

-(void)onPhoto{
    
}
-(void)onChange:(UISegmentedControl *)sender{
    switch (sender.selectedSegmentIndex) {
        case 0:{
            [_freedomView removeFromSuperview];
            if (_dataArr.count!=0) {
                [_dataArr removeAllObjects];
            }
            page = 1;
            ismore = NO;

            [self creatData];
            [self creatCollectionView];
//                UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithImage:LoadImageByName(@"camera_03") style:UIBarButtonItemStylePlain target:self action:@selector(onPhoto)];
//            
//                self.navigationItem.rightBarButtonItem = right;
            

        }
            
            break;
        case 1:{
            [FTShowMessageView showStatusWithMessage:@"Loading..."];
            [_collectionView removeFromSuperview];
            _detailArr = [[NSMutableArray alloc]init];
            if (_detailArr.count!=0) {
                [_detailArr removeAllObjects];
            }
            
            freepage = 1;
            freemore = NO;


            [self creatFreeData];
            [self creatFreedomView];
            self.navigationItem.rightBarButtonItem = nil;

            
            

        }
            
            break;
            
        default:
            break;
    }
  
    
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
    [_collectionView registerClass:[EchibitCell class] forCellWithReuseIdentifier:@"EchibitCell"];
     self.collectionView.alwaysBounceVertical = YES;
    [self.view addSubview:_collectionView];
    
    //刷新
    _collectionView.mj_header = [FTRefreshGifHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            ismore =NO;
            if (self.dataArr.count !=0) {
                [self.dataArr removeAllObjects];
            }
            [self creatData];
            
            

//            [_collectionView reloadData];
            
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_collectionView.mj_header endRefreshing];
        });
        
        
    }];
    _collectionView.mj_footer = [FTRefreshGifFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //ismore = YES;
//            [self creatData];
            // 刷新表格
            //[_collectionView reloadData];
            
            
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_collectionView.mj_footer endRefreshing];
        });
        
        
    }];

    
}
-(void)creatFreedomView{
    UICollectionViewFlowLayout * layout =[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((kScreen_Width-20)/3,kScreen_Height/4-15);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing=0;
    
    layout.sectionInset = UIEdgeInsetsMake(5,5,5,5);
    
    _freedomView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _freedomView.delegate = self;
    _freedomView.dataSource = self;
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    self.freedomView.alwaysBounceVertical = YES;
    _freedomView.backgroundColor=[UIColor whiteColor];
    [_freedomView registerClass:[EchibitCell class] forCellWithReuseIdentifier:@"EchibitCell"];
    [self.view addSubview:_freedomView];
    
    //刷新
    _freedomView.mj_header = [FTRefreshGifHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            freemore =NO;
            if (self.detailArr.count !=0) {
                [self.detailArr removeAllObjects];
            }
            [self creatFreeData];
            

           // [_freedomView reloadData];
            
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_freedomView.mj_header endRefreshing];
            
        });
        
        
    }];
    _freedomView.mj_footer = [FTRefreshGifFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
           // freemore = YES;
//            [self creatFreeData];
            // 刷新表格
           // [_freedomView reloadData];
            
            
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_freedomView.mj_footer endRefreshing];
        });
        
        
    }];
    


}
- (NSInteger)collectionView:( UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == _collectionView) {
        return _dataArr.count;
    }else{
        return _detailArr.count;

    }
    }
- (UICollectionViewCell*)collectionView:( UICollectionView *)collectionView cellForItemAtIndexPath:( NSIndexPath *)indexPath{
    EchibitCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EchibitCell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
   
    //NSLog(@"数组中的上品为%@",_dataArr);
    if (collectionView == _collectionView) {
        cell.exhibit = _dataArr[indexPath.row];
    }else{
        cell.exhibit = _detailArr[indexPath.row];
    }
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    ExhibitModel * model =_exhibitArr[tag];
    if (collectionView == _collectionView) {
        ExhibitModel * model =_dataArr[indexPath.row];
        WorksDetailsViewController * works = [[WorksDetailsViewController alloc]init];
            works.user_id = model.worksUser_id;
            works.works_id = model.works_id;
            works.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:works animated:YES];

    }else{
        ExhibitModel * model =_detailArr[indexPath.row];
        WorksDetailsViewController * works = [[WorksDetailsViewController alloc]init];
        works.user_id = model.worksUser_id;
        works.works_id = model.works_id;
        works.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:works animated:YES];

    }

}
- (NSInteger)numberOfSectionsInCollectionView:( UICollectionView *)collectionView{
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
