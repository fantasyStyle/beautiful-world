//
//  ShopBasketController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/16.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "ShopBasketController.h"
#import "CartBottomView.h"
#import "addressViewController.h"
#import "MyCustomCell.h"
#import "GoodsInfoModel.h"
@interface ShopBasketController ()<BottomViewDelegate,UITableViewDataSource,UITableViewDelegate,MyCustomCellDelegate>{
    UITableView *_MyTableView;
    float allPrice;
    NSMutableArray *infoArr;
    NSMutableDictionary * info;
}


@property (nonatomic, strong)CartBottomView *AccountView;

@property(strong,nonatomic)UIButton *allSelectBtn;
@property(strong,nonatomic)UILabel *allPriceLab;
@end

@implementation ShopBasketController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化数据
    allPrice = 0.0;
    infoArr = [[NSMutableArray alloc]init];
    /**
     *  初始化一个数组，数组里面放字典。字典里面放的是单元格需要展示的数据
     */
    for (int i = 0; i<2; i++)
    {
        NSMutableDictionary *infoDict = [[NSMutableDictionary alloc]init];
        [infoDict setValue:@"img6.png" forKey:@"imageName"];
        [infoDict setValue:@"最新的画纸，同学们都在用" forKey:@"goodsTitle"];
        [infoDict setValue:@"画纸" forKey:@"goodsName"];
        [infoDict setValue:@"2000" forKey:@"goodsPrice"];
        [infoDict setValue:[NSNumber numberWithBool:NO] forKey:@"selectState"];
        [infoDict setValue:[NSNumber numberWithInt:1] forKey:@"goodsNum"];
        
        //封装数据模型
        GoodsInfoModel *goodsModel = [[GoodsInfoModel alloc]initWithDict:infoDict];
        
        //将数据模型放入数组中
        [infoArr addObject:goodsModel];
    }
    
    /**
     创建表格，并设置代理
     */
    _MyTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _MyTableView.dataSource = self;
    _MyTableView.delegate = self;
     [self.view addSubview:_MyTableView];
    [self AccountsView];


    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//返回单元格个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return infoArr.count;
}
//定制单元格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify =  @"indentify";
    MyCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell)
    {
        cell = [[MyCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.delegate = self;
    }
    //调用方法，给单元格赋值
    [cell addTheValue:infoArr[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//返回单元格的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreen_Height/5;
}

//单元格选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  判断当期是否为选中状态，如果选中状态点击则更改成未选中，如果未选中点击则更改成选中状态
     */
    GoodsInfoModel *model = infoArr[indexPath.row];
    
    if (model.selectState)
    {
        model.selectState = NO;
    }
    else
    {
        model.selectState = YES;
    }
    
    //刷新整个表格
    //    [_MyTableView reloadData];
    
    //刷新当前行
    [_MyTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self totalPrice];
}

///**
// *  全选按钮事件
// *
// *  @param sender 全选按钮
// */
//-(void)selectBtnClick:(UIButton *)sender
//{
//    //判断是否选中，是改成否，否改成是，改变图片状态
//    sender.tag = !sender.tag;
//    if (sender.tag)
//    {
//        [sender setImage:[UIImage imageNamed:@"复选框-选中.png"] forState:UIControlStateNormal];
//        
//    }else{
//        [sender setImage:[UIImage imageNamed:@"复选框-未选中.png"] forState:UIControlStateNormal];
//    }
//    //改变单元格选中状态
//    for (int i=0; i<infoArr.count; i++)
//    {
//        GoodsInfoModel *model = [infoArr objectAtIndex:i];
//        model.selectState = sender.tag;
//    }
//    //计算价格
//    [self totalPrice];
//    //刷新表格
//    [_MyTableView reloadData];
//    
//}

#pragma mark -- 实现加减按钮点击代理事件
/**
 *  实现加减按钮点击代理事件
 *
 *  @param cell 当前单元格
 *  @param flag 按钮标识，11 为减按钮，12为加按钮
 */
-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag
{
    NSIndexPath *index = [_MyTableView indexPathForCell:cell];
    
    switch (flag) {
        case 11:
        {
            //做减法
            //先获取到当期行数据源内容，改变数据源内容，刷新表格
            GoodsInfoModel *model = infoArr[index.row];
            if (model.goodsNum > 1)
            {
                model.goodsNum --;
            }
        }
            break;
        case 12:
        {
            //做加法
            GoodsInfoModel *model = infoArr[index.row];
            
            model.goodsNum ++;
            
        }
            break;
        default:
            break;
    }
    
    //刷新表格
    [_MyTableView reloadData];
    
    //计算总价
    [self totalPrice];
    
}

#pragma mark -- 计算价格
-(void)totalPrice
{
    //遍历整个数据源，然后判断如果是选中的商品，就计算价格（单价 * 商品数量）
    for ( int i =0; i<infoArr.count; i++)
    {
        GoodsInfoModel *model = [infoArr objectAtIndex:i];
        if (model.selectState)
        {
            allPrice = allPrice + model.goodsNum *[model.goodsPrice intValue];
        }
    }
    
    //给总价文本赋值
    NSString * str = [NSString stringWithFormat:@"%.2f",allPrice];
    info = [[NSMutableDictionary alloc]init];
    [info setValue:str forKey:@"Data"];
  
    [self postCenter];
    
    //每次算完要重置为0，因为每次的都是全部循环算一遍
    allPrice = 0.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  底部结账栏
 */
-(void)AccountsView
{
    self.AccountView = [[CartBottomView alloc]initWithFrame:CGRectMake(0, kScreen_Width -NavBar_Height-StatusBar_Height - 44, kScreen_Width, 44)];
    self.AccountView.backgroundColor = [UIColor whiteColor];
    self.AccountView.AllSelected = YES;
    self.AccountView.delegate = self;
    [self.AccountView.BalanceAccount addTarget:self action:@selector(enter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.AccountView];
    
    
}
-(void)enter{
    addressViewController * address = [[addressViewController alloc]init];
    [self.navigationController pushViewController:address animated:YES];
}
/**
 *  刷新结账栏金额
 */
-(void)postCenter
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"BottomRefresh" object:_allPriceLab.text userInfo:info];
}


@end
