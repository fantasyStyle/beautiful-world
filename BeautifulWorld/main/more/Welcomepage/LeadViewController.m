//
//  LeadViewController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/28.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "LeadViewController.h"
#define kImageCount 3
#import "WelcomeViewController.h"
#import "SimpleChooseController.h"
#import "MyTabBarViewController.h"
@interface LeadViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView * scroll;
@property (nonatomic,strong)UIPageControl * pageControl;

@end

@implementation LeadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatScrollView];
    [self setterImageview];
    // Do any additional setup after loading the view.
}
#pragma mark -创建滑动页
- (void)creatScrollView{
    _scroll =[[UIScrollView alloc]init];
    _scroll.frame=[UIScreen mainScreen].bounds;
    [self.view addSubview:_scroll];
    
    //创建UIPageControl
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kScreen_Height-40, kScreen_Width, 10)];  //创建UIPageControl，位置在屏幕最下方。
    _pageControl.numberOfPages = 3;//总的图片页数
    _pageControl.currentPage = 0; //当前页
    [_pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];  //用户点击UIPageControl的响应函数
    [self.view addSubview:_pageControl];  //将UIPageControl添加到主界面上。
}
-  (void)setterImageview{
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    for (NSInteger i = 0;  i < kImageCount; i++) {
        UIImageView * imgView =[[UIImageView alloc]init];
        [imgView setFrame:CGRectMake(i*width, 0, width, height)];
        NSString * imgName =[NSString stringWithFormat:@"yindao_0%ld.png",i+1];
        [imgView setImage:[UIImage imageNamed:imgName]];
        [_scroll addSubview:imgView];
        if (i == kImageCount - 1) {
//            // 图像和用户响应

            UIButton * enter = [UIButton buttonWithType:UIButtonTypeCustom];
            enter.frame = CGRectMake(kScreen_Width/5*2, kScreen_Height-80, kScreen_Width/5, 30) ;
            
            [enter addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
            enter.backgroundColor = RGBColor(102, 188, 204);
            enter.layer.masksToBounds = YES;
            enter.layer.cornerRadius = 10;
            [enter setTitle:@"进入" forState:UIControlStateNormal];
            [imgView addSubview:enter];
            // [tap addTarget:self action:@selector(onClick)];
            [imgView setUserInteractionEnabled:YES];
//            [imgView addGestureRecognizer:tap];
        }
        //[_scroll addSubview:imgView];

    }
    _scroll.contentSize = CGSizeMake(kImageCount * width, height);
    _scroll.pagingEnabled = YES;
    _scroll.bounces=NO;
    _scroll.delegate=self;
    _scroll.showsHorizontalScrollIndicator=NO;

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //更新UIPageControl的当前页
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [_pageControl setCurrentPage:offset.x / bounds.size.width];
    NSLog(@"%f",offset.x / bounds.size.width);
}
//然后是点击UIPageControl时的响应函数pageTurn


- (void)pageTurn:(UIPageControl*)sender
{
    //令UIScrollView做出相应的滑动显示
    CGSize viewSize = _scroll.frame.size;
    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    [_scroll scrollRectToVisible:rect animated:YES];
}
-(void)onClick{

//    SimpleChooseController * choose = [[SimpleChooseController alloc]init];
//    [self presentViewController:choose animated:YES completion:^{
//        
//        
//    }];
    
    [UserInfo sharedUserInfo].isLogin  = @"0";
    [[UserInfo sharedUserInfo] saveUserInofFromSanbox];
    
    MyTabBarViewController * mytab =[[MyTabBarViewController alloc]init];
    [self presentViewController:mytab animated:YES completion:^{
        
        
    }];
}
@end
