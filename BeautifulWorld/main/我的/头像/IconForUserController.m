//
//  IconForUserController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/15.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "IconForUserController.h"
#import "IconModel.h"
#import "iconUserTableViewCell.h"
#import "CustJourHeadView.h"
#import "BecomeMemberController.h"
#import "CYAlertView.h"
@interface IconForUserController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,SelectIcondelegate,CYAlertViewDelegate>
{
    CustJourHeadView *cellHeadView;
    NSMutableArray * iconArray1;
    NSMutableArray * iconArray2;
    UIView * headView;//头视图
    NSArray * arr;
}
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * dataArr;
@end

@implementation IconForUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(235, 235, 241);
    self.navigationItem.title = @"头像";
    [self loadUserData];
    //[self initTableView];
    // Do any additional setup after loading the view.
}
-(NSMutableArray *)dataArr{
    if (_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}
-(void)loadUserData{
    _dataArr = [[NSMutableArray alloc]init];
    iconArray1 = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"time desc" forKey:@"order"];
     [params setValue:@([@"3" intValue]) forKey:@"limit"];
    [params setValue:@([@"0" intValue]) forKey:@"vip"];
    [[HttpClient shareInstance] requestApiWithurl:@"image"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        
        
        [FTShowMessageView dismiss];
        
        NSMutableArray * dic = [response objectForKey:@"result"];
             NSLog(@"用户的头像选择%@",dic);
        int i = 0;
        for (NSMutableDictionary * subDic in dic) {
            if (i==0) {
//                [UserInfo sharedUserInfo].vipType = subDic[@"vip"];
            }else{
                IconModel * user = [[IconModel alloc]init];
                user.icon = @"WechatIMG42";
                [iconArray1 addObject:user];
                [_dataArr addObject:iconArray1];
            }
            [_tableView reloadData];
            i++;
        }
        
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        [FTShowMessageView dismiss];
        
        
    }];
    
    iconArray2 = [[NSMutableArray alloc]init];
    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
    [params1 setValue:@"time desc" forKey:@"order"];
    [params1 setValue:@([@"3" intValue]) forKey:@"limit"];
    [params1 setValue:@([@"1" intValue]) forKey:@"vip"];
    [[HttpClient shareInstance] requestApiWithurl:@"image"  parmar:params1 success:^(NSURLSessionDataTask *task, id response) {
        
        
        [FTShowMessageView dismiss];
        
        NSMutableArray * dic = [response objectForKey:@"result"];
        NSLog(@"用户的头像选择%@",dic);
        int i = 0;
        for (NSMutableDictionary * subDic in dic) {
            if (i==0) {
                [UserInfo sharedUserInfo].vipType =[NSString stringWithFormat:@"%@", subDic[@"vip"]];
            }else{
                IconModel * user = [[IconModel alloc]init];
                user.icon = @"WechatIMG42";
                [iconArray2 addObject:user];
                [_dataArr addObject:iconArray2];
            }
            [_tableView reloadData];
            i++;
        }
        [self initTableView];
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        [FTShowMessageView dismiss];
        
        
    }];

    

    
    
    
