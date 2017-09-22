//
//  BackpackViewController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/21.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "BackpackViewController.h"
#import "BackpackCell.h"
#import "ItemButton.h"
@interface BackpackViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>{
    UIImageView * selectIma;
    UIImageView * backView;
    UILabel * nameLab;
    UILabel * countLab;
    UILabel * priceLab;
}
@property (nonatomic,strong)NSMutableArray *dataArray;


@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)ItemButton * recoredItem;
@end

@implementation BackpackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [FTShowMessageView showStatusWithMessage:@"Loading..."];
    backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-NavBar_Height-StatusBar_Height)];
    backView.image = LoadImageByName(@"bg_02");
    backView.userInteractionEnabled = YES;
    [self.view addSubview:backView];
    [self loadData];
    [self creatItem];
     [self creatCollectionView];
    //只创建一次 否则会造成内容重叠
    nameLab = [[UILabel alloc]init];
    countLab = [[UILabel alloc]init];
    priceLab = [[UILabel alloc]init];
    selectIma = [[UIImageView alloc]init];
 
    
    
    // Do any additional setup after loading the view.
}
-(void)creatItem{
    UIView * view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 44)];
    view.backgroundColor=[UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1];
    
    
    
    NSArray*arry=@[@"全部",@"头像",@"边框",@"礼物"];
    CGFloat X=(kScreen_Width-19)/4;
    //
    UILabel * labr =[[UILabel alloc]initWithFrame:CGRectMake(0, 34, kScreen_Width, 1)];
    //labr.alpha=0.2;
    labr.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"line_v1.png"]];
    
    [view addSubview:labr];
    for (int i=0; i<4;i++ ) {
        ItemButton*but=[[ItemButton alloc]initWithFrame:CGRectMake(5+i*(X+3), 3, X, 32)];
        [but setTitle:arry[i] forState:UIControlStateNormal];
        but.titleLabel.alpha=0.5;
        
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        but.titleLabel.font=[UIFont systemFontOfSize:15];
        [but addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
        but.tag=i;
        if (i==0) {
            but.selected=YES;
            [self button:but];
        }
        [view addSubview:but];
        
    }
    
    
    
    
    
    for (int j=1; j<5; j++) {
        UIView *v=[[UIView alloc]initWithFrame:CGRectMake(5+j*(X+1), 8, 1, 20)];
        v.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"line_v.png"]];
        [view addSubview:v];
    }
    [backView addSubview:view];
    
    
}
-(void)button:(ItemButton*)but{
    [FTShowMessageView showStatusWithMessage:@"Loading..."];

    [self.recoredItem setIsRecord:NO];
    [but setIsRecord:YES];
    NSLog(@"%ld",but.tag);
    switch (but.tag) {
        case 0:
            self.goodsType = nil;
            break;
        case 1:
            self.goodsType = @"10";
            break;
        case 2:
              self.goodsType = @"11";
            break;
        case 3:
            self.goodsType = @"12";
            break;
        case 4:
            
            break;
        default:
            break;
    }
    self.recoredItem=but;
    [self loadData];
}

