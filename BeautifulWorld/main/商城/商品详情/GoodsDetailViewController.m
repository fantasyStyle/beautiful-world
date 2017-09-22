//
//  GoodsDetailViewController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/15.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "BottomView.h"
#import "RelatedGoodsCell.h"
#import "CommentTableViewCell.h"
#import "CustJourHeadView.h"
#import "SDCycleScrollView.h"
#import "PayStyleViewController.h"
#import "ShopBasketController.h"

@interface GoodsDetailViewController ()<UITableViewDelegate,UITableViewDataSource,CommentTableViewCellDelegate,SDCycleScrollViewDelegate>
{
     BottomView *bottomView;
    UIView * headView;
    CustJourHeadView * cellHeadView;
    
}
@property(nonatomic,strong)SDCycleScrollView * topView;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,strong)NSMutableArray * souceArr;
@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"商品详情";
    [self loadData];
    [self createUI];
    [self initBottomView];

    // Do any additional setup after loading the view.
}
-(void)initBottomView
{
    bottomView = [[BottomView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-64-47, self.view.frame.size.width, 47)];
    [self.view addSubview:bottomView];
    [bottomView.bt_service addTarget:self action:@selector(seleteService) forControlEvents:UIControlEventTouchUpInside];
    [bottomView.bt_shop addTarget:self action:@selector(seleteShop) forControlEvents:UIControlEventTouchUpInside];
    [bottomView.bt_collection addTarget:self action:@selector(seleteCollection:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView.bt_addBasket addTarget:self action:@selector(addBasket) forControlEvents:UIControlEventTouchUpInside];
    [bottomView.bt_buyNow addTarget:self action:@selector(seleteBuy) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 懒加载
-(NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _dataArr;
}
-(NSMutableArray *)souceArr{
    if (_souceArr == nil) {
        _souceArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _souceArr;
}
-(void)createUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height -NavBar_Height - StatusBar_Height-47)style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    UIView * tabHead = [[UIView alloc]init];
    tabHead.frame =CGRectMake(0, 0, kScreen_Width, kScreen_Height/5*2);
   // tabHead.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = tabHead;

    
    [_tableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"CommentTableViewCell"];
    [self.view addSubview:_tableView];
    
    NSMutableArray * imageArr =[[NSMutableArray alloc]initWithObjects:@"WechatIMG24",@"WechatIMG29",@"WechatIMG30", nil];
    _topView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 10, kScreen_Width, tabHead.frame.size.height/5*3) imageNamesGroup:imageArr];
    //_topView.titlesGroup=_titleArray;
    _topView.placeholderImage=[UIImage imageNamed:@"Img_default"];
    _topView.delegate=self;
    _topView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    _topView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _topView.titleLabelTextFont=[UIFont systemFontOfSize:17];
    [tabHead addSubview:_topView];
    
    UIView * middleView = [[UIView alloc]initWithFrame:CGRectMake(0, 10+_topView.frame.size.height, kScreen_Width, tabHead.frame.size.height - _topView.frame.size.height-10)];
    middleView.backgroundColor = [UIColor whiteColor];
    [tabHead addSubview:middleView];
    
    UILabel * goodsName = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, kScreen_Width/3, 20)];
    goodsName.font = font15;
    goodsName.text = @"中盛画材";
    [middleView addSubview:goodsName];
    
    
    
    UILabel * goodsDetail = [[UILabel alloc]init];
    goodsDetail.frame = CGRectMake(10, 26, kScreen_Width-20, 50);
    goodsDetail.text = @"画材精品画材精品画材精品画材精品画材精品画材精品画材精品画材精品画材精品v画材精品画材精品画材精品画材精品画材精品画材精品画材精品画材精品画材精品画材精品画材精品画材精品画材精品";
    goodsDetail.font = font12;
    goodsDetail.numberOfLines = 3;
    goodsDetail.textColor = [UIColor darkGrayColor];
    [middleView addSubview:goodsDetail];
    
    UILabel * priceLab = [[UILabel alloc]init];
    priceLab.frame = CGRectMake(10,middleView.frame.size.height - 25, kScreen_Width/3, 20);
    priceLab.textColor  = [UIColor redColor];
    priceLab.text = @"¥ 1000";
    priceLab.font =font13;
    [middleView addSubview:priceLab];
    
    
    UILabel * buyCount = [[UILabel alloc]init];
    buyCount.textColor = [UIColor darkGrayColor];
    buyCount.frame = CGRectMake(kScreen_Width-90, priceLab.y, 80, 20);
    buyCount.text = @"销量：10";
    buyCount.font = font13;
    [middleView addSubview:buyCount];
    

    
 }
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        if (section == 0) {
            return 1;
        }else{
    return  self.souceArr.count ;
       }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
         if (indexPath.section == 0) {
             RelatedGoodsCell * goods = [tableView dequeueReusableCellWithIdentifier:@"RelatedGoodsCell"];
             if (!goods) {
                 goods = [[RelatedGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RelatedGoodsCell"];
             }
             goods.relatedGoods =self.dataArr[indexPath.row];
    
        goods.selectionStyle = UITableViewCellSelectionStyleNone;
    
            return goods;
        }else{
    CommentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CommentTableViewCell" forIndexPath:indexPath];
    cell.delegate = self;
    [cell setContents:self.souceArr[indexPath.row]];
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    return cell;
    
       }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.section == 0) {
            return kScreen_Height/6;
        }else{
    return [CommentTableViewCell cellHeight:self.souceArr[indexPath.row ]];
    
        }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    cellHeadView  = [[CustJourHeadView alloc]init];
    
    if (section==0) {
        
        cellHeadView.titleLab.text=@"相关推荐";
        cellHeadView.lineView.backgroundColor = RGBColor(191, 141, 12);
        cellHeadView.titleLab.textColor =RGBColor(191, 141, 12);
        
        
        
    }else{
        cellHeadView.titleLab.text=@"全部评论";
        cellHeadView.lineView.backgroundColor = lineBlue;
        cellHeadView.titleLab.textColor =lineBlue;
        
        
        
    }

    return cellHeadView;
}
#pragma mark - 加载数据
-(void)loadData{
    
    RelatedGoodsModel * good = [[RelatedGoodsModel alloc]init];
    good.goods1 = @"动态1";
    good.goods2 = @"动态2";
    good.goods3 = @"动态3";
    [self.dataArr addObject:good];
    
    
    commentModel * comment1 = [[commentModel alloc]init];
    comment1.icon = @"用户3";
    comment1.title = @"布兰妮";
    comment1.date = @"10分钟前";
    comment1.detail = @"这期内容非常好";
    comment1.number = @"23";
    [self.souceArr addObject:comment1];
    commentModel * comment2 = [[commentModel alloc]init];
    comment2.icon = @"用户2";
    comment2.title = @"艾薇儿";
    comment2.date = @"45分钟前";
    comment2.detail = @"孩子之间的冲突时如何发生的,孩子之间的冲突时如何发生的这期内容非常好,重要的事情说三遍，重要的事情说三遍，重要的事情说三遍";
    comment2.number = @"12";
    [self.souceArr addObject:comment2];
}

#pragma mark-bottom action
-(void)seleteService
{
    [self showAlert:@"点击客服"];
}
-(void)seleteShop
{
    [self showAlert:@"进入店铺"];
}
-(void)seleteCollection:(UIButton *)btn
{
    if (btn.selected) {
        btn.selected = NO;
        [self showAlert:@"取消收藏"];
    }else
    {
        btn.selected = YES;
        [self showAlert:@"已收藏"];
    }
}
-(void)seleteBuy
{
    //[self showAlert:@"立即购买"];
    PayStyleViewController * pay = [[PayStyleViewController alloc]init];
    [self.navigationController pushViewController:pay animated:YES];
}
-(void)addBasket{
    ShopBasketController * basket = [[ShopBasketController alloc]init];
    [self.navigationController pushViewController:basket animated:YES];
    
   
}
#pragma mark-goosdetail action
-(void)share
{
    [self showAlert:@"分享"];
}
-(void)goodsJudge
{
    [self showAlert:@"宝贝评价"];
}
-(void)showAlert:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
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
