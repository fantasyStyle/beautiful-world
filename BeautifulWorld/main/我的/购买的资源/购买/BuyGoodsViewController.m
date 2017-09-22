//
//  BuyGoodsViewController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/5/5.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "BuyGoodsViewController.h"

@interface BuyGoodsViewController ()<UITextFieldDelegate>

@end

@implementation BuyGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatView];
    // Do any additional setup after loading the view.
}
-(void)creatView{
    
    _payStyle = [[UIImageView alloc]init];
    _payStyle.frame = CGRectMake(20, 15, 30, 30);
    _payStyle.image = LoadImageByName(@"zuan_04");
    [self.view addSubview:_payStyle];
    
    _payCountLab = [[UILabel alloc]init];
    _payCountLab.text = @"x10";
    _payCountLab.frame = CGRectMake(_payStyle.x+35, 20, 60, 15);
    _payCountLab.textColor= [UIColor darkGrayColor];
    [self.view addSubview:_payCountLab];
    
    
    
    
    
    _deleteButn = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteButn.frame = CGRectMake(kScreen_Width/3*2, 10, 35, 35);
    [_deleteButn setImage:[UIImage imageNamed:@"productDetail_delete_enabled.png"] forState:UIControlStateNormal];
    [_deleteButn setImage:[UIImage imageNamed:@"productDetail_delete_disabled.png"] forState:UIControlStateDisabled];
    [_deleteButn setImage:[UIImage imageNamed:@"productDetail_delete_clicked.png"] forState:UIControlStateHighlighted];
    _deleteButn.enabled = NO;
    [_deleteButn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_deleteButn];
    
    
    _TF = [[UITextField alloc]init];
    _TF.frame = CGRectMake(_deleteButn.x+35, 15, 45, 25);
    self.TF.text = @"1";
    self.TF.delegate = self;
    _TF.textAlignment = NSTextAlignmentCenter;
    _TF.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_TF];
    
    
    _addButn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addButn.frame = CGRectMake(_TF.x+_TF.frame.size.width, 10, 35, 35);
    [_addButn setImage:[UIImage imageNamed:@"productDetail_add_enabled.png"] forState:UIControlStateNormal];
    [_addButn setImage:[UIImage imageNamed:@"productDetail_add_disabled.png"] forState:UIControlStateDisabled];
    [_addButn setImage:[UIImage imageNamed:@"productDetail_add_clicked.png"] forState:UIControlStateHighlighted];
    [_addButn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addButn];
    
    UIView * line = [[UIView alloc]init];
    line.frame = CGRectMake(0, 60, kScreen_Width, 0.5);
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.5;
    [self.view addSubview:line];
    
    UILabel * shouldPay = [[UILabel alloc]init];
    shouldPay.frame = CGRectMake(kScreen_Width/5*3, line.y+10, 90, 20);
    shouldPay.font = [UIFont systemFontOfSize:17];
    shouldPay.text = @"应付金额：";
    [self.view addSubview:shouldPay];
    
    _payCount = [[UILabel alloc]init];
    _payCount.frame = CGRectMake(shouldPay.x+90, shouldPay.y, 60, 20);
    _payCount.text = @"¥1.00";
    _payCount.font = font15;
    _payCount.textColor = RGBColor(249, 79, 7);
    [self.view addSubview:_payCount];
    
    UILabel * weChat = [[UILabel alloc]init];
    weChat.frame = CGRectMake(kScreen_Width-100, _payCount.y+30, 100, 20);
    weChat.text = @"微信支付";
   // [self.view addSubview:weChat];
    
    UIButton * makePay = [UIButton buttonWithType:UIButtonTypeCustom];
    makePay.frame  = CGRectMake(kScreen_Width-120, weChat.y+30, 100, 40);
    makePay.layer.masksToBounds = YES;
    makePay.layer.cornerRadius =5;
    makePay.backgroundColor = RGBColor(249, 79, 7);
    [makePay setTitle:@"确认支付" forState:UIControlStateNormal];
    [makePay addTarget:self action:@selector(onWXPay) forControlEvents:UIControlEventTouchUpInside];
    [makePay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:makePay];
    

}
#pragma mark 微信支付方法
-(void)onWXPay{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:@([self.TF.text integerValue]*100)  forKey:@"price"];
    [params setValue:@([self.TF.text integerValue]) forKey:@"number"];
    NSLog(@"支付的请求%ld%ld",[self.TF.text integerValue]*10,[self.TF.text integerValue]);

