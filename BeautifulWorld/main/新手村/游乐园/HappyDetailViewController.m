//
//  HappyDetailViewController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/12.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "HappyDetailViewController.h"

@interface HappyDetailViewController ()

@end

@implementation HappyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    self.navigationItem.title =@"活动详情";
    // Do any additional setup after loading the view.
}
-(void)initView{
    
    
    UIScrollView * scroll = [[UIScrollView alloc]initWithFrame:self.view.bounds];
   
    scroll.backgroundColor = [UIColor whiteColor];
    scroll.contentSize = CGSizeMake(kScreen_Width, kScreen_Height*2);
    [self.view addSubview:scroll];
    UIImageView * backIma = [[UIImageView alloc]init];
//    backIma.image = LoadImageByName(@"活动详情");
    backIma.frame = scroll.bounds;
    NSString * str = [NSString stringWithFormat:@"%@%@",BaseActUrl,self.introUrl];
    
    backIma.contentMode = UIViewContentModeScaleAspectFit | UIViewContentModeTopLeft;
    [backIma sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:LoadImageByName(@"活动详情")];
   
    [scroll addSubview:backIma];

    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
