//
//  WelcomeViewController.m
//  demo
//
//  Created by yuanju001 on 16/9/19.
//  Copyright © 2016年 yuanju001. All rights reserved.
//

#import "WelcomeViewController.h"
#import "MyTabBarViewController.h"

#import "SimpleChooseController.h"//难易程度选择页面
#define kImageCount 3

@interface WelcomeViewController ()<UIScrollViewDelegate>{
    UIButton * lightBtn;
    UIButton * blackBtn;
    UIImageView * selectView;
    UIImageView * leftView;
    UIImageView * rightView;
}
@property (nonatomic,strong)UIScrollView * scroll;
@property (nonatomic,strong)UIPageControl * pageControl;

//@property (nonatomic, strong) GlobalView *globalView;
@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self creatScrollView];
//    [self setterImageview];
  
//  [self addNewPageLightOrGray];
    [self creatWelcomeView];
//    [self addNpcCust];
//    [self addNpcLabel];
   // [self addGlobalView];

  
    // Do any additional setup after loading the view.
}

-(void)creatWelcomeView{
    self.view.backgroundColor = [UIColor whiteColor];
    selectView = [[UIImageView alloc]init];
    selectView.frame = CGRectMake(0, 0, 80, 100);
    selectView.center = self.view.center;
    selectView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:selectView];
    
    
    
    leftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width/2, kScreen_Height)];
//    leftView.backgroundColor = [UIColor redColor];
    leftView.image = LoadImageByName(@"guangming_01");
    leftView.tag = 11;
    [leftView addTapTraget:self withAction:@selector(onEnterClick:)];
    
    rightView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width/2, 0, kScreen_Width/2,kScreen_Height)];
    //rightView.backgroundColor = [UIColor greenColor];
    rightView.tag = 12;
    rightView.image = LoadImageByName(@"heian_02");
    [rightView addTapTraget:self withAction:@selector(onEnterClick:)];
    [self.view addSubview:leftView];
    [self.view addSubview:rightView];
    
}
-(void)onEnterClick:(UITapGestureRecognizer*)tap{
    [UIView animateWithDuration:2 animations:^{
     
        [leftView setTransform:(CGAffineTransformMakeTranslation(-kScreen_Width/2,0))];
        [rightView setTransform:(CGAffineTransformMakeTranslation(kScreen_Width/2,0))];
        if (tap.view.tag == 11) {
            selectView.image = LoadImageByName(@"光明");
        }
        else{
            selectView.image = LoadImageByName(@"黑暗");
        
        }
        selectView.transform = CGAffineTransformMakeScale(2.5, 2.5);
        
        
    } completion:^(BOOL finished) {
        SimpleChooseController * choose = [[SimpleChooseController alloc]init];
        [self presentViewController:choose animated:YES completion:^{
            
            
        }];
        
        
    }];
    

    

}
#pragma mark -创建npc
-(void)addNpcCust{
    UIImageView * npcImgView = [[UIImageView alloc]init];
    npcImgView.frame = CGRectMake(kScreen_Width/6*5, kScreen_Width/8, kScreen_Width/6, kScreen_Width/6);
    npcImgView.image = LoadImageByName(@"npc");
    [self.view addSubview:npcImgView];
}

