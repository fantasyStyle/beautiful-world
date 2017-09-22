//
//  AboutUSController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/17.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "AboutUSController.h"
#define STOREAPPID @"1238576690"
@interface AboutUSController (){
    UILabel * version;
}

@end

@implementation AboutUSController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(230, 231, 234);
    [self initView];
    // Do any additional setup after loading the view.
}
-(void)initView{
    UIImageView * ima = [[UIImageView alloc]init];
    ima.frame = CGRectMake(kScreen_Width/7*3, 30, kScreen_Width/7, kScreen_Width/7);
    ima.image = LoadImageByName(@"标识");
    ima.layer.masksToBounds = YES;
    ima.layer.cornerRadius = kScreen_Width/14;
    //ima.backgroundColor = [UIColor redColor];
    [self.view addSubview:ima];
    
    UILabel * newLab = [[UILabel alloc]init];
    newLab.frame = CGRectMake(0, ima.y+ima.frame.size.height+20, kScreen_Width, 20);
    newLab.textAlignment = NSTextAlignmentCenter;
    newLab.font = font14;
    newLab.text = @"美丽新世界";
    [self.view addSubview:newLab];
    
    version = [[UILabel alloc]init];
    version.frame = CGRectMake(0, newLab.y+30, kScreen_Width, 20);
    version.textAlignment = NSTextAlignmentCenter;
    version.textColor = [UIColor darkGrayColor];
    version.font = font13;
   // version.text = @"当前版本： v1.0.0";
    [self.view addSubview:version];
    
    UILabel * lab1 = [[UILabel alloc]init];
    lab1.frame = CGRectMake(0, version.y+40, kScreen_Width, 20);
    lab1.text = @"西安同泽艺术品文化传播有限公司";
    lab1.font = font15;
    lab1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab1];
    
//    UILabel * lab2 = [[UILabel alloc]init];
//    lab2.frame = CGRectMake(0, lab1.y+25, kScreen_Width, 20);
//    lab2.font = font13;
//    lab2.textAlignment = NSTextAlignmentCenter;
//    lab2.text = @"在玩的过程中学习不同风格的绘画艺术，丰富自己的生活";
//    [self.view addSubview:lab2];
//    
    UILabel * lab3 = [[UILabel alloc]init];
    lab3.frame = CGRectMake(0, lab1.y+40, kScreen_Width, 20);
    lab3.font = font14;
    lab3.textAlignment = NSTextAlignmentCenter;
    lab3.text = @"电话： 029-85551996";
    [self.view addSubview:lab3];
    
    UILabel * lab4 = [[UILabel alloc]init];
    lab4.frame = CGRectMake(0, lab3.y+40, kScreen_Width, 20);
    lab4.font = font14;
    lab4.textAlignment = NSTextAlignmentCenter;
    lab4.text = @"邮箱：xiantongze@163.com";
    [self.view addSubview:lab4];
    
//    UILabel * lab5 = [[UILabel alloc]init];
//    lab5.frame = CGRectMake(0, lab4.y+22, kScreen_Width, 20);
//    lab5.font = font14;
//    lab5.textAlignment = NSTextAlignmentCenter;
//    lab5.text = @"周一到周六8:30～18:00";
//    [self.view addSubview:lab5];
 
    UIButton * check = [UIButton buttonWithType:UIButtonTypeCustom];
    check.backgroundColor = RGBColor(50, 156, 220);
    check.frame = CGRectMake(10, lab4.y+50, kScreen_Width-20, 45);
    [check setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [check setTitle:@"检查新版本" forState:UIControlStateNormal];
    check.titleLabel.font = font15;
    [check addTarget:self action:@selector(hsUpdateApp) forControlEvents:UIControlEventTouchUpInside];
    check.layer.masksToBounds = YES;
    check.layer.cornerRadius  = 10;
    [self.view addSubview:check];



    
    
    
}
//版本更新
-(void)hsUpdateApp
{
    //2先获取当前工程项目版本号
    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
    
    //3从网络获取appStore版本号
    NSError *error;
    NSData *response = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",STOREAPPID]]] returningResponse:nil error:nil];
    if (response == nil) {
        NSLog(@"你没有连接网络哦");
        return;
    }
    NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    if (error) {
        NSLog(@"hsUpdateAppError:%@",error);
        return;
    }
    //    NSLog(@"%@",appInfoDic);
    NSMutableArray * array = appInfoDic[@"results"];
    
    NSLog(@"渠道的数据%@",appInfoDic);
    if (array.count == 0) {
        [HUD showAlertWithTitle:@"已经是最新版了"];
    }
    else{
        
   
    NSDictionary *dic = array[0];
    NSString *appStoreVersion = dic[@"version"];
    
    //打印版本号
    NSLog(@"当前版本号:%@\n商店版本号:%@",currentVersion,appStoreVersion);
    //设置版本号
    currentVersion = [currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    if (currentVersion.length==2) {
        currentVersion  = [currentVersion stringByAppendingString:@"0"];
    }else if (currentVersion.length==1){
        currentVersion  = [currentVersion stringByAppendingString:@"00"];
    }
    appStoreVersion = [appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    if (appStoreVersion.length==2) {
        appStoreVersion  = [appStoreVersion stringByAppendingString:@"0"];
    }else if (appStoreVersion.length==1){
        appStoreVersion  = [appStoreVersion stringByAppendingString:@"00"];
    }
    version.text =[NSString stringWithFormat:@"当前版本： v%@",appStoreVersion];
    //4当前版本号小于商店版本号,就更新
    if([currentVersion floatValue] < [appStoreVersion floatValue])
    {
        UIAlertController *alercConteoller = [UIAlertController alertControllerWithTitle:@"版本有更新" message:[NSString stringWithFormat:@"检测到新版本(%@),是否更新?",dic[@"version"]] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //此处加入应用在app store的地址，方便用户去更新，一种实现方式如下
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", STOREAPPID]];
            [[UIApplication sharedApplication] openURL:url];
        }];
        UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alercConteoller addAction:actionYes];
        [alercConteoller addAction:actionNo];
        [self presentViewController:alercConteoller animated:YES completion:nil];
    }else{
        NSLog(@"版本号好像比商店大噢!检测到不需要更新");
        [HUD showAlertWithTitle:@"版本号好像比商店大噢!检测到不需要更新"];
    }
    
    
    
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
