//
//  SettingViewController.m
//  NewWorld
//
//  Created by fantasy  on 2017/2/13.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "SettingViewController.h"
#import "ModifyPwdViewController.h"
#import "HUD.h"
#import "LoginViewController.h"
#import "ConvertCoinCell.h"
#import <ShareSDK/ShareSDK.h>
@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    NSMutableArray * arr;
    NSString * value;
    //输入框
    UITextField *theTextField;
}
@property (nonatomic,strong)UITableView * settingTable;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatDataSouse];
    [self initTable];
}
-(NSMutableArray *)arr{
    if (arr == nil) {
        arr = [NSMutableArray arrayWithCapacity:0];
    }
    return arr;
}
-(void)creatDataSouse{
    value  = @"0.82M";
    arr = [NSMutableArray arrayWithObjects:@"清除缓存",@"绑定微信", nil];
}
-(void)initTable{
    _settingTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _settingTable.dataSource = self;
    _settingTable.delegate = self;
    
    UIView * footView =[[UIView alloc]init];
    footView.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height/2);
    UIButton * outLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    outLogin.frame =CGRectMake(30, 100, kScreen_Width-60, 40);
    outLogin.layer.masksToBounds = YES;
    outLogin.layer.cornerRadius = 10;
    outLogin.backgroundColor = [UIColor brownColor];
    [outLogin setTitle:@"退出登录" forState:UIControlStateNormal];
    outLogin.titleLabel.font = font14;
    [outLogin addTarget:self action:@selector(outLoginClick) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:outLogin];
    [self.view addSubview:_settingTable];
    _settingTable.tableFooterView = footView;
}
-(void)outLoginClick{
    
    [UserInfo sharedUserInfo].isLogin = @"0";
    [UserInfo sharedUserInfo].userRank = @"0";
    [UserInfo sharedUserInfo].user_id = @"0";

    [[UserInfo sharedUserInfo] saveUserInofFromSanbox];

    
    LoginViewController * lead = [[LoginViewController alloc]init];
    
    [self presentViewController:lead animated:YES completion:^{
        
        
    }];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
 
       if (indexPath.section == 0) {
        cell.detailTextLabel.text = value;
           cell.textLabel.text = arr[indexPath.section];

   }
    if (indexPath.section == 1)
   {       cell.textLabel.text = arr[indexPath.section];

   }

    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreen_Height/12;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

        return 10;
    //}
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1) {
        
        [ShareSDK getUserInfo:SSDKPlatformTypeWechat
               onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
         {
             if (state == SSDKResponseStateSuccess)
             {
                 
                 NSMutableDictionary *params = [NSMutableDictionary dictionary];
           
                 
                 [params addUnEmptyString:user.rawData[@"unionid"]          forKey:@"unionid"];
                 [params addUnEmptyString:user.rawData[@"openid"]          forKey:@"openid"];
                 [params addUnEmptyString:user.rawData[@"headimgurl"]          forKey:@"headimgurl"];
                 [params addUnEmptyString:user.rawData[@"nickname"]          forKey:@"nickname"];
                 [params addUnEmptyString:user.credential.rawData[@"refresh_token"]          forKey:@"refresh_token"];
                 [params addUnEmptyString:user.credential.rawData[@"scope"]          forKey:@"scope"];
                 [params addUnEmptyString:user.credential.rawData[@"access_token"]         forKey:@"access_token"];
                 
  
                 
                 
                 NSLog(@"%@",params);


                 
                 
                 
                 [[HttpClient shareInstance]requestApiWithurl:@"openid" parmar:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     
                     
                 } failuer:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     
                     
                 }];

//                 NSLog(@"uid=%@",user.uid);
//                 NSLog(@"%@",user.credential);
//                 NSLog(@"token=%@",user.credential.token);
//                 NSLog(@"nickname=%@",user.nickname);
//                 //credential[access_token]
             }
             
             else
             {
                 NSLog(@"%@",error);
             }
             
         }];
//        ModifyPwdViewController * modify = [[ModifyPwdViewController alloc]init];
//        [self.navigationController pushViewController:modify animated:YES];
    }
    if (indexPath.section ==0) {
        [HUD showAlertWithTitle:@"清理完成"];
        value = @"0.00M";
        [tableView reloadData];
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
