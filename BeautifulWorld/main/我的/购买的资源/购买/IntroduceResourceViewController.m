//
//  IntroduceResourceViewController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/5/5.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "IntroduceResourceViewController.h"

@interface IntroduceResourceViewController ()

@end

@implementation IntroduceResourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView * backIma = [[UIImageView alloc]init];
    backIma.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height-NavBar_Height-StatusBar_Height);
    backIma.image = LoadImageByName(@"introduce.jpg");
    [self.view addSubview:backIma];
    // Do any additional setup after loading the view.
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
