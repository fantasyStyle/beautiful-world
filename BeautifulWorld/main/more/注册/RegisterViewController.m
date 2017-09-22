

//
//  RegisterViewController.m
//  demo
//
//  Created by yuanju001 on 16/9/22.
//  Copyright © 2016年 yuanju001. All rights reserved.
//

#import "RegisterViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "TTIFormatValidate.h"
@interface RegisterViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    //文字数组
    NSMutableArray *_dataArray;
    //详情数组
    NSMutableArray * _detailArr;
    //脚视图
    UIView * footView;
    //表视图
    UITableView * myTable;
    
    //验证码按钮
    UIButton * _btn;
    //输入框
    UITextField *theTextField;
    //计时器
    NSTimer* _timer;
    NSInteger _sec;
    
}


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    //self.navigationItem.title = @"注册";
    
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    lab.textColor=[UIColor whiteColor];
    lab.text = @"注册";
    lab.font=[UIFont systemFontOfSize:20];
    lab.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView=lab;
  
    [self creatData];
    [self creatUITableView];
   
    // Do any additional setup after loading the view.
}
-(void)creatData{
    _dataArray = [[NSMutableArray alloc]init];

    _dataArray=[NSMutableArray arrayWithObjects:@"手机号码",@"验证码",@"设置密码", nil];
    _detailArr = [NSMutableArray arrayWithObjects:@"请输入手机号",@"请输入验证码",@"请设置登录密码", nil];
    
}

#pragma mark -创建表格视图
-(void)creatUITableView{
     myTable =[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:myTable];
    myTable.delegate=self;
    myTable.dataSource=self;
    myTable.backgroundColor=RGBColor(244, 251, 255);
    
    [self addFootViewCust];
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    
    static NSString  *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [_dataArray objectAtIndex:row];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    CGRect textFieldRect = CGRectMake(0, 0, kScreen_Width/4*3-kScreen_Width/14, cell.bounds.size.height);
    theTextField = [[UITextField alloc] initWithFrame:textFieldRect];
    theTextField.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    theTextField.returnKeyType = UIReturnKeyDone;
    //theTextField.secureTextEntry = YES;
    theTextField.clearButtonMode = YES;
    theTextField.tag = row;
    theTextField.delegate = self;
    
    switch (row) {
        case 0:
            theTextField.placeholder = @"请输入手机号";
            theTextField.keyboardType= UIKeyboardTypeNumberPad;
            theTextField.tag = 1;
            break;
        case 1:
            theTextField.placeholder = @"请输入验证码";
             theTextField.tag = 2;
            [self addTimerButton];
            break;
        case 2:
            theTextField.placeholder = @"请设置登录密码";
             theTextField.tag = 3;
            break;
        default:
            break;
    }
    
    cell.accessoryView = theTextField;

    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0;
}
#pragma mark - 添加发送验证码按钮
-(void)addTimerButton{
    _btn = [[UIButton alloc]initWithFrame:CGRectMake(theTextField.bounds.size.width/5*3, theTextField.bounds.size.height/16, theTextField.bounds.size.width/5*2+5, theTextField.bounds.size.height/8*7)];
    [_btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_btn setTitleColor:RGBColor(0, 229, 255) forState:UIControlStateNormal];
    
    //        _btn.backgroundColor =[UIColor yellowColor];
    [_btn setBackgroundImage:LoadImageByName(@"获取验证码") forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(btnOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [theTextField addSubview:_btn];
    
    
    
    
}
-(void)btnOnClick
{   _sec = 60;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerUpDate) userInfo:nil repeats:YES];
    
    UITextView * account = (id)[self.view viewWithTag:1];
    //UITextView * testNum = (id)[self.view viewWithTag:2];
    //UITextView * secret = (id)[self.view viewWithTag:3];
    NSString * phoneNum11 = account.text;
//    NSLog(@"登录的账号为%@",phoneNum11);
    //NSString * passWord = secret.text;
    
    
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phoneNum11 zone:@"86" customIdentifier:nil result:^(NSError *error) {
        
        if (!error) {
                                                     NSLog(@"获取验证码成功");
                                                 } else {
                                                     NSLog(@"错误信息：%@",error);}

    }];
}
-(void)timerUpDate{
    _sec--;
    if (_sec > 0) {
        _btn.enabled = NO;
        [_btn setTitle:[NSString stringWithFormat:@"%ld秒后重新发送",(long)_sec] forState:UIControlStateNormal];
        _btn.titleLabel.font=[UIFont systemFontOfSize:12];
        
        
        
    }
    else{
        [_timer invalidate];
        [_btn setTitle:@"重新发送验证码" forState:UIControlStateNormal];
        _btn.titleLabel.font=[UIFont systemFontOfSize:12];
        _btn.enabled =YES;
        
    }
}

