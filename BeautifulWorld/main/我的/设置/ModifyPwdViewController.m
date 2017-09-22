//
//  ModifyPwdViewController.m
//  SchTimeBaby
//
//  Created by yuanju001 on 16/11/28.
//  Copyright © 2016年 yuanju001. All rights reserved.
//

#import "ModifyPwdViewController.h"
#import "AppDelegate.h"
@interface ModifyPwdViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
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

    AppDelegate *appDelegateUtils;
   }



@end

@implementation ModifyPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatData];
    [self creatUITableView];
    // Do any additional setup after loading the view.
}
-(void)creatData{
    _dataArray=[NSMutableArray arrayWithObjects:@"旧密码",@"新密码",@"确认新密码",nil];
    _detailArr = [NSMutableArray arrayWithObjects:@"请输入旧密码",@"请输入新密码",@"请确认新密码", nil];
    
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
    
    
    CGRect textFieldRect = CGRectMake(0, (cell.bounds.size.height-20)/2, kScreen_Width/4*3-kScreen_Width/14, 20);
    theTextField = [[UITextField alloc] initWithFrame:textFieldRect];
    theTextField.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    theTextField.returnKeyType = UIReturnKeyDone;
    //theTextField.secureTextEntry = YES;
    theTextField.clearButtonMode = YES;
    theTextField.tag = row;
    theTextField.delegate = self;
    
    switch (row) {
        case 0:
            theTextField.placeholder = @"请输入旧密码";
            theTextField.keyboardType= UIKeyboardTypeNumberPad;
            theTextField.tag = 1;
            cell.accessoryView = theTextField;

            break;
        case 1:
            theTextField.placeholder = @"请输入新密码";
            theTextField.tag = 2;
            cell.accessoryView = theTextField;
  
            break;
        case 2:
            theTextField.placeholder = @"请确认新密码";
            theTextField.tag = 3;
            cell.accessoryView = theTextField;
          
            break;
            default:
            break;
    }
    
    
    return cell;
    
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
    footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/2)];
    
    myTable.tableFooterView = footView;
    
    //密码长度
    UILabel * passWordLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, kScreen_Width/2, 20)];
    passWordLab.textColor=[UIColor grayColor];
    passWordLab.text = @"密码长度为6-32位字符";
    passWordLab.font=[UIFont systemFontOfSize:12];
    [footView addSubview:passWordLab];
    
    //注册按钮
    UIButton * registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setFrame:CGRectMake(10, 40, kScreen_Width-20, kScreen_Height/15)];
    //[registerBtn setBackgroundImage:LoadImageByName(@"按钮") forState:UIControlStateNormal];
    registerBtn.backgroundColor = [UIColor brownColor];
    registerBtn.layer.masksToBounds = YES;
    registerBtn.layer.cornerRadius = 10;
    [registerBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(makeSureModify) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:registerBtn];
    
    
    
}

-(void)makeSureModify{
    UITextView * pwdOldView = (id)[self.view viewWithTag:1];
    UITextView * pwdNewView = (id)[self.view viewWithTag:2];
   // UITextView * secret = (id)[self.view viewWithTag:3];
    NSString * userName = @"18240882811";
    NSString * pwdOld = pwdOldView.text;
    NSString * pwdNew = pwdNewView.text;
    
    NSLog(@"旧密码%@,新密码%@",pwdOld,pwdNew);
//    [appDelegateUtils startActivityIndicatorView:15.0];
//    [[HttpClient shareInstance] requestResetWithUsername:userName OriginalPwd:pwdOld NewPassword:pwdNew OperType:@"001" success:^(NSURLSessionDataTask *task, id response) {
//        
//        
//    } failuer:^(NSURLSessionDataTask *task, id response) {
//       // [appDelegateUtils stopActivityIndicatorView];
//        NSLog(@"修改的结果是%@",logDictionary(response));
//    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
