//
//  ConvertGoldCoinViewController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/5/12.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "ConvertGoldCoinViewController.h"

@interface ConvertGoldCoinViewController ()<UITextFieldDelegate>
@property (strong,nonatomic)UITextField * TF;
@property(nonatomic,strong)UIButton * addButn;
@property(nonatomic,strong)UIButton * deleteButn;
@property (nonatomic,strong)UIImageView  * payStyle;
@property (nonatomic,strong)UILabel  * payCountLab;
@property (nonatomic,strong)UILabel  * payCount;
@end

@implementation ConvertGoldCoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatView];
    // Do any additional setup after loading the view.
}
-(void)creatView{
    
    _payStyle = [[UIImageView alloc]init];
    _payStyle.frame = CGRectMake(20, 15, 30, 30);
    _payStyle.image = LoadImageByName(@"jinbi_05");
    [self.view addSubview:_payStyle];
    
    _payCountLab = [[UILabel alloc]init];
    _payCountLab.text = @"x10";
    _payCountLab.frame = CGRectMake(_payStyle.x+35, 20, 40, 15);
    _payCountLab.textColor= [UIColor darkGrayColor];
    [self.view addSubview:_payCountLab];
    
    UIImageView * convert = [[UIImageView alloc]init];
    convert.frame = CGRectMake(_payCountLab.x+80, 20, 20, 20);
    convert.image = LoadImageByName(@"duihuan_03");
    [self.view addSubview:convert];
    
    UIImageView * zuan = [[UIImageView alloc]init];
    zuan.frame = CGRectMake(convert.x+50, 15, 30, 30);
    zuan.image = LoadImageByName(@"zuan_04");
    [self.view addSubview:zuan];
    
    
    
    
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
    
    
    UIButton * makePay = [UIButton buttonWithType:UIButtonTypeCustom];
    makePay.frame  = CGRectMake(kScreen_Width-120, line.y+30, 100, 40);
    makePay.layer.masksToBounds = YES;
    makePay.layer.cornerRadius =5;
    makePay.backgroundColor = RGBColor(249, 79, 7);
    [makePay setTitle:@"确认兑换" forState:UIControlStateNormal];
    [makePay addTarget:self action:@selector(onConvert) forControlEvents:UIControlEventTouchUpInside];
    [makePay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:makePay];
    
    
}
-(void)onConvert{
    [FTShowMessageView showStatusWithMessage:@"Loading..."];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.TF.text forKey:@"jewel"];
    NSString * str = [_payCountLab.text substringFromIndex:1];
    [params setValue:str  forKey:@"gold"];
    NSLog(@"兑换的金币数量%@",str);
    
    //顶部
    [[HttpClient shareInstance] requestApiWithurl:@"convert"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        id  dic = [response objectForKey:@"result"];
        [FTShowMessageView dismiss];
        NSLog(@"兑换结果%@",dic);
        NSString * str = [NSString stringWithFormat:@"%@",dic[@"success"]];
        if ([str isEqualToString:@"1"]) {
            [HUD showAlertWithTitle:@"兑换成功"];
            
        }else{
            [HUD showAlertWithTitle:@"兑换失败"];

        }


   
    } failuer:^(NSURLSessionDataTask *task, id response) {
        [FTShowMessageView dismiss];
        
    }];
    

}
-(void)addAction:(UIButton *)sender{
    NSString * changeStr = self.TF.text;
    NSInteger minimumNum = 1;
    NSInteger maxNum = [self.jewelCount integerValue];
    if ([changeStr integerValue] > 0 || [changeStr integerValue] < maxNum) {
        self.TF.text = [NSString stringWithFormat:@"%ld",[changeStr integerValue]+1];
        self.payCount.text =[NSString stringWithFormat:@"¥%ld:00", [self.TF.text integerValue]*10];
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
    NSInteger maxNum = [self.jewelCount integerValue];
    if ([changeStr integerValue] > 0 || [changeStr integerValue] < maxNum) {
        
        self.TF.text = [NSString stringWithFormat:@"%ld",[changeStr integerValue]-1];

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
  
    _payCountLab.text = [NSString stringWithFormat:@"x%ld", [textField.text integerValue]*10];

    if ([textField.text integerValue] >= [self.jewelCount integerValue]) {
        self.addButn.enabled = NO;
    }else{
        self.addButn.enabled = YES;
    }
    if ([textField.text integerValue]<= 1) {
        self.deleteButn.enabled = NO;
    }else{
        self.deleteButn.enabled = YES;
    }if ([textField.text integerValue] > [self.jewelCount integerValue]) {
        self.TF.text = self.jewelCount;
    }
}
//注意此方法只对键盘输入的内容有效
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{  //string就是此时输入的那个字符 textField就是此时正在输入的那个输入框 返回YES就是可以改变输入框的值 NO相反
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    _payCountLab.text = [NSString stringWithFormat:@"x%ld", [toBeString integerValue]*10];

    if (self.TF == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString integerValue] > [self.jewelCount integerValue]) { //如果输入框内容大于10则弹出警告
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入的数值不能超过当前账户钻石数量" preferredStyle:UIAlertControllerStyleAlert];
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
