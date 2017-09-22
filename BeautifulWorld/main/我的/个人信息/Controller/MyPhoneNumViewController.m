//
//  MyPhoneNumViewController.m
//  demo
//
//  Created by yuanju001 on 16/11/2.
//  Copyright © 2016年 yuanju001. All rights reserved.
//

#import "MyPhoneNumViewController.h"

@interface MyPhoneNumViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    //输入框
    UITextField *theTextField;
    
}



@end

@implementation MyPhoneNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveRight)];
    
    [self creatUITableView];

}
-(void)saveRight{
    [self.navigationController popViewControllerAnimated:YES];
    

    [UserInfo sharedUserInfo].phoneNum =theTextField.text;
    [[UserInfo sharedUserInfo] saveUserInofFromSanbox];

}
#pragma mark -创建表格视图
-(void)creatUITableView{
    UITableView * myTable =[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:myTable];
    myTable.delegate=self;
    myTable.dataSource=self;
    myTable.backgroundColor=RGBColor(244, 251, 255);
      
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID=@"cellId";
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    CGRect textFieldRect = CGRectMake(0, 0,kScreen_Width, cell.bounds.size.height);
    theTextField = [[UITextField alloc] initWithFrame:textFieldRect];
    theTextField.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    theTextField.returnKeyType = UIReturnKeyDone;
    theTextField.clearButtonMode = YES;
    
    theTextField.delegate = self;
    theTextField.keyboardType = UIKeyboardTypeNumberPad;

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    [cell addSubview:theTextField];
    return  cell;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

@end
