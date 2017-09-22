//
//  LoginViewController.m
//  demo
//
//  Created by yuanju001 on 16/9/20.
//  Copyright © 2016年 yuanju001. All rights reserved.
//

#import "LoginViewController.h"
#import "MyTabBarViewController.h"
#import "RegisterViewController.h"
#import "GjBackScrollView.h"
#import "NSMutableDictionary+Utils.h"
#import "MineViewController.h"

#define kheight kScreen_Height/12

@interface LoginViewController ()<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate
>
{
    UIButton * _iconBtn;
    NSMutableArray *_dataArray;
    
    //AppDelegate *appDelegateUtils;
}

@property (nonatomic,strong)UITextField * mytext;
@property (nonatomic,strong)UITextField * mySecret;
@property (nonatomic,strong)UIButton * login;
@property (nonatomic,strong)UIImageView * backImaView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _backImaView =[[UIImageView alloc]initWithFrame:self.view.bounds];
//    _backImaView.image=LoadImageByName(@"3.jpg");
//    [self.view addSubview:_backImaView];
    GjBackScrollView *backView2=[[GjBackScrollView alloc]initWithFrame:self.view.bounds];
   backView2.rollImageURL = @"https://a-ssl.duitang.com/uploads/item/201611/16/20161116161417_ydRxF.thumb.700_0.jpeg"; //网络图片
    //本地图片
   //backView2.image = LoadImageByName(@"login.jpg");
    backView2.timeInterval = .02; //移动一次需要的时间
    backView2.rollSpace = .1; //每次移动的像素距离
    backView2.direction = RollDirectionUpDown;//滚动的方向
    [backView2 startRoll]; //开始滚动
    [self.view addSubview:backView2];


    [self creatZhanghao];
    [self creatSecret];
    [self creatButton];
    //[self setUserIcon];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