-(void)loadData{
    _dataArray = [[NSMutableArray alloc]init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:[UserInfo sharedUserInfo].user_id forKey:@"user_id"];
    if (self.goodsType) {
         [params setValue:self.goodsType forKey:@"type_id"];
    }
    //int i =0;
    [[HttpClient shareInstance] requestApiWithurl:@"usergoods"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        
        
        [FTShowMessageView dismiss];
        
        id  dic = [response objectForKey:@"result"];
            [_dataArray removeAllObjects];
         [_collectionView reloadData];
       
        if (dic == [NSNull null]) {
            [HUD showAlertWithTitle:@"该分类尚未购买商品"];
             [_collectionView reloadData];
            //[_collectionView removeFromSuperview];
        }else{
            for (NSMutableDictionary * subDic in dic) {
                
                NSLog(@"背包%@",dic);
                BackpackModel * model = [[BackpackModel alloc]init];
                
                model.packName =subDic[@"picture"];
                model.goods_id = subDic[@"id"];
                model.goodsName = subDic[@"name"];
                model.goodsCount = subDic[@"numbers"];
                model.goodsPrice = subDic[@"price"];
                
                
                [_dataArray addObject:model];
                [_collectionView reloadData];
                
                
            }

        }
        

    } failuer:^(NSURLSessionDataTask *task, id response) {
        [FTShowMessageView dismiss];
        
        
    }];
    


}
-(void)creatCollectionView{
    UICollectionViewFlowLayout * layout =[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((kScreen_Width-50)/4, (kScreen_Width-50)/4);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing=0;
    
    layout.sectionInset = UIEdgeInsetsMake(5,5,5,5);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 44, kScreen_Width, kScreen_Height-StatusBar_Height-NavBar_Height) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    self.collectionView.alwaysBounceVertical = YES;
    
 
    _collectionView.backgroundColor=[UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1];
    [_collectionView registerClass:[BackpackCell class] forCellWithReuseIdentifier:@"BackpackCell"];


    [backView addSubview:_collectionView];
    
}
- (NSInteger)numberOfSectionsInCollectionView:( UICollectionView *)collectionView{
    return 1;
}
- (UICollectionViewCell*)collectionView:( UICollectionView *)collectionView cellForItemAtIndexPath:( NSIndexPath *)indexPath{
    BackpackCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BackpackCell" forIndexPath:indexPath];
    
    
    cell.tag = indexPath.item;
    BackpackModel * model = self.dataArray[indexPath.row];
    cell.backModel=model;
    
    //cell.backgroundColor=[UIColor whiteColor];
    return cell;
}
- (NSInteger)collectionView:( UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _collectionView.frame = CGRectMake(0, kScreen_Height/4+44, kScreen_Width, kScreen_Height-StatusBar_Height-NavBar_Height-kScreen_Height/4-44);
    NSLog(@"点击了第%ld个商品",indexPath.item);
    BackpackCell * cell = (BackpackCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"点击的%ld",cell.tag);
//    selectIma.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
//    selectIma.image = LoadImageByName(@"jiao_03");
//    [cell addSubview:selectIma];
    
    UIView * head = [[UIView alloc]init];
    head.frame = CGRectMake(0, 44, kScreen_Width, kScreen_Height/4);
    //head.backgroundColor = [UIColor redColor];
    [backView addSubview:head];
    
    UIView * headView = [[UIView alloc]init];
    headView.frame = CGRectMake(10, 10, head.frame.size.height-20, head.frame.size.height-20);
    headView.backgroundColor = [UIColor whiteColor];
    [head addSubview:headView];
    
    UIImageView * selectview = [[UIImageView alloc]init];
    selectview.frame = CGRectMake(0, 0, headView.frame.size.width/5*4, headView.frame.size.width/5*4);
    selectview.center = headView.center;
     BackpackModel * model = _dataArray[indexPath.item];
    NSString * str = [NSString stringWithFormat:@"%@%@",BaseShopUrl,model.packName];
    [selectview sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:LoadImageByName(@"taoyi_03")];
    selectview .contentMode = UIViewContentModeScaleAspectFit;

//    selectview.image  = LoadImageByName(model.packName);
    [head addSubview:selectview];
    
    
    nameLab.textColor = [UIColor whiteColor];
    //nameLab.font = [UIFont systemFontOfSize:18];
    nameLab.frame = CGRectMake(headView.x+headView.frame.size.width+30, 40, kScreen_Width/2, 20);
//    nameLab.backgroundColor = [UIColor clearColor];
    nameLab.text =model.goodsName;
    [head addSubview:nameLab];
    
    
    countLab.textColor = [UIColor whiteColor];
   // countLab.font = [UIFont systemFontOfSize:18];
    countLab.frame = CGRectMake(nameLab.x, nameLab.y+70, 30, 20);
    countLab.text = [NSString stringWithFormat:@"x%@",model.goodsCount];
   // [head addSubview:countLab];
    
    UIImageView * priceIma = [[UIImageView alloc]init];
    priceIma.frame = CGRectMake(countLab.x+60, countLab.y, 20,20);
    priceIma.image = LoadImageByName(@"huangzuan_03");
    //[head addSubview:priceIma];
    
    priceLab.frame = CGRectMake(priceIma.x+25, priceIma.y, 60, 20);
    priceLab.text = [NSString stringWithFormat:@"x%@",model.goodsPrice];
    priceLab.textColor = [UIColor whiteColor];
   // [head addSubview:priceLab];
    
    UIButton * useBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    useBtn.frame = CGRectMake(nameLab.x, head.frame.size.height-50, 60, 30);
    useBtn.backgroundColor = [UIColor redColor];
    [useBtn setTitle:@"使用" forState:UIControlStateNormal];
    [useBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[head addSubview:useBtn];
    
    UIButton * saleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saleBtn.frame = CGRectMake(useBtn.x+80, useBtn.y, 60, 30);
    [saleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [saleBtn setTitle:@"出售" forState:UIControlStateNormal];
    saleBtn.backgroundColor = [UIColor grayColor];
    //[head addSubview:saleBtn];
   // [_collectionView reloadData];
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
   // BackpackCell * decell = (BackpackCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [selectIma removeFromSuperview];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