//    //需要创建这个支付对象
//    PayReq *req   = [[PayReq alloc] init];
//    
//    [[HttpClient shareInstance] requestApiWithurl:@"wx_order"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
//        
//        id  dic = [response objectForKey:@"result"];
//        NSLog(@"发送支付的%@",response);
//        
//        //由用户微信号和AppID组成的唯一标识，用于校验微信用户
////        req.openID = WX_APPID;
//        
//        // 商家id，在注册的时候给的
//        req.partnerId = response[@"partnerId"];
//        
//        // 预支付订单这个是后台跟微信服务器交互后，微信服务器传给你们服务器的，你们服务器再传给你
//        req.prepayId  = response[@"prepayId"];
//        
//        // 根据财付通文档填写的数据和签名
//        //这个比较特殊，是固定的，只能是即req.package = Sign=WXPay
//        req.package   = @"Sign=WXPay";
//        
//        // 随机编码，为了防止重复的，在后台生成
//        req.nonceStr  = response[@"nonceStr"];
//        
//        // 这个是时间戳，也是在后台生成的，为了验证支付的
//        NSString * stamp = response[@"timeStamp"];
//        req.timeStamp = stamp.intValue;
//        
//        // 这个签名也是后台做的
//        req.sign = response[@"sign"];
//        
//        //发送请求到微信，等待微信返回onResp
//        [WXApi sendReq:req];
//
//        if (dic == [NSNull null]) {
//            
//        }
//    } failuer:^(NSURLSessionDataTask *task, id response) {
//        NSLog(@"失败%@",response);
//        
//        
//    }];
//    
//
    
    
   
    }
-(void)wxPay{
    
}
-(void)addAction:(UIButton *)sender{
    NSString * changeStr = self.TF.text;
    NSInteger minimumNum = 1;
    NSInteger maxNum = [self.maxCount integerValue];
    if ([changeStr integerValue] > 0 || [changeStr integerValue] < maxNum) {
        self.TF.text = [NSString stringWithFormat:@"%ld",[changeStr integerValue]+1];
        self.payCount.text =[NSString stringWithFormat:@"¥%ld:00", [self.TF.text integerValue]];
        _payCountLab.text = [NSString stringWithFormat:@"x%ld", [self.TF.text integerValue]*10];
        
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
    NSInteger maxNum = [self.maxCount integerValue];
    if ([changeStr integerValue] > 0 || [changeStr integerValue] < maxNum) {
        
        self.TF.text = [NSString stringWithFormat:@"%ld",[changeStr integerValue]-1];
         self.payCount.text =[NSString stringWithFormat:@"¥%ld:00", [self.TF.text integerValue]];
         _payCountLab.text = [NSString stringWithFormat:@"x%ld", [self.TF.text integerValue]*10];
        
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
    self.payCount.text =[NSString stringWithFormat:@"¥%ld:00", [textField.text integerValue]];
     _payCountLab.text = [NSString stringWithFormat:@"x%ld", [textField.text integerValue]*10];
    
    if ([textField.text integerValue] >= [self.maxCount integerValue]) {
        self.addButn.enabled = NO;
    }else{
        self.addButn.enabled = YES;
    }
    if ([textField.text integerValue]<= 1) {
        self.deleteButn.enabled = NO;
    }else{
        self.deleteButn.enabled = YES;
    }if ([textField.text integerValue] > [self.maxCount integerValue]) {
        self.TF.text = self.maxCount;
    }
}
//注意此方法只对键盘输入的内容有效
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{  //string就是此时输入的那个字符 textField就是此时正在输入的那个输入框 返回YES就是可以改变输入框的值 NO相反
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    self.payCount.text =[NSString stringWithFormat:@"¥%ld:00", [toBeString integerValue]];
     _payCountLab.text = [NSString stringWithFormat:@"x%ld", [toBeString integerValue]*10];
    if (self.TF == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString integerValue] > [self.maxCount integerValue]) { //如果输入框内容大于10则弹出警告
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入的数值不能超过10000" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }];
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:otherAction];
            [self presentViewController:alertController animated:YES completion:nil];
            return NO;
        }
        
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    //    [self.TF resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
