//
//  MyTabBarViewController.m
//
//
//  Created by fantasy on 16/2/19.
//  Copyright (c) 2016年 fantasy. All rights reserved.
//

#import "MyTabBarViewController.h"

#import "JourneyViewController.h"//旅程
#import "NewComerViewController.h"//新手村
#import "HotViewController.h"//世界
#import "ShoppingCentreController.h"//商城

@interface MyTabBarViewController ()

@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.backgroundColor=[UIColor whiteColor];
    [self creatChildViewControllers];
    // Do any additional setup after loading the view.
}
- (void)creatChildViewControllers{
    if ([[UserInfo sharedUserInfo].countrySideStyle isEqualToString:@"暗影村"]) {
        NewComerViewController * newComer =[[NewComerViewController alloc]init];
        [self setupChildViewController:newComer title:@"初心" imageName:@"chuxin_nor"  andSelectedImageName:@"chuxin_sel"];
        
        //旅程
        JourneyViewController * journey =[[JourneyViewController alloc]init];
        [self setupChildViewController:journey title:@"旅程" imageName:@"lvcheng_nor"  andSelectedImageName:@"lvcheng_sel"];
        
        //世界
        HotViewController * word =[[HotViewController alloc]init];
        [self setupChildViewController:word title:@"世界" imageName:@"shijie_nor"  andSelectedImageName:@"shijie_sel"];
        //我的
        ShoppingCentreController * shopping  =[[ShoppingCentreController alloc]init];
        [self setupChildViewController:shopping title:@"商城" imageName:@"shangcheng_nor" andSelectedImageName:@"shangcheng_sel"];

    }else{
        NewComerViewController * newComer =[[NewComerViewController alloc]init];
        [self setupChildViewController:newComer title:@"初心" imageName:@"chuxin_nor"  andSelectedImageName:@"chuxin_sel"];
        
        //旅程
        JourneyViewController * journey =[[JourneyViewController alloc]init];
        [self setupChildViewController:journey title:@"旅程" imageName:@"lvcheng_nor"  andSelectedImageName:@"lvcheng_sel"];
        
        //世界
        HotViewController * word =[[HotViewController alloc]init];
        [self setupChildViewController:word title:@"世界" imageName:@"shijie_nor"  andSelectedImageName:@"shijie_sel"];
        //我的
        ShoppingCentreController * shopping  =[[ShoppingCentreController alloc]init];
        [self setupChildViewController:shopping title:@"饰品屋" imageName:@"shangcheng_nor" andSelectedImageName:@"shangcheng_sel"];

    }
    
    
}
-(void)setupChildViewController:(UIViewController *)childVC title:(NSString *)title  imageName:(NSString *)imageName andSelectedImageName:(NSString *)selectedImageName{
    childVC.tabBarItem.title = title;
    self.tabBar.tintColor = [UIColor whiteColor];
    
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_di"]];
    img.frame = CGRectMake(0, 0, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
    img.contentMode = UIViewContentModeScaleToFill;
  
    [self.tabBar insertSubview:img atIndex:0];
    
    UIImage * image =[UIImage imageNamed:imageName];
    image =[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    childVC.tabBarItem.image = image;
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:childVC];
    
    
    navi.navigationBar.tintColor = [UIColor whiteColor];
    
    [ navi.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [navi.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_nav"] forBarMetrics:UIBarMetricsDefault];
  //  [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackTranslucent;  
    
    navi.navigationBar.translucent=NO;
    
    
    


    
       

    
    [self addChildViewController:navi];
}

@end
