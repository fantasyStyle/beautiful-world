//
//  ShoppingCentreController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/1.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "ShoppingCentreController.h"

#import "RecommendHeadView.h"
#import "SDRotationLoopProgressView.h"
#import "RecommendTableCell.h"
#import "GoodsModel.h"
#import "GoodsShoppingController.h"
#import "CustJourHeadView.h"
#import "BuyViewController.h"
#import "GoodsDetailViewController.h"
#import "GoodsDetailViewController.h"
#import "BackpackViewController.h"//背包
#import "ShopPayView.h"
#import <objc/runtime.h>
#import "BuyRecordController.h"//更多
#import "ResourceBuyController.h"
@interface ShoppingCentreController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,RecommendTableCellDelegate>{
    NSMutableArray *_imageArray;//图片数组
    
    NSMutableArray * _shopArray;
    SDRotationLoopProgressView *_LoadView;
    CustJourHeadView *_CellHeadView;

    
    NSMutableArray * topImaArr;
    NSMutableArray * topIDArr;
    
      ShopPayView * payView;
     UIView *backgroundView;
    NSMutableArray * headIconArray;
    NSMutableArray * biankuangArray;
    NSMutableArray * giftArray;
    NSMutableArray * recommendArray;
    
        LoadFailView * failView;
    

}

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * dataArray;


@end

