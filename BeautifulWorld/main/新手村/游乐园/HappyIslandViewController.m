//
//  HappyIslandViewController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/12.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "HappyIslandViewController.h"
#import "HappyDetailViewController.h"
#import "ResourceBuyController.h"
@interface HappyIslandViewController ()<UITextFieldDelegate>{
    UIImageView * signImaView;
    UITextField * _textField;
    NSString * userSex;
}

@end

@implementation HappyIslandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =self.titleName;
    userSex = @"男";
    [self initView];
    // Do any additional setup after loading the view.
}
-(void)initView{
    
    NSLog(@"%@,%@",self.payFee,self.titleName);
    
    UIImageView * backIma = [[UIImageView alloc]init];
    backIma.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height -NavBar_Height - StatusBar_Height);
    NSString * str = [NSString stringWithFormat:@"%@%@",BaseActUrl,self.activityUrl];
    [backIma sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:LoadImageByName(@"bg_06")];
//    backIma.image = LoadImageByName(@"bg_06");
    backIma.userInteractionEnabled = YES;
    [self.view addSubview:backIma];
    

    
    
    CGFloat margin = kScreen_Width/6;
 
    CGFloat KWbtn = kScreen_Width/7*2;
    CGFloat kMrgin = kScreen_Width-margin*2-KWbtn*2;
    CGFloat kBtnH = KWbtn/3;
    NSArray * btnArr = @[@"baoming_03",@"xiangqing_03"];
    for (int i = 0;i<2; i++) {
        UIImageView * btn = [[UIImageView alloc]init];
        btn.frame = CGRectMake(margin + (kMrgin + KWbtn)*i, kScreen_Height/4*3, KWbtn, kBtnH);
        btn.image = LoadImageByName(btnArr[i]);
        btn.tag = 100+i;
        
        [btn addTapTraget:self withAction:@selector(onClick:)];
        [backIma addSubview:btn];
    }
}
-(void)onClick:(UITapGestureRecognizer *)tap{
    switch (tap.view.tag) {
            
        case 100:{
            //[HUD showAlertWithTitle:@"此功能暂未开放" duration:2.0];
            [self initSignUpView];
        }
            break;
        case 101:
        {
            HappyDetailViewController * happy = [[HappyDetailViewController alloc]init];
            happy.title = @"活动详情";
            happy.introUrl = self.introUrl;
            [self.navigationController pushViewController:happy animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 报名页面
-(void)initSignUpView{
    signImaView = [[UIImageView alloc]init];
    signImaView.frame = CGRectMake(kScreen_Width/10,30, kScreen_Width/5*4, kScreen_Height/5*4);
    signImaView.image = LoadImageByName(@"bg_baoming_03");
    signImaView.userInteractionEnabled=YES;
    [self.view addSubview:signImaView];
    
    NSArray * titleArr= @[@"姓名",@"性别",@"年龄",@"电话"];
    CGFloat kLabH = signImaView.frame.size.height/12;
    CGFloat kmargin = 10;
    
    for (int i=0; i<4; i++) {
        UILabel * titleLab = [[UILabel alloc]init];
        titleLab.frame = CGRectMake(15, signImaView.frame.size.height/8+(kLabH+kmargin)*i, 40, kLabH);
        titleLab.font = font15;
        titleLab.textColor = [UIColor darkGrayColor];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.text = titleArr[i];
        [signImaView addSubview:titleLab];
        
        _textField = [[UITextField alloc]init];
        _textField.frame = CGRectMake(titleLab.x+titleLab.frame.size.width, titleLab.y, signImaView.frame.size.width-(titleLab.x+titleLab.frame.size.width)*2, kLabH);
        _textField.tag = i+20;
        _textField.delegate = self;
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.backgroundColor = [UIColor whiteColor];
        [signImaView addSubview:_textField];
        

        
        if (i==1) {
            [_textField removeFromSuperview];
            titleLab.frame = CGRectMake(15, signImaView.frame.size.height/8+(kLabH+kmargin)*i, 80, kLabH);
            titleLab.text  = @"性别：男";
            _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            _btn1.frame = CGRectMake(titleLab.x+titleLab.frame.size.width, titleLab.y+(kLabH-16)/2, 16, 16);
            _btn1.selected = YES;
            self.selectedBtn = _btn1;
            [_btn1 setBackgroundImage:LoadImageByName(@"table_no") forState:UIControlStateNormal];
            [_btn1 setBackgroundImage:LoadImageByName(@"table_ok") forState:UIControlStateSelected];
            _btn1.tag =  10;
            [UserInfo sharedUserInfo].isTeacher = @"0";
            [[UserInfo sharedUserInfo] saveUserInofFromSanbox];
            [_btn1 addTarget:self action:@selector(onClickSelect:) forControlEvents:UIControlEventTouchUpInside];
            
            [signImaView addSubview:_btn1];
            
            UILabel * teacherLab =[[UILabel alloc]init];
            teacherLab.frame = CGRectMake(_btn1.x+40, titleLab.y, 40, kLabH);
            teacherLab.textColor = [UIColor darkGrayColor];
            teacherLab.font = font15;
            teacherLab.text = @"女";
            [signImaView addSubview:teacherLab];
            
            _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
            _btn2.frame = CGRectMake(teacherLab.x+teacherLab.frame.size.width, titleLab.y+(kLabH-16)/2, 16, 16);
            _btn2.tag =11;
            [_btn2 setBackgroundImage:LoadImageByName(@"table_no") forState:UIControlStateNormal];
            [_btn2 setBackgroundImage:LoadImageByName(@"table_ok") forState:UIControlStateSelected];
            [_btn2 addTarget:self action:@selector(onClickSelect:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [signImaView addSubview:_btn2];
            

            
        }
        
        
        UILabel * payFee = [[UILabel alloc]init];
        payFee.frame = CGRectMake(15, signImaView.frame.size.height/2+40, signImaView.frame.size.width, 20);
        payFee.textColor = [UIColor darkGrayColor];
        payFee.font = font15;
       
        if (self.payFee) {
             int fee = [self.payFee intValue]/10;
             payFee.text = [NSString stringWithFormat:@"报名需支付费用¥%d元，请线下支付",fee];
        }else{
            payFee.text = [NSString stringWithFormat:@"该活动免费报名"];

        }
        NSLog(@"报名需支付费用%@钻石",self.payFee);
       
       // [signImaView addSubview:payFee];
        
        UIButton * submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        submitBtn.frame = CGRectMake(signImaView.frame.size.width/5*2,signImaView.frame.size.height/4*3, signImaView.frame.size.width/5, signImaView.frame.size.width/5/9*4);
        [submitBtn setImage:LoadImageByName(@"IMG_0633") forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
        [signImaView addSubview:submitBtn];
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField

{
    
    NSLog(@"textFieldDidBeginEditing");
    if (textField.tag == 23 || textField.tag == 22) {
        [UIView beginAnimations:nil context:NULL];//此处添加动画，使之变化平滑一点
                 [UIView setAnimationDuration:0.3];//设置动画时间 秒为单位
                signImaView.frame = CGRectMake(kScreen_Width/10,30-kScreen_Height/5, kScreen_Width/5*4, kScreen_Height/5*4);//UITextField位置的y坐标移动到offY
                 [UIView commitAnimations];//开始动画效果

    }
    
  }

-(void)onClickSelect:(UIButton *)sender{
    
    if (sender != self.selectedBtn) {
        self.selectedBtn.selected = NO;
        self.selectedBtn = sender;
        
        
    }
    self.selectedBtn.selected = YES;
    NSLog(@"选中了的是地%ld个",sender.tag);
    if (sender.tag == 10) {
        userSex = @"男";
    }else{
         userSex = @"女";
    }
   
    
    NSLog(@"是否是学生%@",userSex);
    
}

-(void)submitClick:(UITextField *)sender{
    
    
    NSLog(@"用户的性别%@",userSex);
     UITextField * field1 = (UITextField *)[self.view viewWithTag:20];//姓名
     UITextField * field3 = (UITextField *)[self.view viewWithTag:22];//年龄
     UITextField * field4 = (UITextField *)[self.view viewWithTag:23];//电话

    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
     [params setValue:field1.text forKey:@"name"];
     [params setValue:userSex forKey:@"sex"];
     [params setValue:field3.text forKey:@"age"];
     [params setValue:field4.text forKey:@"phone"];
    [params setValue:self.payFee forKey:@"price"];
    [params setValue:@"1" forKey:@"ispay"];
    [params setValue:[UserInfo sharedUserInfo].user_id forKey:@"user_id"];
     [params setValue:self.happy_Pid  forKey:@"pid"];
    NSLog(@"%@%@",userSex,self.happy_Pid);

    [[HttpClient shareInstance] requestApiWithurl:@"applay"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        NSMutableArray * dic = [response objectForKey:@"result"];
        NSLog(@"提交的的%@",dic);
        [signImaView removeFromSuperview];
        NSString * str =[NSString stringWithFormat:@"%@",dic[0]] ;
        if ([str isEqualToString:@"3"] ) {
            [HUD showAlertWithTitle:@"账户余额不足，请充值！"];
            ResourceBuyController * buy = [[ResourceBuyController alloc]init];
            [self.navigationController pushViewController:buy animated:YES];
        }

        if ([str isEqualToString:@"2"] ) {
            [HUD showAlertWithTitle:@"已报名！"];
        }
        if ([str isEqualToString:@"0"] ) {
            [HUD showAlertWithTitle:@"报名失败，请稍后重试！"];
        }

        if ([str isEqualToString:@"1"] ) {
            [HUD showAlertWithTitle:@"报名成功！"];
            
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

        
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"游乐园失败%@",response);
        
    }];

  
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [UIView beginAnimations:nil context:NULL];//此处添加动画，使之变化平滑一点
             [UIView setAnimationDuration:0.3];
              signImaView.frame = CGRectMake(kScreen_Width/10,30, kScreen_Width/5*4, kScreen_Height/5*4);;//UITextField位置复原
    
             [UIView commitAnimations];
    return YES;
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
