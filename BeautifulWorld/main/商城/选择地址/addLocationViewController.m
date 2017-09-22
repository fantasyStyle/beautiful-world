//
//  addLocationViewController.m
//  gowuche
//
//  Created by 上海点硕 on 16/4/20.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//

#import "addLocationViewController.h"
#import "addressViewController.h"

@interface addLocationViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation addLocationViewController
{
    UITextView *detialField;
    UILabel *place ;
    UITextField *numField;
    UITextField *nameField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor= [UIColor whiteColor];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style: UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    self.navigationItem.title= @"新建地址";
    //tableView.rowHeight= 50;
    tableView.delegate= self;
    tableView.dataSource= self;
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name: UITextViewTextDidChangeNotification object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textchange1) name: UITextFieldTextDidChangeNotification object:nil];
    
       UIButton *saveBTN = [[UIButton alloc] init];
      saveBTN.backgroundColor= [UIColor grayColor];
      saveBTN.frame= CGRectMake(20, 390, 335, 50);
      [saveBTN setTitle:@"保存" forState:UIControlStateNormal];
      [self.view addSubview:saveBTN];
    [saveBTN addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    

}
- (void)saveClick
{
    [self.delegate passModel:nameField.text andtell:numField.text anddizhi:detialField.text];

    [self.navigationController popViewControllerAnimated:YES];
    

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }
    
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0000001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 10;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2&&indexPath
        .row==0) {
        return 120;
    }
    else {
        return kScreen_Height/15;
      
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        
    if (indexPath.section==0&&indexPath.row==0)
    {
        nameField = [[UITextField alloc] init];
        nameField.frame= CGRectMake(20, 0, self.view.bounds.size.width, 50);
        nameField.textAlignment= NSTextAlignmentLeft;
        [cell.contentView addSubview:nameField];
        nameField.placeholder= @"收货人姓名";
    }
    else if (indexPath.section==0&&indexPath.row == 1)
    {
        numField = [[UITextField alloc] init];
        numField.frame= CGRectMake(20, 0, self.view.bounds.size.width, 50);
        numField.textAlignment= NSTextAlignmentLeft;
        [cell.contentView addSubview:numField];
        numField.placeholder= @"联系电话";
          
    }
    else if(indexPath.section==1&&indexPath.row==0)
    {
        UITextField *wzField = [[UITextField alloc] init];
        wzField.frame= CGRectMake(20, 0, self.view.bounds.size.width, 50);
        wzField.textAlignment= NSTextAlignmentLeft;
        [cell.contentView addSubview:wzField];
        wzField.placeholder= @"地区";
       
    }
    else if(indexPath.section==2&&indexPath.row==0)
    {
        detialField = [[UITextView alloc] init];
        detialField.font= [UIFont systemFontOfSize:17];
        detialField.frame= CGRectMake(18, 0, self.view.bounds.size.width, 50);
        detialField.textAlignment= NSTextAlignmentLeft;
        [cell.contentView addSubview:detialField];
        //detialField.backgroundColor= [UIColor orangeColor];
        place = [[UILabel alloc] init];
        place.frame=CGRectMake(21, 9, 68, 17);
        [cell.contentView addSubview:place];
        //place.enabled=NO;
        place.textColor=[UIColor lightGrayColor];
        //place.backgroundColor= [UIColor  blackColor];
        place.text= @"详细地址";
        
    }
        
    }
    
    return cell;
}

- (void)textChanged
{
    
     place.text = @"";
    CGSize fheight = [self sizeWithString:detialField.text font:[UIFont systemFontOfSize:17]];
    detialField.frame= CGRectMake(20, 0, self.view.bounds.size.width, fheight.height+33);
    if ([detialField.text isEqualToString:@""]) {
        place.text= @"详细地址";
    }
    
}
- (void)textchange1
{
    NSLog(@"%@", nameField.text);
    NSLog(@"%@", numField.text);
    

}

- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(self.view.bounds.size.width-30, 100)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
   
}

@end
