//
//  ApprenticeView.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/18.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "ApprenticeView.h"

@implementation ApprenticeView
-(id)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(kScreen_Width/7, (kScreen_Height-NavBar_Height-StatusBar_Height-kScreen_Height/1334*385)/2, kScreen_Width/7*5, kScreen_Height/1334*385);
        [self initView];
        
//        _teacherNameLab = [[UILabel alloc]init];
//        _teacherNameLab.frame = CGRectMake(0, self.frame.size.height/5*2+15, self.frame.size.width, 25);
//        _teacherNameLab.font = [UIFont systemFontOfSize:20];
//        _teacherNameLab.font = [UIFont boldSystemFontOfSize:20];
//        _teacherNameLab.textAlignment = NSTextAlignmentCenter;
//        _teacherNameLab.textColor = [UIColor blackColor];
//        _teacherNameLab.text = @"范曾老师";
//        [self addSubview:_teacherNameLab];

       

        
    }
    
    return self;
}
-(void)initView{
    backIma = [[UIImageView alloc]initWithFrame:CGRectMake(0,kScreen_Height/1334*68, self.frame.size.width, kScreen_Height/1334*315)];
    backIma.image = LoadImageByName(@"bg_04");
    [self addSubview:backIma];
    
    _headIcon = [[UIImageView alloc]init];
    _headIcon.frame  = CGRectMake((self.frame.size.width - self.frame.size.width/505*194)/2, 0, self.frame.size.width/505*194, self.frame.size.width/505*194);
    _headIcon.image = LoadImageByName(@"fan_03");
    [self addSubview:_headIcon];
    
        UIImageView * piaodai = [[UIImageView alloc]init];
        piaodai.frame = CGRectMake(self.frame.size.width/5, self.frame.size.height/385*285, self.frame.size.width/5*3, self.frame.size.height/385*66);
        piaodai.image = LoadImageByName(@"baishichenggong_03");
        [self addSubview:piaodai];
        


}
//-(void)initPayView{
//
//    
//    _payView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width/8, _teacherNameLab.y+30, self.frame.size.width/4*3, 25)];
//    [self addSubview:_payView];
//    
//    UILabel * lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _payView.frame.size.width/8*3+5, 25)];
//    lab1.text = @"拜师需支付";
//    lab1.font = font15;
//    lab1.textColor = [UIColor darkGrayColor];
//    [_payView addSubview:lab1];
//    
//    UIImageView * huangzuan  =[[UIImageView alloc]init];
//    huangzuan.frame = CGRectMake(lab1.frame.size.width+5, 1, 22, 22);
//    huangzuan.image = LoadImageByName(@"huangzuan_03");
//    [_payView addSubview:huangzuan];
//    
//    _payCountLab = [[UILabel alloc]init];
//    _payCountLab.frame = CGRectMake(huangzuan.x+23, 0, _payView.frame.size.width-huangzuan.x-22, 25);
//    _payCountLab.textColor = [UIColor darkGrayColor];
//    _payCountLab.font = font15;
//    _payCountLab.text = [NSString stringWithFormat:@"X%@哦～",@"2000"];
//    [_payView addSubview:_payCountLab];
//    
//    CGFloat btnW = self.frame.size.width/55*18;
//    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _cancelBtn.frame = CGRectMake(kScreen_Width/9, self.frame.size.height-60, btnW, btnW/18*7);
//    _cancelBtn.backgroundColor  = RGBColor(50, 155, 219);
//    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
//    _cancelBtn.layer.masksToBounds = YES;
//    _cancelBtn.layer.cornerRadius = 5;
//    [_cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
//    [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self addSubview:_cancelBtn];
//    
//    _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _payBtn.frame = CGRectMake(_cancelBtn.x+_cancelBtn.frame.size.width + 20, self.frame.size.height-60, btnW, btnW/18*7);
//    _payBtn.backgroundColor  = RGBColor(50, 155, 219);
//    [_payBtn setTitle:@"支付" forState:UIControlStateNormal];
//    _payBtn.layer.masksToBounds = YES;
//    _payBtn.layer.cornerRadius = 5;
//    [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self addSubview:_payBtn];
//   
//    
//}
//-(void)initOKView{
//    UIImageView * icon = [[UIImageView alloc]init];
//    icon.frame  = CGRectMake(10, self.frame.size.height/5*2+15, self.frame.size.width/5, self.frame.size.width/5);
//    icon.image = LoadImageByName(@"NPC_04");
//    [self addSubview:icon];
//    
//    UILabel * lab = [[UILabel alloc]init];
//    lab.frame = CGRectMake(icon.x+icon.frame.size.width+5, _teacherNameLab.y+30, self.frame.size.width/5*3, 25);
//    lab.font = [UIFont boldSystemFontOfSize:20];
//    lab.textColor = [UIColor redColor];
//    lab.text = @"恭喜您拜师成功";
//    [self addSubview:lab];
//    
//    UILabel * okfee = [[UILabel alloc]init];
//    okfee.frame = CGRectMake(0, self.frame.size.height/50*36, self.frame.size.width, 20);
//    okfee.textColor = [UIColor darkGrayColor];
//    okfee.text = @"您已成功支付";
//    okfee.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:okfee];
//    
//    UIImageView * piaodai = [[UIImageView alloc]init];
//    piaodai.frame = CGRectMake(self.frame.size.width/5, okfee.y+28, self.frame.size.width/5*3, self.frame.size.height/505*66);
//    piaodai.image = LoadImageByName(@"piaodai_03");
//    [self addSubview:piaodai];
//    
//    UIImageView * huangzuan  =[[UIImageView alloc]init];
//    huangzuan.frame = CGRectMake(30, 1, 30, 30);
//    huangzuan.image = LoadImageByName(@"huangzuan_03");
//    [piaodai addSubview:huangzuan];
//    
//    _payCountLab = [[UILabel alloc]init];
//    _payCountLab.frame = CGRectMake(huangzuan.x+35, 5, piaodai.frame.size.width/5*2, 25);
//    _payCountLab.textColor = [UIColor whiteColor];
////    _payCountLab.font = font15;
//    _payCountLab.text = [NSString stringWithFormat:@"x%@",@"2000"];
//    [piaodai addSubview:_payCountLab];
//
//}
//-(void)cancelClick{
//    [self removeFromSuperview];
//}
//
@end
