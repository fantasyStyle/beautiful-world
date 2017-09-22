//
//  SimpleChooseController.m
//  NewWorld
//
//  Created by fantasy  on 2017/2/21.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "SimpleChooseController.h"
#import "MyTabBarViewController.h"
@interface SimpleChooseController (){
    UIButton * chooseBtn;
    BOOL animating;
    UIImageView * ima;
    UIImageView * NPCIma;
    UIImageView * knowIma;
    UIImageView * helpNpc;
    
}
@property (nonatomic,strong)UIButton * selectedBtn;
@end

@implementation SimpleChooseController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initBottomBtn];
    [self initHelp];
   
    // Do any additional setup after loading the view.
}
-(void)initBottomBtn{
    UIImageView * backIma  = [[UIImageView alloc]initWithFrame:self.view.frame];
    backIma.frame =CGRectMake(0, -20, kScreen_Width, kScreen_Height+20);
    backIma.image = LoadImageByName(@"背景2");
    backIma.userInteractionEnabled =YES;
    [self.view addSubview:backIma];

    
    NSArray * imaArr = @[@"xingxi",@"yinhe",@"yuzhou"];
    CGFloat margin = kScreen_Height/4;
    CGFloat btnW = kScreen_Width/4;
    CGFloat marginY = kScreen_Height/12;
    for (NSInteger i = 0; i<3; i++) {
        chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        chooseBtn.frame =CGRectMake(kScreen_Width/8*3, margin+(btnW+marginY)*i, btnW, btnW);
        chooseBtn.tag = i+100;
        [chooseBtn setImage:LoadImageByName(imaArr[i]) forState:UIControlStateNormal];
         [chooseBtn addTarget:self action:@selector(onClickBtn:) forControlEvents:UIControlEventTouchUpInside];
              [backIma addSubview:chooseBtn];
        
        ima = [[UIImageView alloc]init];
        ima.tag = chooseBtn.tag+10;
        ima.frame = CGRectMake(0, 0, btnW, btnW);
        ima.image = LoadImageByName(@"dengji");
        [chooseBtn addSubview:ima];
        
    }
  
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self craetNPC];
   }
-(void)craetNPC{
    NPCIma = [[UIImageView alloc]init];
    NPCIma.frame = CGRectMake(kScreen_Width/6, kScreen_Height/4, kScreen_Width/3*2, kScreen_Height/2);
    NPCIma.image = LoadImageByName(@"NPC_03");
    NPCIma.userInteractionEnabled = YES;
    [self.view addSubview:NPCIma];
    
    
    knowIma  = [[UIImageView alloc]init];
    knowIma.frame = CGRectMake(NPCIma.frame.size.width/3, NPCIma.frame.size.height/7*6, NPCIma.frame.size.width/3, NPCIma.frame.size.height/9);
    knowIma.image = LoadImageByName(@"ok_03");
    [knowIma addTapTraget:self withAction:@selector(onRemoveNPC)];
    [NPCIma addSubview:knowIma];
    

}
-(void)initHelp{
    helpNpc = [[UIImageView alloc]init];
    helpNpc.frame = CGRectMake(kScreen_Width/6*5, kScreen_Height/12*11, kScreen_Width/10, kScreen_Width/10);
    helpNpc.image = LoadImageByName(@"？_03");
    [helpNpc addTapTraget:self withAction:@selector(onRemoveNPC)];
    [self.view addSubview:helpNpc];
    
}
-(void)onRemoveNPC{
    NSLog(@"点击了当前npc");
    [NPCIma removeFromSuperview];
    [helpNpc addTapTraget:self withAction:@selector(craetNPC)];
}
-(void)onClickBtn:(UIButton *)sender{
    
//    MyTabBarViewController * myTabBar =[[MyTabBarViewController alloc]init];
//    [self presentViewController:myTabBar animated:YES completion:^{
    
        

    UIImageView * btn1 =ViewWithTag(self.view, 110);
    UIImageView * btn2 = ViewWithTag(self.view , 111);
    UIImageView * btn3 = ViewWithTag(self.view , 112);
  
        switch (sender.tag) {
            case 100:{
                [self startAnimationWithView:btn1];
                [self stopAnimationWithView:btn2];
                [self stopAnimationWithView:btn3];
                [UserInfo sharedUserInfo].countrySideStyle = @"简单";
                [[UserInfo sharedUserInfo] saveUserInofFromSanbox];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    MyTabBarViewController * myTab = [[MyTabBarViewController alloc]init];
                    [self presentViewController:myTab animated:YES completion:^{
                        
                        
                    }];
                    
                    
                });
                
                NSLog(@"进入大神");
            }
                break;
            case 101:{
                
                [self startAnimationWithView:btn2];
                [self stopAnimationWithView:btn1];
                [self stopAnimationWithView:btn3];
                [UserInfo sharedUserInfo].countrySideStyle = @"一般";
                [[UserInfo sharedUserInfo] saveUserInofFromSanbox];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    MyTabBarViewController * myTab = [[MyTabBarViewController alloc]init];
                    [self presentViewController:myTab animated:YES completion:^{
                        
                        
                    }];
                    
                    
                });
                
                NSLog(@"进入普通");
                
            }
                break;
            case 102:{
                [self startAnimationWithView:btn3];
                [self stopAnimationWithView:btn1];
                [self stopAnimationWithView:btn2];
                NSLog(@"进入菜鸟");
                [UserInfo sharedUserInfo].countrySideStyle = @"困难";
                [[UserInfo sharedUserInfo] saveUserInofFromSanbox];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    //        [self stopAnimationWithView:sender];
                    MyTabBarViewController * myTab = [[MyTabBarViewController alloc]init];
                    [self presentViewController:myTab animated:YES completion:^{
                        
                        
                    }];
                    
                });
                
                
                
            }
                break;
                
            default:
                break;
      //}

    }
}
- (void)startAnimationWithView:(UIImageView *)btn
{
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 0.5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    [btn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)stopAnimationWithView:(UIImageView *)btn
{
    [btn.layer removeAllAnimations];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
