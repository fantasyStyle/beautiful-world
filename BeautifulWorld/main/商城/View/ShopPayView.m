//
//  ShopPayView.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/19.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "ShopPayView.h"

@implementation ShopPayView
-(id)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(kScreen_Width/7, (kScreen_Height-kScreen_Width/7*5)/2, kScreen_Width/7*5, kScreen_Width/7*5);
        backIma = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, self.frame.size.width, self.frame.size.width)];
        backIma.image = LoadImageByName(@"bg_05");
        [self addSubview:backIma];
     }
    
    return self;
}
-(void)initPayViewWithCount:(NSString * )count AndPayType:(NSString *)type AndGoodName:(NSString *)name AndGoodIma:(NSString *)goodIma{
    _headIcon = [[UIImageView alloc]init];
    _headIcon.frame  = CGRectMake(self.frame.size.width /3, 5, self.frame.size.width/3, self.frame.size.width/3);
    _headIcon.contentMode = UIViewContentModeScaleAspectFit;
    NSString * str = [NSString stringWithFormat:@"%@%@",BaseShopUrl,goodIma];
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:LoadImageByName(@"head_05")];
    [self addSubview:_headIcon];
    
    _NameLab = [[UILabel alloc]init];
    _NameLab.frame = CGRectMake(0, _headIcon.y+_headIcon.frame.size.height+5, self.frame.size.width, 25);
    _NameLab.textAlignment = NSTextAlignmentCenter;
    _NameLab.textColor = [UIColor blackColor];
    _NameLab.font = [UIFont boldSystemFontOfSize:20];
    _NameLab.text = name;
    [self addSubview:_NameLab];
    
    
    _payView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width/8, _NameLab.y+35, self.frame.size.width/4*3, 40)];
    //[self addSubview:_payView];
    UIImageView * huangzuan  =[[UIImageView alloc]init];
    huangzuan.frame = CGRectMake(0, 6, 28, 28);
    huangzuan.image = LoadImageByName(type);
    [_payView addSubview:huangzuan];
    
    _payCountLab = [[UILabel alloc]init];
    _payCountLab.frame = CGRectMake(huangzuan.x+30, 10, _payView.frame.size.width/2-30, 20);
    _payCountLab.textColor = [UIColor darkGrayColor];
    _payCountLab.font = font15;
    danprice = count;
    _payCountLab.text = [NSString stringWithFormat:@"x%@",count];
    [_payView addSubview:_payCountLab];
    
    
    _deleteButn = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteButn.frame = CGRectMake(_payView.frame.size.width/2, 10, 20, 20);
    [_deleteButn setImage:LoadImageByName(@"-_03") forState:UIControlStateNormal];
    _deleteButn.enabled = NO;
    [_deleteButn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_payView addSubview:_deleteButn];

    
    _TF = [[UITextField alloc]init];
    _TF.frame = CGRectMake(_deleteButn.x+25, 5, _payView.frame.size.width/2-50, 30);
    self.TF.text = @"1";
    self.TF.delegate = self;
    _TF.textAlignment = NSTextAlignmentCenter;
    _TF.borderStyle = UITextBorderStyleRoundedRect;
    [_payView addSubview:_TF];
    
    
    _addButn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addButn.frame = CGRectMake(_TF.x+_TF.frame.size.width+5, 10, 20, 20);
    [_addButn setImage:LoadImageByName(@"+_03") forState:UIControlStateNormal];
    [_addButn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [_payView addSubview:_addButn];


    
    CGFloat btnW = self.frame.size.width/55*18;
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(kScreen_Width/9, self.frame.size.height-60, btnW, btnW/18*7);
    _cancelBtn.backgroundColor  = RGBColor(50, 155, 219);
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    _cancelBtn.layer.masksToBounds = YES;
    _cancelBtn.layer.cornerRadius = 5;
    [_cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_cancelBtn];
    
    _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _payBtn.frame = CGRectMake(_cancelBtn.x+_cancelBtn.frame.size.width + 20, self.frame.size.height-60, btnW, btnW/18*7);
    _payBtn.backgroundColor  = RGBColor(50, 155, 219);
    [_payBtn setTitle:@"加入背包" forState:UIControlStateNormal];
    _payBtn.layer.masksToBounds = YES;
    _payBtn.layer.cornerRadius = 5;
    [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_payBtn];
    

    
}
#pragma mark - 支付成功页面