-(void)addNpcLabel{
    UILabel * npcLab = [[UILabel alloc]init];
    npcLab.frame = CGRectMake(0, 0, kScreen_Width/3, 0);
    [npcLab setNumberOfLines:0];
    NSString * str = @"尊敬的用户，欢迎进入美丽新世界。我是新世界的精灵小美，将由我带您一起来来体验新世界";
    npcLab.text = str;
    npcLab.font = [UIFont systemFontOfSize:20];
//    npcLab.textColor = RGB(66, 175, 213);
    npcLab.textColor = [UIColor greenColor];
    //显示边框
//    npcLab.layer.borderWidth=1.0;
//    npcLab.layer.borderColor= [[UIColor brownColor] CGColor];
    npcLab.backgroundColor = RGBColor(66, 175, 213);
    npcLab.layer.masksToBounds = YES;
    npcLab.layer.cornerRadius =20.0;
    npcLab.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [npcLab sizeThatFits:CGSizeMake(npcLab.frame.size.width, MAXFLOAT)];
    npcLab.frame = CGRectMake(kScreen_Width/6, kScreen_Width/5, kScreen_Width/3*2, size.height);
     [self.view addSubview:npcLab];
    npcLab.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    [UIView animateWithDuration:2.0f animations:^{
       
        npcLab.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    
    }];

    
    
    
}
#pragma mark -创建新手村页面
-(void)addNewPageLightOrGray{
    
    UIImageView * backIma  = [[UIImageView alloc]initWithFrame:CGRectMake(0, -20, kScreen_Width, kScreen_Height+20)];
    
    backIma.image = LoadImageByName(@"背景");
    [self.view addSubview:backIma];
    
   lightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lightBtn.frame = CGRectMake(kScreen_Width/16*3, kScreen_Height/5*2, kScreen_Width/8, kScreen_Height/5);
    [lightBtn setImage:LoadImageByName(@"光明") forState:UIControlStateNormal];
    [lightBtn addTapTraget:self withAction:@selector(lightClick)];
    [self.view addSubview:lightBtn];
    
    blackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    blackBtn.frame = CGRectMake(kScreen_Width/16*11, kScreen_Height/5*2, kScreen_Width/8, kScreen_Height/5);
    [blackBtn setImage:LoadImageByName(@"黑暗") forState:UIControlStateNormal];
    [blackBtn addTapTraget:self withAction:@selector(blackClick)];
    [self.view addSubview:blackBtn];

}
-(void)lightClick{
    [UserInfo sharedUserInfo].countrySideStyle = @"光明村";
    [[UserInfo sharedUserInfo] saveUserInofFromSanbox];
    
    [UIView animateWithDuration:2 animations:^{
        lightBtn.transform=CGAffineTransformTranslate(lightBtn.transform,kScreen_Width/4,0);
        lightBtn.transform = CGAffineTransformScale(lightBtn.transform, 1.5, 1.5);

        [blackBtn setTransform:(CGAffineTransformMakeTranslation(-kScreen_Width/4,0))];
        [blackBtn setAlpha:0];
        
    } completion:^(BOOL finished) {
            SimpleChooseController * choose = [[SimpleChooseController alloc]init];
            [self presentViewController:choose animated:YES completion:^{
        
        
            }];
        

    }];
    
    

}
-(void)blackClick{
    
    
    [UserInfo sharedUserInfo].countrySideStyle = @"暗影村";
    [[UserInfo sharedUserInfo] saveUserInofFromSanbox];
    
    [UIView animateWithDuration:2 animations:^{
        blackBtn.transform=CGAffineTransformTranslate(blackBtn.transform,-kScreen_Width/4,0);
        blackBtn.transform = CGAffineTransformScale(blackBtn.transform, 1.5, 1.5);
        
        [lightBtn setTransform:(CGAffineTransformMakeTranslation(kScreen_Width/4,0))];
        [lightBtn setAlpha:0];
        
    } completion:^(BOOL finished) {
        SimpleChooseController * choose = [[SimpleChooseController alloc]init];
        [self presentViewController:choose animated:YES completion:^{
            
            
        }];
        
        
    }];

    

}
#pragma mark -创建滑动页
- (void)creatScrollView{
    _scroll =[[UIScrollView alloc]init];
    _scroll.frame=[UIScreen mainScreen].bounds;
    [self.view addSubview:_scroll];
}
-(void)enterLight{
    NSLog(@"进入光明村");
    
    SimpleChooseController * choose = [[SimpleChooseController alloc]init];
    [self presentViewController:choose animated:YES completion:^{
        
        
    }];
    
}
-(void)enterBlack{
    NSLog(@"进入黑暗村");
    SimpleChooseController * choose = [[SimpleChooseController alloc]init];
    [self presentViewController:choose animated:YES completion:^{
        
        
    }];

}
@end
