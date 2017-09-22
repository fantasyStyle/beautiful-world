//
//  BaseViewController.m
//  DouYU
//
//  Created by Alesary on 15/10/29.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import "BaseViewController.h"
#import "MineViewController.h"
#import "ResourceBuyController.h"
#import "LoginViewController.h"//登录
#import "UserHelpViewController.h"//帮助
#import "UIButton+WebCache.h"
//进度条
#import "CustomProgress.h"
@interface BaseViewController (){
    UIButton * diamond;//钻石
    UIButton * goldCoin;//金币
    UIButton * help;//帮助
    UIImageView * vipIma;//会员
    UILabel * nameLab;//name;

}

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view setNeedsDisplay];
    [self initNavi];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   }
-(void)initNavi{
    UIButton * personIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    personIcon.backgroundColor = [UIColor whiteColor];
    personIcon.frame = CGRectMake(0, 0, 35, 35);
    personIcon.layer.masksToBounds = YES;
    personIcon.layer.cornerRadius = 17.5;
    personIcon.contentMode = UIViewContentModeScaleAspectFit;
    
    [personIcon addTarget:self action:@selector(personClick) forControlEvents:UIControlEventTouchUpInside];
    
    
//    UIImageView * frameK = [[UIImageView alloc]init];
//    frameK.frame = CGRectMake(0, 0, 40, 40);
//    frameK.image = LoadImageByName(@"边框1");
//    personIcon.center = frameK.center;
//    [frameK addSubview:personIcon];
    UIBarButtonItem * leftView = [[UIBarButtonItem alloc]initWithCustomView:personIcon];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -13;  //偏移距离  -向左偏移, +向右偏移
    // self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftView];
    
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftView];
    
    
    UIView * custView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width-35,44)];
    //custView.backgroundColor = [UIColor redColor];
    self.navigationItem.titleView  = custView;
//    //进度条
//    
//    UILabel * grade = [[UILabel alloc]initWithFrame:CGRectMake(0, 22, 30, 18)];
//    grade.textColor = [UIColor whiteColor];
//    grade.font = font12;
//    
//    [custView addSubview:grade];
//    
    
//    CustomProgress * progress = [[CustomProgress alloc]initWithFrame:CGRectMake(30, 28, 50, 8)];
//    progress.maxValue = 20;
//    //设置背景色
//    progress.bgimg.backgroundColor =[UIColor colorWithRed:252/255.0 green:120/255.0 blue:121/255.0 alpha:0.5];
//    progress.leftimg.backgroundColor =[UIColor colorWithRed:252/255.0 green:120/255.0 blue:121/255.0 alpha:1];;
//    
//    [progress setPresent:6];
//    [custView addSubview:progress];
    //钻石
    diamond   = [UIButton buttonWithType:UIButtonTypeCustom];
    diamond.frame = CGRectMake(120, 10, 50, 30);
    
    diamond.titleLabel.font = [UIFont systemFontOfSize:12];
    [diamond setImageEdgeInsets:UIEdgeInsetsMake(0, -2, 0, 0)];
    [diamond setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0,-10)];
    
    [diamond setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [diamond addTarget:self action:@selector(onBuy) forControlEvents:UIControlEventTouchUpInside];
    //[custView addSubview:diamond];
    
    //金币
    goldCoin = [UIButton buttonWithType:UIButtonTypeCustom];
    goldCoin.frame = CGRectMake(180, 10, 50,30);
    goldCoin.titleLabel.font = [UIFont systemFontOfSize:12];
    [goldCoin setImageEdgeInsets:UIEdgeInsetsMake(0, -2, 0, 0)];
    [goldCoin setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0,-10)];
    
    [goldCoin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [goldCoin addTarget:self action:@selector(onBuy) forControlEvents:UIControlEventTouchUpInside];
    
    //[custView addSubview:goldCoin];

    
    if ([[UserInfo sharedUserInfo].isLogin isEqualToString:@"1"]) {
        nameLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,0, 0)];
        nameLab.text =[UserInfo sharedUserInfo].nickName;
        nameLab.font = font14;
        nameLab.textColor = [UIColor whiteColor];
        [nameLab setNumberOfLines:0];
