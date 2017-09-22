//
//  IntroduceBrieflyViewController.m
//  demo
//
//  Created by yuanju001 on 16/10/31.
//  Copyright © 2016年 yuanju001. All rights reserved.
//

#import "IntroduceBrieflyViewController.h"
#define MAX_INPUT_LENGTH 20
@interface IntroduceBrieflyViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>{
    //输入框
    UITextView * myTextV;
    
    
}



@end

@implementation IntroduceBrieflyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(saveRight)];
    
    [self creatUITableView];
    // Do any additional setup after loading the view.
}
-(void)saveRight{
    
    [self.navigationController popViewControllerAnimated:YES];
    [UserInfo sharedUserInfo].sign =myTextV.text;
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
    CGRect textViewRect =CGRectMake(0, 0,kScreen_Width, cell.bounds.size.height);
    myTextV = [[UITextView alloc]init];
    myTextV.frame = textViewRect;
    myTextV.returnKeyType =UIReturnKeyDone;
    myTextV.font = [UIFont systemFontOfSize:15];
    myTextV.delegate =self;
    [cell addSubview:myTextV];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    

    return  cell;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreen_Height/12;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@""] && range.length > 0) {
        //删除字符肯定是安全的
        return YES;
    }
    else {
//        if (textView.text.length - range.length + text.length > MAX_INPUT_LENGTH) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"超出最大可输入长度" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [alert show];
//            return NO;
//        }
//        else {
        
           return YES;
//        }
    }
    
}
@end
