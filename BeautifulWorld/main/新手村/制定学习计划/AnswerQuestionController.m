//
//  AnswerQuestionController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/27.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "AnswerQuestionController.h"
#import "HUD.h"
@interface AnswerQuestionController (){
    UILabel * qusetionLab;
}

@end

@implementation AnswerQuestionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(230, 231, 234);
    [self creatView];
    [self creatBottomView];
    // Do any additional setup after loading the view.
}



-(void)creatView{
    
    qusetionLab = [[UILabel alloc]init];
    qusetionLab.frame = CGRectMake(0, 30, kScreen_Width, 0);
   // qusetionLab.backgroundColor = [UIColor whiteColor];
    [qusetionLab setNumberOfLines:0];
    qusetionLab.textColor = [UIColor grayColor];
    qusetionLab.font = [UIFont systemFontOfSize:15];
    
    qusetionLab.text = @"人体比比例是？（立七坐五盘三半）";
    
    qusetionLab.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [qusetionLab sizeThatFits:CGSizeMake(qusetionLab.frame.size.width, MAXFLOAT)];
    qusetionLab.frame = CGRectMake(0, 30, kScreen_Width, size.height);
    [self.view  addSubview:qusetionLab];
    
    _textView = [[CBTextView alloc] init];
    _textView.placeHolderColor = [UIColor grayColor];
    _textView.frame = CGRectMake(0, qusetionLab.y+qusetionLab.frame.size.height+20, kScreen_Width, kScreen_Height/4);
    _textView.placeHolder = @"您可以在此输入答案";
    [self.view addSubview:_textView];

    
    

}
-(void)creatBottomView{
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreen_Height-NavBar_Height-StatusBar_Height-42, kScreen_Width, 42)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    UIButton * submit = [UIButton buttonWithType:UIButtonTypeCustom];
    submit.frame=CGRectMake(20, 0, kScreen_Width-40, 42);
    submit.backgroundColor = [UIColor brownColor];
    [submit setTitle:@"提交答案" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submit.layer.masksToBounds = YES;
    submit.layer.cornerRadius = 5;
    submit.titleLabel.font = font14;
    [submit addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:submit];
    
}
-(void)submit{
    [HUD showAlertWithTitle:@"恭喜，奖励5个积分" duration:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
