//
//  NoticeViewController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/12.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "NoticeViewController.h"
#define kscH (kScreen_Height-NavBar_Height-StatusBar_Height)
@interface NoticeViewController ()

@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}
-(void)initView{
    UIImageView * ima = [[UIImageView alloc]init];
    ima.image  = LoadImageByName(@"公告1");
    ima.frame = CGRectMake(0, 0, kScreen_Width, kscH/3);
    [self.view addSubview:ima];
    
    UIImageView * ima2 = [[UIImageView alloc]init];
    ima2.image = LoadImageByName(@"公告2");
    ima2.frame = CGRectMake(0, kscH/3, kScreen_Width, kscH/3*2);
    [self.view addSubview:ima2];
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
