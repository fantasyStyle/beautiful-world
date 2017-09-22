//
//  BecomeMemberController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/20.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "BecomeMemberController.h"
#import "PayStyleViewController.h"
#import "SelectMemberCell.h"
#import "ResourceBuyController.h"//购买资源
@interface BecomeMemberController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,SelectMemberDelegate>{
    //文字数组
    NSMutableArray *_dataArray;
    //详情数组
    NSMutableArray * _detailArr;
    //脚视图
    UIView * footView;
    //表视图
    UITableView * myTable;
    //输入框
    UITextField *theTextField;
    UILabel * footLab;
    SelectMemberCell * memberCell;
    UILabel * payCount;
    
    NSString * applyName;
  
}



@end

@implementation BecomeMemberController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[UserInfo sharedUserInfo].vipType = @"1";
    [self creatData];
    [self creatUITableView];
    // Do any additional setup after loading the view.
}
-(void)creatData{
    _dataArray=[NSMutableArray arrayWithObjects:@"开通服务",@"开通时长",@"应付金额",nil];
    
}
#pragma mark -创建表格视图
-(void)creatUITableView{
    myTable =[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:myTable];
    myTable.delegate=self;
    myTable.dataSource=self;
    myTable.backgroundColor=RGBColor(244, 251, 255);
    
    [self addFootViewCust];
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    
    static NSString  *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [_dataArray objectAtIndex:row];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    
    NSString * memberID = @"selectMemberCell";
     memberCell = [tableView dequeueReusableCellWithIdentifier:memberID];
    if (!memberCell) {
        memberCell = [[SelectMemberCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:memberID];
    }
    
    CGRect textFieldRect = CGRectMake(0, 0, kScreen_Width/4*3-kScreen_Width/14, cell.bounds.size.height);
    theTextField = [[UITextField alloc] initWithFrame:textFieldRect];
    theTextField.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    theTextField.returnKeyType = UIReturnKeyDone;
    //theTextField.secureTextEntry = YES;
    theTextField.clearButtonMode = YES;
    theTextField.tag = row;
    theTextField.delegate = self;
    
    switch (row) {
        case 0:{
            memberCell.selectionStyle = UITableViewCellSelectionStyleNone;
            memberCell.memberDelegate =self;
            return memberCell;

        }
            break;
        case 1:
            theTextField.placeholder = @"1个月";
            theTextField.tag = 2;
            cell.accessoryView = theTextField;
            
            break;
        case 2:{
            payCount = [[UILabel alloc]init];
            payCount.frame =  CGRectMake(100, (cell.frame.size.height-20)/2, 100, 20);
            payCount.font = font13;
            payCount.text = @"100 钻石";
            payCount.textColor = [UIColor redColor];
            [cell addSubview:payCount];
            break;
        }
            
        default:
            break;
    }
    
    
    return cell;
    
}
-(void)onSelectVIPMember{
    footLab.text = @"普通会员：每月100钻石。在购买期限内免费使用部分头像、边框和皮肤。";
    payCount.text = @"100 钻石";
    [UserInfo sharedUserInfo].vipType =@"1";
    [[UserInfo sharedUserInfo]saveUserInofFromSanbox];
    NSLog(@"点击了VIP服务");
    
  // [myTable reloadData];

}
-(void)onSelectSuperMember{
    payCount.text = @"150 钻石";
    footLab.text = @"超级会员：每月150钻石。在购买期限内免费使用全部头像、边框和皮肤。以及免费观看平台内部分视频，和参加品台活动优先提醒功能。";
    NSLog(@"点击了超级服务");
     [UserInfo sharedUserInfo].vipType =@"2";
    [[UserInfo sharedUserInfo]saveUserInofFromSanbox];
      //[myTable reloadData];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0;
}
#pragma mark - 添加脚视图
-(void)addFootViewCust{
    footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/5*3)];
    
    myTable.tableFooterView = footView;
    
    footLab = [[UILabel alloc]init];
    footLab.frame = CGRectMake(0, 30, kScreen_Width, 0);
    [footLab setNumberOfLines:0];
    footLab.textColor = [UIColor grayColor];
    footLab.font = [UIFont systemFontOfSize:15];

    footLab.text = @"普通会员：每月100钻石。在购买期限内免费使用部分头像、边框和皮肤。";
    
    footLab.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [footLab sizeThatFits:CGSizeMake(footLab.frame.size.width, MAXFLOAT)];
    footLab.frame = CGRectMake(10, 30, kScreen_Width-20, size.height);
    [footView addSubview:footLab];


    
    
    //注册按钮
    UIButton * registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setFrame:CGRectMake(20, footLab.y+size.height+20, kScreen_Width-40, kScreen_Height/15)];
    //[registerBtn setBackgroundImage:LoadImageByName(@"按钮") forState:UIControlStateNormal];
    registerBtn.backgroundColor = [UIColor brownColor];
    registerBtn.layer.masksToBounds = YES;
    registerBtn.layer.cornerRadius = 10;
    [registerBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(makeSureModify) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:registerBtn];
    
    
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
        NSLog(@"输入的内容%@",toBeString);
    int month =[toBeString intValue];
    NSLog(@"%d",month);
    if ([[UserInfo sharedUserInfo].vipType  isEqualToString:@"1"]) {
        int price =100*month;
        payCount.text = [NSString stringWithFormat:@"%d",price];
    }
    if ([[UserInfo sharedUserInfo].vipType  isEqualToString:@"2"])
    {
        int price =150*month;
        payCount.text = [NSString stringWithFormat:@"%d",price];
        
    }

    return YES;
}
//-(void)textFieldDidEndEditing:(UITextField *)textField{
////    payCount.text = @"15 元";
//    UITextView * pwdNewView = (id)[self.view viewWithTag:2];
//    NSString * pwdNew = pwdNewView.text;
//    int month =[pwdNew intValue];
//    NSLog(@"%d",month);
//    if ([[UserInfo sharedUserInfo].vipType  isEqualToString:@"1"]) {
//         int price =10*month;
//         payCount.text = [NSString stringWithFormat:@"%d",price];
//    }else{
//        int price =15*month;
//         payCount.text = [NSString stringWithFormat:@"%d",price];
//
//    }
//    
//    
//}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
       return YES;
}
-(void)makeSureModify{
       UITextView * pwdNewView = (id)[self.view viewWithTag:2];
        NSString * pwdNew = pwdNewView.text;
    NSLog(@"%@月，%@钻石",pwdNew,payCount.text);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:pwdNew forKey:@"vip_time"];
    [params setValue:payCount.text forKey:@"allprice"];
   
    [params setValue:[UserInfo sharedUserInfo].user_id forKey:@"user_id"];
    [params setValue:[UserInfo sharedUserInfo].vipType forKey:@"type_vip"];
    [params setValue:@"1" forKey:@"state"];
    if ([[UserInfo sharedUserInfo].vipType isEqualToString:@"1"]) {
        NSString * str = [NSString stringWithFormat:@"购买普通会员 %@个月",pwdNew];
         [params setValue:str forKey:@"name"];
    }
    if ([[UserInfo sharedUserInfo].vipType isEqualToString:@"2"]) {
        NSString * str = [NSString stringWithFormat:@"购买vip会员 %@个月",pwdNew];
        [params setValue:str forKey:@"name"];
    }

    [[HttpClient shareInstance] requestApiWithurl:@"applyMember"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        
        
        [FTShowMessageView dismiss];
        
        NSMutableDictionary * dic = [response objectForKey:@"result"];
        NSLog(@"申请会员%@",dic);
        NSString * str = [NSString stringWithFormat:@"%@",dic[@"success"]];
        if ([str isEqualToString:@"1"]) {
            [HUD showAlertWithTitle:@"申请成功！"];
           // [self.navigationController popViewControllerAnimated:YES];
        }else{
            [HUD showAlertWithTitle:@"账户余额不足，请充值！"];
            ResourceBuyController * buy = [[ResourceBuyController alloc]init];
            [self.navigationController pushViewController:buy animated:YES];

        }
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        [FTShowMessageView dismiss];
        
        
    }];
    
    
    

    
    
    PayStyleViewController * pay  = [[PayStyleViewController alloc]init];
   // [self.navigationController pushViewController:pay animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