@implementation ShoppingCentreController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"饰品屋";
     [FTShowMessageView showStatusWithMessage:@"Loading..."];
     // [self creatsSearchBar];
    // [self showLoadView];
    [self loadShopData];
    


    // Do any additional setup after loading the view.
}
-(void)loadShopData{
    
    _dataArray = [[NSMutableArray alloc]init];
    recommendArray = [[NSMutableArray alloc]init];

    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
    
    [params1 setValue:@([@"3" intValue]) forKey:@"limit"];
    //推荐
    [[HttpClient shareInstance] requestApiWithurl:@"shoprecommend"  parmar:params1 success:^(NSURLSessionDataTask *task, id response) {
        //NSLog(@"成功%@",response);
        NSMutableArray * dic = [response objectForKey:@"result"];
        NSLog(@"商城推荐的的%@",dic);
        for (NSMutableDictionary * subDic in dic) {
            GoodsModel * good = [[GoodsModel alloc]init];
            good.goodsImage =subDic[@"picture"];
            good.goodsTitle = subDic[@"name"];
            good.goodsPrice = subDic[@"money"];
            good.goodsType = subDic[@"state"];
            good.goods_id  = subDic[@"id"];
            good.goods_state =subDic[@"state"];
            good.goods_typeID  =subDic[@"type_id"];
            [recommendArray addObject:good];
            [_tableView reloadData];
        }
          [_dataArray addObject:recommendArray];
        [self loadHeadData];
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"商城推荐的失败%@",response);
        [FTShowMessageView dismiss];
        failView = [[LoadFailView alloc]init];
        [failView.retryBtn addTarget:self action:@selector(retry) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:failView];
        

        
    }];
    
    
    
}
-(void)loadHeadData{
    //头像
    headIconArray = [[NSMutableArray alloc]init];
    NSMutableDictionary *head = [NSMutableDictionary dictionary];
    
    [head setValue:@([@"3" intValue]) forKey:@"limit"];
    
    [head setValue:@"10" forKey:@"type_id"];
    
    [[HttpClient shareInstance] requestApiWithurl:@"gift"  parmar:head success:^(NSURLSessionDataTask *task, id response) {
        //NSLog(@"成功%@",response);
        NSMutableArray * dic = [response objectForKey:@"result"];
        NSLog(@"商城头像的的%@",dic);
        for (NSMutableDictionary * subDic in dic) {
            GoodsModel * good = [[GoodsModel alloc]init];
            good.goodsImage =subDic[@"picture"];
            good.goodsTitle = subDic[@"name"];
            good.goodsPrice = subDic[@"money"];
            good.goodsType = subDic[@"state"];
            good.goods_id  = subDic[@"id"];
             good.goods_state =subDic[@"state"];
            good.goods_typeID  =subDic[@"type_id"];
            [headIconArray addObject:good];
            [_tableView reloadData];
        }
        [_dataArray addObject:headIconArray];
        [self loadFrameData];
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"商城头像的失败%@",response);
        
    }];
    

}
-(void)loadFrameData{
    //边框
      biankuangArray = [[NSMutableArray alloc]init];
    NSMutableDictionary *kuang = [NSMutableDictionary dictionary];
    
    [kuang setValue:@([@"3" intValue]) forKey:@"limit"];
    
    [kuang setValue:@"11" forKey:@"type_id"];
    
    [[HttpClient shareInstance] requestApiWithurl:@"gift"  parmar:kuang success:^(NSURLSessionDataTask *task, id response) {
        //NSLog(@"成功%@",response);
        NSMutableArray * dic = [response objectForKey:@"result"];
        NSLog(@"商城边框的的%@",dic);
        for (NSMutableDictionary * subDic in dic) {
            GoodsModel * good = [[GoodsModel alloc]init];
            good.goodsImage =subDic[@"picture"];
            good.goodsTitle = subDic[@"name"];
            good.goodsPrice = subDic[@"money"];
            good.goodsType = subDic[@"state"];
            good.goods_id  = subDic[@"id"];
            good.goods_typeID  =subDic[@"type_id"];
             good.goods_state =subDic[@"state"];
            [biankuangArray addObject:good];
            [_tableView reloadData];
        }
        [_dataArray addObject:biankuangArray];
        [self loadGiftData];
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"商城边框的失败%@",response);
        
    }];

}
-(void)loadGiftData{
     giftArray = [[NSMutableArray alloc]init];
    //礼物
    NSMutableDictionary *gift = [NSMutableDictionary dictionary];
    
    [gift setValue:@([@"3" intValue]) forKey:@"limit"];
    
    [gift setValue:@"12" forKey:@"type_id"];
    [[HttpClient shareInstance] requestApiWithurl:@"gift"  parmar:gift success:^(NSURLSessionDataTask *task, id response) {
        //NSLog(@"成功%@",response);
  
        
        NSMutableArray * dic = [response objectForKey:@"result"];
        NSLog(@"商城礼物的的%@",dic);
        for (NSMutableDictionary * subDic in dic) {
            GoodsModel * good = [[GoodsModel alloc]init];
            good.goodsImage =subDic[@"picture"];
            good.goodsTitle = subDic[@"name"];
            good.goodsPrice = subDic[@"money"];
            good.goodsType = subDic[@"state"];
            good.goods_id  = subDic[@"id"];
            good.goods_typeID  =subDic[@"type_id"];
             good.goods_state =subDic[@"state"];
            [giftArray addObject:good];
            [_tableView reloadData];
        }
        [FTShowMessageView dismiss];
       
        [self initTableView];
        [_dataArray addObject:giftArray];
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"商城礼物的失败%@",response);
        [FTShowMessageView dismiss];
        failView = [[LoadFailView alloc]init];
        [failView.retryBtn addTarget:self action:@selector(retry) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:failView];
        
        
    }];

}
-(void)retry{
    [FTShowMessageView showStatusWithMessage:@"Loading..."];
    
    
    [self loadShopData];
}
- (void)creatsSearchBar
{
    
    UIView * searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, NavBar_Height)];
    searchView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:searchView];
    // 创建UISearchBar对象
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 40)];
    
    // 设置Prompt提示
    // [searchBar setPrompt:@"查找图书"];
    // 设置没有输入时的提示占位符
    [_searchBar setPlaceholder:@"搜索"];
    // 显示Cancel按钮
    //_searchBar.showsCancelButton = true;
    // 设置代理
    _searchBar.delegate = self;
    [self.view addSubview:_searchBar];
    //_songTableView.tableHeaderView = _searchBar;
    
}
-(void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-NavBar_Height*2-StatusBar_Height) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate =self;
   
    _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    

    
    
    //刷新
    _tableView.mj_header = [FTRefreshGifHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [FTShowMessageView showStatusWithMessage:@"Loading..."];
            //   [self loadShopData];
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

-(void)onClickGoods:(UITapGestureRecognizer *)tap{
    NSLog(@"选择的商品是%ld",(long)tap.view.tag);
    GoodsShoppingController * goods = [[GoodsShoppingController alloc]init];
    goods.hidesBottomBarWhenPushed = YES;

    
    if ([[UserInfo sharedUserInfo].isLogin isEqualToString:@"0"]) {
       [HUD showAlertWithTitle:@"敬请登录"];        //
    }else{
              [self.navigationController pushViewController:goods animated:NO];
    }
    

    switch (tap.view.tag) {
        case 10:
        {
            
        }
            break;
        case 11:
        {
            
        }
            break;
            
        case 12:
        {
            
        }
            break;
            
        case 13:
        {
            
        }
            break;
            
                   
        default:
            break;
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
       return 4;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return kScreen_Height/6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identfire=@"shaopTableCell";
    
    RecommendTableCell *cell=[tableView dequeueReusableCellWithIdentifier:identfire];
    
//    if (!cell) {
//        
        cell=[[RecommendTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfire];
//    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    //NSArray *array=_ChanelDataArray[indexPath.section-1];
    
   // cell.modelArray=self.dataArray[indexPath.section];
    if (indexPath.section == 0) {
        cell.modelArray = recommendArray;
    }
    if (indexPath.section == 1) {
        cell.modelArray = headIconArray;
    }

    if (indexPath.section == 2) {
        cell.modelArray = biankuangArray;
    }

    if (indexPath.section == 3) {
        cell.modelArray = giftArray;
    }

    
    cell.delegate=self;
    cell.tags=(int)indexPath.section;
    cell.backgroundColor = [UIColor greenColor];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    _CellHeadView=[[CustJourHeadView alloc]init];
    _CellHeadView.moreIma.tag=section;
    //_CellHeadView.tag = section;
    
    
    if (section==0) {
        _CellHeadView.titleLab.text=@"推荐";
        _CellHeadView.lineView.backgroundColor = lineYellow;
        _CellHeadView.titleLab.textColor = lineYellow;
        
    }

    if (section==1) {
        _CellHeadView.titleLab.text=@"头像";
        _CellHeadView.lineView.backgroundColor = lineYellow;
        _CellHeadView.titleLab.textColor = lineYellow;
        
            }
    if (section==2) {
        _CellHeadView.titleLab.text=@"边框";
        _CellHeadView.lineView.backgroundColor = lineYellow;
        _CellHeadView.titleLab.textColor = lineYellow;
        
    }
    

    if (section==3) {
        _CellHeadView.titleLab.text=@"礼物";
        _CellHeadView.lineView.backgroundColor = lineYellow;
        _CellHeadView.titleLab.textColor = lineYellow;
        
    }
    
    [_CellHeadView.moreIma addTapTraget:self withAction:@selector(onMore:)];
    
    return _CellHeadView;
}



-(void)onMore:(UIGestureRecognizer*)sender
{
    
    NSLog(@"点击饿了更多");
    BuyRecordController * moreGoods = [[BuyRecordController alloc]init];
    moreGoods.clickType = @"1";
    moreGoods.hidesBottomBarWhenPushed = YES;
    switch (sender.view.tag) {
        case 0:
        {
            moreGoods.shop_URL = @"shopRecommend";
            moreGoods.type_ID = nil;
            moreGoods.navigationItem.title = @"推荐";
        }
            break;
        case 1:
        {
            moreGoods.shop_URL = @"gift";
            moreGoods.type_ID = @"10";
            moreGoods.navigationItem.title = @"头像";
        }
            break;
        case 2:
        {
            moreGoods.shop_URL = @"gift";
            moreGoods.type_ID = @"11";
            moreGoods.navigationItem.title = @"边框";
        }
            break;
        case 3:
        {
            moreGoods.shop_URL = @"gift";
            moreGoods.type_ID = @"12";
            moreGoods.navigationItem.title = @"礼物";
        }
            break;
            
        default:
            break;
    }
    if ([[UserInfo sharedUserInfo].isLogin isEqualToString:@"0"]) {
        [HUD showAlertWithTitle:@"敬请登录"];        //
    }else{
        [self.navigationController pushViewController:moreGoods animated:YES];
        
        
    }
    

    
}
-(void)hidenLoadView
{
    [UIView animateWithDuration:0.3 animations:^{
        
        [_LoadView removeFromSuperview];
        
    }];
}

-(void)showLoadView
{
    _LoadView=[SDRotationLoopProgressView progressView];
    
    _LoadView.frame=CGRectMake(0, 0, kScreen_Width/5, kScreen_Width/5);
    
    _LoadView.center=self.view.center;
    
    [self.view addSubview: _LoadView ];
    
}
-(void)TapRecommendTableCellDelegate:(GoodsModel *)chaneldata
{
    
    if ([[UserInfo sharedUserInfo].isLogin isEqualToString:@"0"]) {
      [HUD showAlertWithTitle:@"敬请登录"];        //
    }else{
         payView = [[ShopPayView alloc]init];
        NSLog(@"商品的价格%@支付类型%@",chaneldata.goodsPrice,chaneldata.goodsType);
        payView.payCountLab.text = [NSString stringWithFormat:@"x%@",chaneldata.goodsPrice];
        if ([chaneldata.goodsType isEqualToString:@"0"]) {
            [payView initPayViewWithCount:chaneldata.goodsPrice AndPayType:@"jinbi_04" AndGoodName:chaneldata.goodsTitle AndGoodIma:chaneldata.goodsImage];
        }else{
            [payView initPayViewWithCount:chaneldata.goodsPrice AndPayType:@"zuan_03"  AndGoodName:chaneldata.goodsTitle AndGoodIma:chaneldata.goodsImage];
            
        }
        
        
        [payView.cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        backgroundView = [[UIView alloc] init];
        
        //
        objc_setAssociatedObject(payView.payBtn, "firstObject", chaneldata, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [payView.payBtn addTarget:self action:@selector(payClick:) forControlEvents:UIControlEventTouchUpInside];
        backgroundView.frame = CGRectMake(0, 0,kScreen_Width,kScreen_Height);
        backgroundView.backgroundColor  =  [[UIColor blackColor]colorWithAlphaComponent:0.4f];
        [self.view addSubview:backgroundView];
        [backgroundView addSubview:payView];

    }
    

   
 

//    GoodsDetailViewController * goods = [[GoodsDetailViewController alloc]init];
//    goods.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:goods animated:YES];
//    
}
-(void)payClick:(UIButton*)sender{
    [FTShowMessageView showStatusWithMessage:@"Loading..."];
    GoodsModel * model = objc_getAssociatedObject(sender, "firstObject");
//    NSLog(@"获取到的数据%@",payView.payCountLab.text);
    NSString * strfee = [payView.payCountLab.text substringFromIndex:1];

    NSLog(@"获取到的总价%@商品%@个数%@",strfee,model.goodsType,payView.TF.text);
    
    //发起支付接口
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:model.goodsTitle forKey:@"name"];
    [params setValue:@"0" forKey:@"price"];
    [params setValue:@"1" forKey:@"number"];
    [params setValue:@"0" forKey:@"allprice"];
    [params setValue:model.goodsImage forKey:@"picture"];
    [params setValue:model.goods_typeID forKey:@"type_id"];
    [params setValue:model.goods_state forKey:@"state"];
    
    
    //顶部
    [[HttpClient shareInstance] requestApiWithurl:@"buyGoods"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        NSMutableDictionary * dic = [response objectForKey:@"result"];
        NSLog(@"购买结果的%@",dic);
        [FTShowMessageView dismiss];
        NSString * str = [NSString stringWithFormat:@"%@",dic[@"jewel"]];
        if ([str isEqualToString:@"1"]) {
                [payView.payView removeFromSuperview];
                [payView.cancelBtn removeFromSuperview];
                [payView.payBtn removeFromSuperview];
                [payView.headIcon removeFromSuperview];
                [payView.NameLab removeFromSuperview];
                //[payView removeAllSubviews];
            if ([model.goodsType isEqualToString:@"0"]) {
                [payView initOKViewWithPayType:@"jinbi_04" AndGoodName:model.goodsTitle AndGoodIma:model.goodsImage AndFee:strfee];
            }else{
                [payView initOKViewWithPayType:@"zuan_03" AndGoodName:model.goodsTitle AndGoodIma:model.goodsImage AndFee:strfee];
            }

            
                [payView.leftBtn addTarget:self action:@selector(goBackClick) forControlEvents:UIControlEventTouchUpInside];
                [payView.rightBtn addTarget:self action:@selector(backShop) forControlEvents:UIControlEventTouchUpInside];

        }else{
            [HUD showAlertWithTitle:@"您的余额不足！请充值"];
            ResourceBuyController * buy = [[ResourceBuyController alloc]init];
            buy.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:buy animated:YES];
        }
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        [FTShowMessageView dismiss];
        failView = [[LoadFailView alloc]init];
        [failView.retryBtn addTarget:self action:@selector(retry) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:failView];
        
        
    }];


    
}
-(void)goBackClick{
    [self backShop];
    BackpackViewController * pack = [[BackpackViewController alloc]init];
    pack.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pack animated:YES];
    
}
-(void)backShop{
    [payView removeFromSuperview];
    [self cancel];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    //顶部
    [[HttpClient shareInstance] requestApiWithurl:@"Myresource"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        id  dic = [response objectForKey:@"result"];
        [FTShowMessageView dismiss];

        if (dic == [NSNull null]) {
            
        }else{
            NSMutableDictionary * subdic = dic[0];
       
            [UserInfo sharedUserInfo].userJewel =subdic[@"jewel"];
            [UserInfo sharedUserInfo].userGold =subdic[@"gold"];
            [[UserInfo sharedUserInfo]saveUserInofFromSanbox];
     
          
            [[NSNotificationCenter defaultCenter] postNotificationName:@"personInfo" object:nil userInfo:nil];
            
            
        }
    } failuer:^(NSURLSessionDataTask *task, id response) {
        [FTShowMessageView dismiss];
        
    }];


}
-(void)cancel{
    [backgroundView removeFromSuperview];
}


@end