#pragma mark --------  头像设置
////添加头像
//-(void)setUserIcon{
//    _iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_iconBtn setFrame:CGRectMake(kScreen_Width/8*3, kScreen_Height/6, kScreen_Width/4, kScreen_Width/4)];
//    
//    _iconBtn.layer.cornerRadius = kScreen_Width/8;
//    _iconBtn.layer.masksToBounds=YES;
//    
//    [_iconBtn setBackgroundColor:[UIColor lightGrayColor]];
//    [self.view addSubview:_iconBtn];
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSData * data =[user objectForKey:@"saveIcon"];
//    if (data == nil) {
//        //[_iconBtn setImage:LoadImageByName(@"头像(无)") forState:UIControlStateNormal];
//    }
//    else{
//      // [_iconBtn setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
//        
//    }
//    [_iconBtn setImage:LoadImageByName(@"教师风采11") forState:UIControlStateNormal];
//    [_iconBtn addTarget:self action:@selector(iconBtnClick) forControlEvents:UIControlEventTouchUpInside];
//}
-(void)iconBtnClick
{
    
       
//    //定义消息框
//    UIActionSheet * act =[[UIActionSheet alloc]initWithTitle:@"请选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"选择相册",@"选择相机", nil];
//    //显示消息框
//    [act showInView:self.view];
}
//账号
-(void)creatZhanghao{
    
  
    _mytext = [[UITextField alloc]initWithFrame:CGRectMake(kScreen_Width/12, kScreen_Height/5*2, kScreen_Width/6*5, kheight)];

    
    UIImageView * account = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 18, 18)];
    account.image=LoadImageByName(@"账号");
    _mytext.leftView=account;
    _mytext.delegate=self;
    _mytext.leftViewMode=UITextFieldViewModeAlways;
    
    _mytext.placeholder=@"手机号／邮箱";
    _mytext.textColor=[UIColor blackColor];
    _mytext.borderStyle=UITextBorderStyleRoundedRect;
    _mytext.backgroundColor=[UIColor whiteColor];
    _mytext.tag=1;
    [_mytext addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_mytext];
}
//密码
-(void)creatSecret{
    
    
    _mySecret = [[UITextField alloc]initWithFrame:CGRectMake(kScreen_Width/12, kScreen_Height/5*2+kheight, kScreen_Width/6*5, kheight)];
    

    
    UIImageView * account = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 18, 18)];
    //account.backgroundColor=[UIColor greenColor];
    account.image=LoadImageByName(@"密码");
    _mySecret.leftView=account;

    _mySecret.delegate=self;
    _mySecret.leftViewMode=UITextFieldViewModeAlways;
    
    _mySecret.placeholder=@"请输入密码";
    _mySecret.textColor=[UIColor blackColor];
    _mySecret.borderStyle=UITextBorderStyleRoundedRect;
    _mySecret.tag=2;
    _mySecret.secureTextEntry = YES;
    _mySecret.backgroundColor=[UIColor whiteColor];
    [_mySecret addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_mySecret];
}
-(void)creatButton{
    //登录
    _login = [[UIButton alloc]initWithFrame:CGRectMake(kScreen_Width/12, kScreen_Height/3*2, kScreen_Width/6*5, 45)];
    
    _login.backgroundColor=kCOLOR_LLD;
    _login.layer.cornerRadius = 5;
    _login.layer.masksToBounds = YES;

    [_login setTitle:@"登录" forState:UIControlStateNormal];
    [_login addTarget:self action:@selector(loginOnClick:) forControlEvents:UIControlEventTouchUpInside];
    _login.tag=100;
    
    [self.view addSubview:_login];
    
//    //第三方登录
//    CGFloat margin = kScreen_Width/6;
//    CGFloat wh = (kScreen_Width - margin * 4)/3;
//    NSArray * loginIma = @[@"登录_QQ",@"登录_微信",@"登录_微博"];
//    for (int i = 0; i < 3; i++) {
//        UIButton * login = [[UIButton alloc]initWithFrame:CGRectMake(margin +( wh + margin) * i ,kScreen_Height-100, wh, wh)];
//        [login setBackgroundImage:[UIImage imageNamed:loginIma[i]] forState:UIControlStateNormal];
//        login.tag = 100+i;
//        [login addTarget:self action:@selector(otherLoginClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:login];
//        
//    }
//
//    
    
//    //忘记密码
//    UIButton * forget =[[UIButton alloc]initWithFrame:CGRectMake(kScreen_Width/3*2,kScreen_Height/5*2+kheight*2 + 10, 100, 15)];
//    [forget setTitle:@"忘记密码?" forState:UIControlStateNormal];
//    [forget setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    forget.titleLabel.font =[UIFont systemFontOfSize:14];
//    [self.view addSubview:forget];
//    
    
    //注册账号
    UIButton * zcBtn  =[[UIButton alloc]initWithFrame:CGRectMake(kScreen_Width/12,kScreen_Height/5*2+kheight*2 + 10, 100, 15)];
    [zcBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [zcBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [zcBtn addTarget:self action:@selector(registerBtn:) forControlEvents:UIControlEventTouchUpInside];
    zcBtn.titleLabel.font =[UIFont systemFontOfSize:14];

    zcBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:zcBtn];
    
}
-(void)otherLoginClick:(UIButton *)sender{
    switch (sender.tag) {
        case 100:
            NSLog(@"点击了qq登陆");

            break;
        case 101://{
            NSLog(@"点击了微信登陆");
            
            
            
            break;

        case 102:
            NSLog(@"点击了微博登陆");

            break;

            
        default:
            break;
    }
}
-(void)registerBtn:(UIButton *)sender
{
    
    
    RegisterViewController * registerClick =[[RegisterViewController alloc]init];

    [self.navigationController pushViewController:registerClick animated:YES];


}

-(void)loginOnClick:(UIButton *)sender{
    


    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params addUnEmptyString:_mytext.text           forKey:@"user_account"];
    [params addUnEmptyString:_mySecret.text       forKey:@"user_password"];

    
    [[HttpClient shareInstance] requestApiWithurl:@"login"  parmar:params  success:^(NSURLSessionDataTask *task, id response) {
//        NSLog(@"成功%@",response);
        [HUD showAlertWithTitle:@"登录成功"];
    [UserInfo sharedUserInfo].isLogin  = @"1";
    [[UserInfo sharedUserInfo] saveUserInofFromSanbox];
        
        NSMutableArray * dic = [response objectForKey:@"result"];
        NSLog(@"登录的%@",dic);
        NSMutableDictionary * subDic = dic[0];
//        for (NSMutableDictionary * subDic in dic) {
           [UserInfo sharedUserInfo].userRank = subDic[@"rank"];
        [UserInfo sharedUserInfo].userJewel = subDic[@"jewel"];
        [UserInfo sharedUserInfo].userGold = subDic[@"gold"];
        [UserInfo sharedUserInfo].iconUser = subDic[@"img"];
        [UserInfo sharedUserInfo].vipType =[NSString stringWithFormat:@"%@",subDic[@"type_vip"]];
       
        if (!subDic[@"name"]) {
            [UserInfo sharedUserInfo].nickName = @"新用户";
        }else{
             [UserInfo sharedUserInfo].nickName = subDic[@"name"];
        }
            [UserInfo sharedUserInfo].user_id = subDic[@"id"];
            [[UserInfo sharedUserInfo] saveUserInofFromSanbox];
            NSLog(@"用户的ID%@",[UserInfo sharedUserInfo].user_id);
      //  }
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"失败%@",response);
        [HUD showAlertWithTitle:@"登录失败"];
        [UserInfo sharedUserInfo].isLogin  = @"0";
        [[UserInfo sharedUserInfo] saveUserInofFromSanbox];

        
    }];

    
    [HUD showAlertWithTitle:@"登陆中..." inView:self.view duration:2.0];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_main_sync_safe(^{
           
        });
        MyTabBarViewController * myTabBar =[[MyTabBarViewController alloc]init];
        [self presentViewController:myTabBar animated:YES completion:^{

        }];

    });

    
    
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}

