//
//  LoadFailView.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/5/10.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "LoadFailView.h"

@implementation LoadFailView

-(id)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height-NavBar_Height-StatusBar_Height);
        self.backgroundColor = [UIColor whiteColor];
        
        [self initView];
           }
    
    return self;
}
-(void)initView{
    UIImageView * failIma = [[UIImageView alloc]init];
    failIma.frame = CGRectMake(kScreen_Width/3, kScreen_Height/4, kScreen_Width/3, kScreen_Width/3);
    failIma.image = LoadImageByName(@"jiazaicuowu_03");
    [self addSubview:failIma];
    
    UILabel * failLab = [[UILabel alloc]init];
    failLab.frame = CGRectMake(0, failIma.y+failIma.frame.size.height, kScreen_Width, 20);
    failLab.textAlignment = NSTextAlignmentCenter;
    failLab.textColor = [UIColor grayColor];
    failLab.text = @"网络加载错误";
    [self addSubview:failLab];
    
    _retryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _retryBtn.frame = CGRectMake(kScreen_Width/5*2, failLab.y+failLab.frame.size.height+10, kScreen_Width/5, 32);
    _retryBtn.backgroundColor = RGBColor(49, 150, 212);
    _retryBtn.layer.masksToBounds = YES;
    _retryBtn.layer.cornerRadius = 10;
    _retryBtn.titleLabel.font = font15;
    [_retryBtn setTitle:@"点击重试" forState:UIControlStateNormal];
    [_retryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_retryBtn];
}
@end
