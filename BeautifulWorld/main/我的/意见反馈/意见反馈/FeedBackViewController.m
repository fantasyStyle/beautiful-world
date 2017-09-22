
//
//  FeedBackViewController.m
//  demo
//
//  Created by yuanju001 on 16/9/22.
//  Copyright © 2016年 yuanju001. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"意见反馈";
    self.view.backgroundColor = RGBColor(230, 231, 234);
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(submiitClick)];
    [self creatBackSuggestion];
    
}
-(void)submiitClick{
    
    [FTShowMessageView showStatusWithMessage:@"Loading..."];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:[UserInfo sharedUserInfo].user_id forKey:@"user_id"];
     [params setValue:_textView.prevText forKey:@"content"];
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss SS"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"dateString:%@",dateString);
    
    [params setValue:dateString forKey:@"time"];
    
    [[HttpClient shareInstance] requestApiWithurl:@"feedBack"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"成功%@",response);
        [FTShowMessageView dismissSuccessView:@"Success"];
        NSMutableArray * dic = [response objectForKey:@"result"];

        NSString * str =[NSString stringWithFormat:@"%@",dic[0]] ;

        if ([str isEqualToString:@"0"] ) {
            [HUD showAlertWithTitle:@"提交失败"];
        }
        
        if ([str isEqualToString:@"1"] ) {
            [HUD showAlertWithTitle:@"提交成功"];
        }
        

        
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"失败%@",response);
        [FTShowMessageView dismiss];
        
        //[FTShowMessageView dismissErrorView:@"加载数据失败，请稍后重试"];
        
    }];
    
    

}
-(void)creatBackSuggestion{
    _textView = [[CBTextView alloc] init];
    _textView.placeHolderColor = [UIColor grayColor];
    _textView.frame = CGRectMake(0, 5, kScreen_Width, kScreen_Height/4);
     _textView.placeHolder = @"您可以在此输入意见与建议";
    [self.view addSubview:_textView];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
