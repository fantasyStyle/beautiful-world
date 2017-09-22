//
//  BuyRecordController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/17.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "BuyRecordController.h"
#import "BuyRecordViewCell.h"
#import "ResourceBuyController.h"
#import "BackpackViewController.h"
@interface BuyRecordController ()<UITableViewDelegate,UITableViewDataSource>{
          ShopPayView * payView;
    UIView *backgroundView;
    int page;
    BOOL ismore;
    
}
@property (nonatomic,strong)UITableView * myTable;
@property (nonatomic,strong)NSMutableArray * dataArr;

@end

@implementation BuyRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(235, 235, 241);
      [FTShowMessageView showStatusWithMessage:@"Loading..."];
     _dataArr = [NSMutableArray array];
    page = 1;
    ismore = NO;
   
    [self loadData];
    [self creatTable];

   

}
//-(NSMutableArray *)dataArr{
//    if (!_dataArr ) {
//        _dataArr = [NSMutableArray arrayWithCapacity:0];
//        
//    }
//    return _dataArr;
//}
-(void)loadData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:@([@"10" intValue]) forKey:@"limit"];
    if (self.type_ID) {
          [params setValue:self.type_ID forKey:@"type_id"];
    }
    if (self.user_id) {
        [params setValue:self.user_id forKey:@"user_id"];
    }
    if (ismore == YES) {
        page++;
        NSLog(@"上啦页数%d",page);
        [params setValue:@(page) forKey:@"page"];
    }else{
        [params setValue:@([@"1" intValue]) forKey:@"page"];
    }

    
  


    [[HttpClient shareInstance] requestApiWithurl:self.shop_URL  parmar:params success:^(NSURLSessionDataTask *task, id response) {
      [FTShowMessageView dismiss];
        id  dic = [response objectForKey:@"result"];
        if (dic == [NSNull null]) {
            if (page >1) {
                [_myTable.mj_footer endRefreshing];
                [HUD showAlertWithTitle:@"没有更多数据了"];
            }else{
                [HUD showAlertWithTitle:@"暂无数据了"];
            }
            
            
        }
        else{
            for (NSMutableDictionary * subDic in dic) {
                
                RecordModel * model = [[RecordModel alloc]init];
                model.imaName = subDic[@"picture"];
                model.titleName =  subDic[@"name"];
                model.pay_id = subDic[@"id"];
                model.goods_typeID = subDic[@"type_id"];
                if (subDic[@"price"]) {
                    model.price = [NSString stringWithFormat:@"%@",subDic[@"price"]];
                }else{
                    model.price = [NSString stringWithFormat:@"%@",subDic[@"money"]];
                }
                if (subDic[@"state"] != [NSNull null]) {
                    model.payType = subDic[@"state"];
                    NSLog(@"%@",subDic[@"state"]);
                }else{
                    model.payType = @"0";
                }
                
                
                if (self.user_id && self.timeIsHide) {
                    model.time  = subDic[@"time"];
                }
                
                
                [_dataArr addObject:model];
            }
            [_myTable reloadData];

        }
        
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"更多的失败%@",response);
        
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
            [FTShowMessageView showStatusWithMessage:@"Loading..."];
            ismore =NO;
            if (self.dataArr.count !=0) {
                [self.dataArr removeAllObjects];
            }

            [self loadData];
           

            [_myTable reloadData];

            dispatch_main_sync_safe(^{
                [FTShowMessageView dismissSuccessView:@"Success"];
            });
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_myTable.mj_header endRefreshing];
            
        });
        
        
    }];
    _myTable.mj_footer = [FTRefreshGifFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 刷新表格

            
            ismore = YES;
            [self loadData];
           [_myTable reloadData];
            
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_myTable.mj_footer endRefreshing];
        });
        
        
    }];


}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
    
    
    NSLog(@"交易记录的数据%@",self.dataArr);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellId= @"recordcell";
    BuyRecordViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[BuyRecordViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.record = self.dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreen_Height/7;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //头像选择
    if ([self.clickType isEqualToString:@"0"]) {
        [self.navigationController popViewControllerAnimated:YES];
        RecordModel * model = _dataArr[indexPath.row];
        [UserInfo sharedUserInfo].iconUser = model.imaName;
    }
    //商城购买
    if ([self.clickType isEqualToString:@"1"]) {
        RecordModel * model = _dataArr[indexPath.row];
        payView = [[ShopPayView alloc]init];
//        NSLog(@"商品的价格%@支付类型%@",chaneldata.goodsPrice,chaneldata.goodsType);
        payView.payCountLab.text = [NSString stringWithFormat:@"x%@",model.price];
        if ([model.payType isEqualToString:@"0"]) {
            [payView initPayViewWithCount:model.price AndPayType:@"jinbi_04" AndGoodName:model.titleName AndGoodIma:model.imaName];
        }else{
            [payView initPayViewWithCount:model.price AndPayType:@"zuan_03" AndGoodName:model.titleName AndGoodIma:model.imaName];
            
        }
        
        
        [payView.cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        backgroundView = [[UIView alloc] init];
        
        //
        objc_setAssociatedObject(payView.payBtn, "firstObject", model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [payView.payBtn addTarget:self action:@selector(payClick:) forControlEvents:UIControlEventTouchUpInside];
        backgroundView.frame = CGRectMake(0, 0,kScreen_Width,kScreen_Height);
        backgroundView.backgroundColor  =  [[UIColor blackColor]colorWithAlphaComponent:0.4f];
        [self.view addSubview:backgroundView];
        [backgroundView addSubview:payView];
        

    }
}
-(void)payClick:(UIButton*)sender{
    [FTShowMessageView showStatusWithMessage:@"Loading..."];
    RecordModel * model  = objc_getAssociatedObject(sender, "firstObject");
    //    NSLog(@"获取到的数据%@",payView.payCountLab.text);
    NSString * strfee = [payView.payCountLab.text substringFromIndex:1];
    
    //NSLog(@"获取到的总价%@商品%@个数%@",str,model.goodsType,payView.TF.text);
    
    //发起支付接口
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:model.titleName forKey:@"name"];
    [params setValue:model.pay_id forKey:@"id"];
    [params setValue:@"0" forKey:@"price"];
    [params setValue:@"1" forKey:@"number"];
    [params setValue:@"0" forKey:@"allprice"];
    [params setValue:model.imaName forKey:@"picture"];
    [params setValue:model.goods_typeID forKey:@"type_id"];
    [params setValue:model.payType forKey:@"state"];
    
    NSLog(@"名字%@ID%@价格%@个数%@str%@图片%@类型%@",model.titleName,model.pay_id,model.price,payView.TF.text,strfee,model.imaName,model.goods_typeID);
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
            if ([model.payType isEqualToString:@"0"]) {
                [payView initOKViewWithPayType:@"jinbi_04" AndGoodName:model.titleName AndGoodIma:model.imaName AndFee:strfee];
            }else{
                [payView initOKViewWithPayType:@"zuan_03" AndGoodName:model.titleName AndGoodIma:model.imaName AndFee:strfee];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
