//
//  PersonInfoViewController.m
//  demo
//
//  Created by yuanju001 on 16/9/21.
//  Copyright © 2016年 yuanju001. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "PersonInfoCell.h"
#import "LoginViewController.h"
#import "DetailPersonViewController.h"
#import "zySheetPickerView.h"
#import "BabyChooseViewController.h"
#import "IntroduceBrieflyViewController.h"
#import "IconForUserController.h"
#import "MyPhoneNumViewController.h"
#import "MineViewController.h"
#import "BuyRecordController.h"

@interface PersonInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,SavePerInfoDelegate>
{
    
    
    UITableView * myTable;
    //图片数组
    NSMutableArray *_imgArray;
    //文字数组
    NSMutableArray *_dataArray;
    //详情数组
    NSMutableArray * _detailArr;
    //退出按钮
    UIButton * cancelLogin;
    
    
    
}



@end

@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人信息";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(makeSureRight)];
     [self creatData];
    [self creatUITableView];
    
    NSLog(@"用户的昵称是%@",[UserInfo sharedUserInfo].nickName);
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [myTable reloadData];
//    [myTable removeFromSuperview];
//    [self creatData];
//    [self creatUITableView];
    
}

//导航右边确定事件

-(void)makeSureRight{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    [params setValue:[UserInfo sharedUserInfo].sex forKey:@"sex"];
    [params setValue:[UserInfo sharedUserInfo].nickName forKey:@"name"];
    [params setValue:[UserInfo sharedUserInfo].sign forKey:@"signature"];
    [params setValue:[UserInfo sharedUserInfo].constellation forKey:@"constellation"];
    [params setValue:[UserInfo sharedUserInfo].iconUser forKey:@"head"];
    [params setValue:[UserInfo sharedUserInfo].user_id forKey:@"user_id"];
    [params setValue:@"true" forKey:@"save"];

    NSLog(@"用户的ID%@",[UserInfo sharedUserInfo].user_id);
    [[HttpClient shareInstance] requestApiWithurl:@"personInfo"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        [FTShowMessageView dismiss];
        
        NSMutableDictionary * dic = [response objectForKey:@"result"];
        NSLog(@"个人信息的的%@",dic);
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"个人信息失败%@",response);
        [FTShowMessageView dismiss];
        
        
    }];

    [self.navigationController popViewControllerAnimated:YES];
    