//        nameLab.backgroundColor = [UIColor redColor];
        CGSize size = [nameLab.text boundingRectWithSize:CGSizeMake(300, nameLab.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:nameLab.font} context:nil].size;
        nameLab.frame = CGRectMake(0, 12, size.width, size.height);
        [custView addSubview:nameLab];
        
        
        vipIma = [[UIImageView alloc]init];
        vipIma.frame = CGRectMake(nameLab.frame.size.width, 12, 20, 20);
        vipIma.contentMode = UIViewContentModeScaleAspectFill;
        //[custView addSubview:vipIma];
        
        NSString * str = [NSString stringWithFormat:@"%@%@",BaseShopUrl,[UserInfo sharedUserInfo].iconUser];
        [personIcon sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal placeholderImage:LoadImageByName(@"教师风采")];
        
        if ([[UserInfo sharedUserInfo].vipType isEqualToString:@"0"]) {
            vipIma.hidden = YES;
        }
        if ([[UserInfo sharedUserInfo].vipType isEqualToString:@"1"]) {
            vipIma.hidden = NO;
            vipIma.image = LoadImageByName(@"putonghuiyuan_03");
        }
        if ([[UserInfo sharedUserInfo].vipType isEqualToString:@"2"]) {
            vipIma.hidden = NO;
            vipIma.image = LoadImageByName(@"chaojihuiyuan_03");
        }
        //
        
        [diamond setTitle:[UserInfo sharedUserInfo].userJewel forState:UIControlStateNormal];
        [goldCoin setTitle:[UserInfo sharedUserInfo].userGold forState:UIControlStateNormal];
    }
    else{
        [personIcon setImage:LoadImageByName(@"head_weidenglu_03") forState:UIControlStateNormal];
        nameLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,0, 0)];
        nameLab.text =[UserInfo sharedUserInfo].nickName;
        nameLab.font = font14;
          nameLab.text = @"请登陆／注册";
        
        nameLab.textColor = [UIColor whiteColor];
        [nameLab setNumberOfLines:0];
        //        nameLab.backgroundColor = [UIColor redColor];
        CGSize size = [nameLab.text boundingRectWithSize:CGSizeMake(300, nameLab.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:nameLab.font} context:nil].size;
        nameLab.frame = CGRectMake(0, 12, size.width, size.height);
        [custView addSubview:nameLab];

      
        [diamond setTitle:@"0" forState:UIControlStateNormal];
        [goldCoin setTitle:@"0" forState:UIControlStateNormal];
        
    }

    
    
    
 
    
    
    
    
    
    NSLog(@"用户选择的风格是:%@",[UserInfo sharedUserInfo].countrySideStyle);
    
    help = [UIButton buttonWithType:UIButtonTypeCustom];
    help.frame = CGRectMake(0, 0, 35, 35);
    [help addTarget:self action:@selector(onHelp) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * helpBar = [[UIBarButtonItem alloc]initWithCustomView:help];
    
    
    [diamond setImage:LoadImageByName(@"zuan_03") forState:UIControlStateNormal];
    [goldCoin setImage:LoadImageByName(@"jinbi_04") forState:UIControlStateNormal];
    [help setImage:LoadImageByName(@"帮助光明") forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem =helpBar;
    
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(viewWillAppear:) name:@"personInfo" object:nil];
    

}

-(void)onBuy{
    if ([[UserInfo sharedUserInfo].isLogin isEqualToString:@"0"]) {
        [HUD showAlertWithTitle:@"敬请登录"];        //
    }else{
        ResourceBuyController * buy = [[ResourceBuyController alloc]init];
        buy.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:buy animated:YES];
        
    }

   }
-(void)onHelp{
    UserHelpViewController * helper  =[[UserHelpViewController alloc]init];
    helper.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:helper animated:YES];
}
-(void)personClick{

    
    if ([[UserInfo sharedUserInfo].isLogin isEqualToString:@"1"]) {
        MineViewController * mine = [[MineViewController alloc]init];
        mine.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mine animated:YES];
    }else{
        LoginViewController * login = [[LoginViewController alloc]init];
        login.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:login animated:YES];
        
    }
    
  
}
#pragma mark -- 是否登录
//-(BOOL)isUserLogin
//{
//    NSString *userId =  [UserInfo sharedUserInfo].isLogin;
//    
//    if (userId != nil && [userId intValue] > 0)
//    {
//        //已经登录
//        return YES;
//    }
//    return NO;
//    
//}
// 返回按钮
- (void)backButtonClick:(UIButton *)sender {
    // 关闭当前的ViewController
    UIViewController *vc = self.navigationController.topViewController;
    
    if (vc != nil && [vc isKindOfClass:self.class]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"模态方式关闭的");
        }];
    }
}

@end