-(void)initOKViewWithPayType:(NSString *)type AndGoodName:(NSString *)name AndGoodIma:(NSString *)goodIma AndFee:(NSString *)fee{
    _headIcon = [[UIImageView alloc]initWithFrame:CGRectMake(15,30, self.frame.size.width/5, self.frame.size.width/5)];
    NSString * str = [NSString stringWithFormat:@"%@%@",BaseShopUrl,goodIma];
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:LoadImageByName(@"head_05")];
    _headIcon.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_headIcon];
    
    _NameLab = [[UILabel alloc]init];
    _NameLab.frame = CGRectMake(_headIcon.x+_headIcon.frame.size.width+5, 40, self.frame.size.width/5*3, 40);
    _NameLab.numberOfLines = 2;
    _NameLab.textAlignment = NSTextAlignmentCenter;
    _NameLab.font = [UIFont boldSystemFontOfSize:20];
    _NameLab.text =[NSString stringWithFormat:@"您已成功将%@加入背包",name];
    _NameLab.font = font15;
    _NameLab.numberOfLines = 2;
    [self addSubview:_NameLab];
    
    UIImageView * piaodai = [[UIImageView alloc]init];
    piaodai.frame = CGRectMake(self.frame.size.width/5, _NameLab.y+50, self.frame.size.width/5*3, self.frame.size.height/505*66);
    piaodai.image = LoadImageByName(@"piaodai_03");
    //[self addSubview:piaodai];
    
    UIImageView * huangzuan  =[[UIImageView alloc]init];
    huangzuan.frame = CGRectMake(30, 1, 30, 30);
    huangzuan.image = LoadImageByName(type);
    NSLog(@"支付类型%@",type);
    [piaodai addSubview:huangzuan];
    
    _payCountLab = [[UILabel alloc]init];
    _payCountLab.frame = CGRectMake(huangzuan.x+35, 5, piaodai.frame.size.width/5*2, 25);
    _payCountLab.textColor = [UIColor whiteColor];
        _payCountLab.font = font15;
    _payCountLab.text = [NSString stringWithFormat:@"x%@",fee];
    [piaodai addSubview:_payCountLab];
    
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtn.frame = CGRectMake(15, self.frame.size.height/5*4, 20, 20);
    [_leftBtn setImage:LoadImageByName(@"left_03") forState:UIControlStateNormal];
    [self addSubview:_leftBtn];
    
    UILabel * lab1 = [[UILabel alloc]init];
    lab1.frame = CGRectMake(_leftBtn.x+_leftBtn.frame.size.width+5, _leftBtn.y, self.frame.size.width/2-_leftBtn.frame.size.width-_leftBtn.x, 20);
    lab1.text= @"前往背包";
    [self addSubview:lab1];
    
    UILabel * lab2 = [[UILabel alloc]init];
    lab2.frame = CGRectMake(self.frame.size.width/2, lab1.y, lab1.frame.size.width, 20);
    lab2.text = @"返回饰品页";
    [self addSubview:lab2];
    
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(lab2.x+lab2.frame.size.width+5, lab2.y, 20, 20);
    [_rightBtn setImage:LoadImageByName(@"right_03") forState:UIControlStateNormal];
    [self addSubview:_rightBtn];
    

    
    
    
}
-(void)cancelClick{
    [self removeFromSuperview];
}

-(void)addAction:(UIButton *)sender{
    NSString * changeStr = self.TF.text;
    NSInteger minimumNum = 1;
    NSInteger maxNum = 10;
    NSString * str = [_payCountLab.text substringFromIndex:1];
    
    if ([changeStr integerValue] > 0 || [changeStr integerValue] < maxNum) {
        self.TF.text = [NSString stringWithFormat:@"%ld",[changeStr integerValue]+1];
        _payCountLab.text = [NSString stringWithFormat:@"x%ld", [self.TF.text integerValue]*[danprice integerValue]];
        
        if ([self.TF.text integerValue] == maxNum) {
            self.addButn.enabled = NO;
        }
        if ([self.TF.text integerValue] > minimumNum) {
            self.deleteButn.enabled = YES;
        }
    }
    
}

-(void)deleteAction:(UIButton *)sender{
    NSString * changeStr = self.TF.text;
    NSInteger minimumNum = 1;
    NSInteger maxNum = 10;
     NSString * str = [_payCountLab.text substringFromIndex:1];
    if ([changeStr integerValue] > 0 || [changeStr integerValue] < maxNum) {
        
        self.TF.text = [NSString stringWithFormat:@"%ld",[changeStr integerValue]-1];
        _payCountLab.text = [NSString stringWithFormat:@"x%ld", [self.TF.text integerValue]*[danprice integerValue]];
        
        if ([self.TF.text integerValue] == minimumNum) {
            self.deleteButn.enabled = NO;
        }
        if ([self.TF.text integerValue] < maxNum) {
            self.addButn.enabled = YES;
        }
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"%@",textField.text);
    if ([textField.text integerValue] >= 10) {
        self.addButn.enabled = NO;
    }else{
        self.addButn.enabled = YES;
    }
    if ([textField.text integerValue]<= 1) {
        self.deleteButn.enabled = NO;
    }else{
        self.deleteButn.enabled = YES;
    }if ([textField.text integerValue] > 10) {
        self.TF.text = @"10";
    }
}
//注意此方法只对键盘输入的内容有效
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{  //string就是此时输入的那个字符 textField就是此时正在输入的那个输入框 返回YES就是可以改变输入框的值 NO相反
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (self.TF == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString integerValue] > 10) { //如果输入框内容大于10则弹出警告
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入的数值不能超过10" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }];
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:otherAction];
            //[self presentViewController:alertController animated:YES completion:nil];
            return NO;
        }
        
    }
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
    //    [self.TF resignFirstResponder];
}

@end