//    NSArray * ima = @[@"WechatIMG42",@"WechatIMG43",@"WechatIMG44"];
//    for (int i =0; i<3;i++) {
//        IconModel * user = [[IconModel alloc]init];
//        user.icon = ima[i];
//        [iconArray1 addObject:user];
//    }
//    [_dataArr addObject:iconArray1];
//    
//    iconArray2 = [[NSMutableArray alloc]init];
//    NSArray * ima1 = @[@"WechatIMG44",@"WechatIMG42",@"WechatIMG43"];
//    for (int i =0; i<3;i++) {
//        IconModel * user = [[IconModel alloc]init];
//        user.icon = ima1[i];
//        [iconArray2 addObject:user];
//    }
//   [_dataArr addObject:iconArray2];
   // arr = @[iconArray1,iconArray2];
   //_dataArr = [NSMutableArray arrayWithObjects:iconArray1,iconArray2, nil];
    NSLog(@"你好 世界%ld",arr.count);
    
    
    

}
-(void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-NavBar_Height-StatusBar_Height) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate =self;

    [self.view addSubview:_tableView];
    
    CGFloat KHhead =kScreen_Height/4;
    headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, KHhead)];
     headView.backgroundColor =[UIColor whiteColor];
    
    UIImageView * headIma = [[UIImageView alloc]init];
    headIma.image  = LoadImageByName(@"selectimage_02");
    headIma.frame = headView.bounds;
    [headView addSubview:headIma];
    _tableView.tableHeaderView =headView;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
       //推荐用户
    static NSString * userId=@"iconTableCell";
    iconUserTableViewCell * userCell =[tableView dequeueReusableCellWithIdentifier:userId];
    if (!userCell) {
        userCell = [[iconUserTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:userId];
    }


    userCell.selectionStyle = UITableViewCellSelectionStyleNone;
    userCell.userIconArray =_dataArr[indexPath.section];
    userCell.iconDelegate = self;
    userCell.tags = (int)indexPath.section;
    return userCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreen_Height/5;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    cellHeadView=[[CustJourHeadView alloc]init];
    cellHeadView.moreIma.hidden = YES;
    cellHeadView.moreIma.tag =section+1;
    [cellHeadView.moreIma addTapTraget:self withAction:@selector(moreClick:)];
    
    if (section==0) {
        
        cellHeadView.titleLab.text=@"免费头像";
        cellHeadView.lineView.backgroundColor = RGBColor(191, 141, 12);
        cellHeadView.titleLab.textColor =RGBColor(191, 141, 12);
        
        
        
    }else{
        cellHeadView.titleLab.text=@"付费头像";
        cellHeadView.lineView.backgroundColor = lineBlue;
        cellHeadView.titleLab.textColor =lineBlue;
        
        
        
    }
    
    return cellHeadView;
}
-(void)moreClick:(UITapGestureRecognizer *)tap{
    switch (tap.view.tag) {
        case 1:
        {
            NSLog(@"免费头像");
          
        }
            break;
        case 2:{
            NSLog(@"付费头像");
        }
            
        default:
            break;
    }
}
-(void)selectUserIcon:(IconModel *)userIcon{
    NSLog(@"%@",userIcon.icon);
    [self.navigationController popViewControllerAnimated:YES];
    
    [UserInfo sharedUserInfo].iconUser = userIcon.icon;
    [[UserInfo sharedUserInfo] saveUserInofFromSanbox];

    if ([self.saveInfoDelegate respondsToSelector:@selector(onClickSaveWithHeadIcon:)]) {
        [self.saveInfoDelegate onClickSaveWithHeadIcon:[UserInfo sharedUserInfo].iconUser];
    }

    
}
-(void)selectFeeIcon:(IconModel *)userIcon{
    
    
    if ([[UserInfo sharedUserInfo].vipType isEqualToString:@"2"]) {
        [self.navigationController popViewControllerAnimated:YES];

        [UserInfo sharedUserInfo].iconUser = userIcon.icon;
        [[UserInfo sharedUserInfo] saveUserInofFromSanbox];
        
        if ([self.saveInfoDelegate respondsToSelector:@selector(onClickSaveWithHeadIcon:)]) {
            [self.saveInfoDelegate onClickSaveWithHeadIcon:[UserInfo sharedUserInfo].iconUser];
        }

        
    }else{
        CYAlertView *alert = [[[NSBundle mainBundle] loadNibNamed:@"CYAlertView" owner:nil options:nil] firstObject];
        alert.title = @"温馨提示";
        alert.content = @"你尚未购买会员业务，是否购买";
        alert.delegate = self;
        
        [alert show];

    }
   
}
- (void)alertView:(CYAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSLog(@"点击确定了哦");
        BecomeMemberController * member = [[BecomeMemberController alloc]init];
        member.title = @"成为会员";
        [self.navigationController pushViewController:member animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