if ([self.saveInfoDelegate respondsToSelector:@selector(onClickSaveWithNickName:andSign:andHeadIcon:)]) {
   // [self.saveInfoDelegate onClickSaveWithNickName:[UserInfo sharedUserInfo].nickName andSign:[UserInfo sharedUserInfo].sign andHeadIcon:[UserInfo sharedUserInfo].imageData];
    }

}
-(void)creatData{
    _imgArray = [[NSMutableArray alloc]init];

    _dataArray=[NSMutableArray arrayWithObjects:@"名字",@"性别",@"个性签名",@"星座", nil];
    _detailArr = [NSMutableArray arrayWithObjects:@"头像",@"玥",@"女",@"就要不一样",@"水瓶座", nil];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
       [params setValue:[UserInfo sharedUserInfo].user_id forKey:@"user_id"];
    NSLog(@"用户的ID%@",[UserInfo sharedUserInfo].user_id);
    [[HttpClient shareInstance] requestApiWithurl:@"personInfo"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        [FTShowMessageView dismiss];
  
        NSMutableDictionary * dic = [response objectForKey:@"result"];
        NSLog(@"个人信息的的%@",dic);
//        for (NSMutableDictionary * subDic in dic) {
            [UserInfo sharedUserInfo].sex = dic[@"sex"];
            [UserInfo sharedUserInfo].nickName = dic[@"name"];
            [UserInfo sharedUserInfo].sign = dic[@"signature"];
            [UserInfo sharedUserInfo].constellation = dic[@"constellation"];
//            [UserInfo sharedUserInfo].iconUser = dic[@"constellation"];
            [[UserInfo sharedUserInfo]saveUserInofFromSanbox];
            [myTable reloadData];
        //}
    
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"名门师派失败%@",response);
        [FTShowMessageView dismiss];

        
    }];

    
}
#pragma mark -创建表格视图
-(void)creatUITableView{
     myTable =[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:myTable];
    myTable.delegate=self;
    myTable.dataSource=self;
    //
//    UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/4)];
//       myTable.tableFooterView = footView;
    
    
//    //登录
//    cancelLogin = [[UIButton alloc]initWithFrame:CGRectMake(kScreen_Width/24, footView.frame.size.height/3, kScreen_Width/12*11, footView.frame.size.height/3)];
//    
//    cancelLogin.backgroundColor=RGBAColor(0, 228, 255, 1);
//    cancelLogin.layer.cornerRadius = 5;
//    cancelLogin.layer.masksToBounds = YES;
//    
//    [cancelLogin setTitle:@"退出帐号" forState:UIControlStateNormal];
//    [cancelLogin addTarget:self action:@selector(outLoginClick) forControlEvents:UIControlEventTouchUpInside];
//    cancelLogin.tag=100;
//    
//    [footView addSubview:cancelLogin];

    
}
//-(void)outLoginClick{
//    
//    LoginViewController * login =[[LoginViewController alloc]init];
//    [self.navigationController pushViewController:login animated:YES];
//    
//
//}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
       return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID=@"cellId";
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        
    }
    
    NSString * cellI=@"cellI";
    PersonInfoCell * celCust =[tableView dequeueReusableCellWithIdentifier:cellI];
    if (celCust == nil) {
        celCust = [[PersonInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellI];
        
    }
    switch (indexPath.row) {
        case 0:
        {
            celCust.textLabel.text=@"头像";
            celCust.textLabel.textColor = [UIColor darkGrayColor];
            if ([UserInfo sharedUserInfo].iconUser) {
                NSString * str = [NSString stringWithFormat:@"%@%@",BaseShopUrl,[UserInfo sharedUserInfo].iconUser];
                [celCust.iconPerson sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:LoadImageByName(@"head_06")];

            }
            else{
                 celCust.iconPerson.image=LoadImageByName(@"head_06");
            }
           
            celCust.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            celCust.selectionStyle=UITableViewCellSelectionStyleNone;
            return celCust;

        }
            break;
        case 1:
        {
            cell.textLabel.text=@"名字";
            cell.detailTextLabel.text = [UserInfo sharedUserInfo].nickName;
            
        }
            break;

        case 2:
        {
            cell.textLabel.text=@"性别";
            cell.detailTextLabel.text = [UserInfo sharedUserInfo].sex;

        }
            break;

        case 3:
        {
            cell.textLabel.text=@"个性签名";
            cell.detailTextLabel.text = [UserInfo sharedUserInfo].sign;        }
            break;

        case 4:
        {
            cell.textLabel.text=@"星座";
            cell.detailTextLabel.text = [UserInfo sharedUserInfo].constellation;

        }
            break;

       
            
        default:
            break;
    }

    
        cell.textLabel.textColor=[UIColor darkGrayColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.textColor=[UIColor grayColor];
        if (iPhone5) {
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        }
        return  cell;
        

    
    
   }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height;

    if (indexPath.row == 0) {
        height =  kScreen_Height/10;

    }else{
        height =  kScreen_Height/12;

    }
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        {
            [self iconBtnClick];
        }
            break;
        case 1:
        {
            DetailPersonViewController * perInfo = [[DetailPersonViewController alloc]init];
            
            [self.navigationController pushViewController:perInfo animated:YES];

        }
            break;
        case 2:
        {
            NSArray * strArr  = @[@"男",@"女"];
                            zySheetPickerView *pickerView = [zySheetPickerView ZYSheetStringPickerWithTitle:strArr andHeadTitle:@"性别选择" Andcall:^(zySheetPickerView *pickerView, NSString *choiceString) {
            
                                [UserInfo sharedUserInfo].sex = choiceString;
                                [[UserInfo sharedUserInfo] saveUserInofFromSanbox];
                                [myTable reloadData];
                                [pickerView dismissPicker];
                            }];
                            [pickerView show];

        }
            break;
        case 3:
        {
            IntroduceBrieflyViewController * personal = [[IntroduceBrieflyViewController alloc]init];
            personal.title = @"个性签名";
            
            [self.navigationController pushViewController:personal animated:YES];

        }
            break;
        case 4:
        {
            NSArray * strArr  = @[@"白羊座",@"金牛座",@"双子座",@"巨蟹座",@"狮子座",@"处女座",@"天秤座",@"天蝎座",@"射手座",@"摩羯座",@"水瓶座",@"双鱼座",];
            zySheetPickerView *pickerView = [zySheetPickerView ZYSheetStringPickerWithTitle:strArr andHeadTitle:@"星座选择" Andcall:^(zySheetPickerView *pickerView, NSString *choiceString) {
                
                [UserInfo sharedUserInfo].constellation = choiceString;
                [[UserInfo sharedUserInfo] saveUserInofFromSanbox];
                [myTable reloadData];
                [pickerView dismissPicker];
            }];
            [pickerView show];
            

        }
            break;

            
        default:
            break;
    }

}
-(void)iconBtnClick
{
//    IconForUserController * selectIcon = [[IconForUserController alloc]init];
//    selectIcon.saveInfoDelegate = self;
//    [self.navigationController pushViewController:selectIcon animated:YES];
    BuyRecordController * head = [[BuyRecordController alloc]init];
    head.shop_URL = @"usergoods";
    head.type_ID = @"10";
    head.user_id = [UserInfo sharedUserInfo].user_id;
    head.clickType = @"0";
    [self.navigationController pushViewController:head animated:YES];
    
}

@end