- (void)textFieldDidChange:(UITextField *)textField{
    
    if (_mytext.text.length > 0 && _mySecret.text.length > 0) {
        [_login setUserInteractionEnabled:YES];
        _login.backgroundColor=kCOLOR_LLD;
        
    }
    else{
        _login.backgroundColor=[UIColor grayColor];
        
        [_login setUserInteractionEnabled:NO];
        
    }
    
    
}
#pragma  mark - TextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == _mytext) {
        _mySecret.text = @"";
    }
    
    return YES;
}



////判断账号和密码是否为空
//- (BOOL)isEmpty{
//    BOOL ret = NO;
//    NSString *username = _mytext.text;
//    NSString *password = _mySecret.text;
//    if (username.length == 0 || password.length == 0) {
//        ret = YES;
//        [EMAlertView showAlertWithTitle:NSLocalizedString(@"prompt", @"Prompt")
//                                message:NSLocalizedString(@"login.inputNameAndPswd", @"Please enter username and password")
//                        completionBlock:nil
//                      cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
//                      otherButtonTitles:nil];
//    }
//    
//    return ret;
//}
//#pragma  mark - private
//- (void)saveLastLoginUsername
//{
//    NSString *username = [[EMClient sharedClient] currentUsername];
//    if (username && username.length > 0) {
//        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//        [ud setObject:username forKey:[NSString stringWithFormat:@"em_lastLogin_username"]];
//        [ud synchronize];
//    }
//}
//
//- (NSString*)lastLoginUsername
//{
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    NSString *username = [ud objectForKey:[NSString stringWithFormat:@"em_lastLogin_username"]];
//    if (username && username.length > 0) {
//        return username;
//    }
//    return nil;
//}


@end
