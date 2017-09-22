//
//  BuyDetailIntroduceViewController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/6/5.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "BuyDetailIntroduceViewController.h"

@interface BuyDetailIntroduceViewController ()

@end

@implementation BuyDetailIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self.type isEqualToString:@"text"]) {
        [self initLab];
    }else{
        [self initWeb];
    }
    
    
        // Do any additional setup after loading the view.
}
-(void)initWeb{
    UIWebView * web =[[UIWebView alloc]init];
    //设置位置及大小
    web.frame = self.view.bounds;
    
    NSURL * url1 =[[NSURL alloc]initWithString:_content];
    //定义网址请求
    NSURLRequest * request = [NSURLRequest requestWithURL:url1];
    //加载请求
    [web loadRequest:request];
    //设置代理
    //web.delegate=self;
    [self.view addSubview:web];
    

}
-(void)initLab{
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(20, kScreen_Height/3, kScreen_Width-20, 40)];
    lab.numberOfLines =2;
    lab.textColor = [UIColor darkGrayColor];
    lab.font = [UIFont systemFontOfSize:20];
    lab.text = _content;
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
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