#pragma mark - 添加脚视图
-(void)addFootViewCust{
    footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/2)];
   // footView.backgroundColor= [UIColor yellowColor];
    myTable.tableFooterView = footView;
    
    //密码长度
    UILabel * passWordLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, kScreen_Width/2, 20)];
    passWordLab.textColor=[UIColor grayColor];
    passWordLab.text = @"密码长度为6-32位字符";
    passWordLab.font=[UIFont systemFontOfSize:12];
    [footView addSubview:passWordLab];
    //关联宝宝信息
    UIButton * relateBabyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [relateBabyBtn setFrame:CGRectMake(kScreen_Width/3*2, 5, kScreen_Width/3, 20)];
    relateBabyBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [relateBabyBtn setTitle:@"是否关联宝宝信息" forState:UIControlStateNormal];
    [relateBabyBtn setTitleColor:RGBColor(4, 146, 245) forState:UIControlStateNormal];
    [relateBabyBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [footView addSubview:relateBabyBtn];
    
    //注册按钮
    UIButton * registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setFrame:CGRectMake(10, 40, kScreen_Width-20, kScreen_Height/15)];
    [registerBtn setBackgroundImage:LoadImageByName(@"按钮") forState:UIControlStateNormal];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerAccount) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:registerBtn];
    
    //点击注册代表您已阅读了
    UILabel * readLab = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreen_Height/15+45, kScreen_Width/2, 20)];
    readLab.textColor=[UIColor grayColor];
    readLab.text = @"点击注册代表您已阅读了";
    readLab.textAlignment = NSTextAlignmentRight;
    readLab.font=[UIFont systemFontOfSize:12];
    //readLab.backgroundColor= [UIColor greenColor];
    [footView addSubview:readLab];
    
    //时光宝贝用户协议
    
    UIButton * userBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [userBtn setFrame:CGRectMake(kScreen_Width/2, kScreen_Height/15+45, kScreen_Width/2, 20)];
    
    [userBtn setTitle:@"时光宝贝用户协议" forState:UIControlStateNormal];
    [userBtn setTitleColor:RGBColor(4, 146, 245) forState:UIControlStateNormal];
    //userBtn.backgroundColor= [UIColor redColor];
    [userBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    //userBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [userBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0,kScreen_Width/6)];
    [footView addSubview:userBtn];

    
}
//注册事件
-(void)registerAccount{
    UITextView * account = (id)[self.view viewWithTag:1];
    UITextView * testNum = (id)[self.view viewWithTag:2];
    UITextView * secret = (id)[self.view viewWithTag:3];
    NSString * userName = account.text;
    NSString * passWord = secret.text;
    NSString * verfiy = testNum.text;
    
    if (ICIsStringEmpty(userName)) {
        //[HUD showAlertWithTitle:@"手机号码为空,请重新输入"];
        TTAlertNoTitle(@"手机号码为空,请重新输入");
        return;
    }
    if (![TTIFormatValidate isValidateMobilePhone: userName]) {
       // [HUD showAlertWithTitle:@"手机号码有误,请重新输入"];
        TTAlertNoTitle(@"手机号码有误,请重新输入");
        return;
    }
    if (ICIsStringEmpty(passWord)) {
        //[HUD showAlertWithTitle:@"验证码不能为空,请重新输入"];
        TTAlertNoTitle(@"密码为空,请重新输入");
        return;
    }
    else{
        [SMSSDK commitVerificationCode:verfiy phoneNumber:userName zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
            
            {
                if (!error)
                {
                    
                    NSLog(@"验证成功");
                    [self verfiySuccessRegisterWithUser:userName AndSecret:passWord];
                }
                else
                {
                    TTAlertNoTitle(@"验证码错误，请重新输入");
                    NSLog(@"错误信息:%@",error);
                }
            }
        }];
        

    }
    
    
    
}
-(void)verfiySuccessRegisterWithUser:(NSString*)userName AndSecret:(NSString*)passWord{
        [self showHudInView:self.view hint:NSLocalizedString(@"register.ongoing", @"Is to register...")];
        __weak typeof(self) weakself = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            EMError *error = [[EMClient sharedClient] registerWithUsername:userName password:passWord];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself hideHud];
                if (!error) {
                    TTAlertNoTitle(NSLocalizedString(@"register.success", @"Registered successfully, please log in"));
                   [self.navigationController popViewControllerAnimated:YES];            }else{
                    switch (error.code) {
                        case EMErrorServerNotReachable:
                            TTAlertNoTitle(NSLocalizedString(@"error.connectServerFail", @"Connect to the server failed!"));
                            break;
                        case EMErrorUserAlreadyExist:
                            TTAlertNoTitle(NSLocalizedString(@"register.repeat", @"You registered user already exists!"));
                            break;
                        case EMErrorNetworkUnavailable:
                            TTAlertNoTitle(NSLocalizedString(@"error.connectNetworkFail", @"No network connection!"));
                            break;
                        case EMErrorServerTimeout:
                            TTAlertNoTitle(NSLocalizedString(@"error.connectServerTimeout", @"Connect to the server timed out!"));
                            break;
                        default:
                            TTAlertNoTitle(NSLocalizedString(@"register.fail", @"Registration failed"));
                            break;
                    }
                }
            });
        });

}


@end
