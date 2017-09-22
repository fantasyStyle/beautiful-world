//
//  BabyChooseViewController.m
//  demo
//
//  Created by yuanju001 on 16/10/29.
//  Copyright © 2016年 yuanju001. All rights reserved.
//

#import "BabyChooseViewController.h"
#import "BabyChooseCell.h"
@interface BabyChooseViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView * myTable;
    NSInteger current;
   
}
@property(nonatomic,strong)NSMutableArray * babyArr;
@property(nonatomic,strong)NSMutableArray * resuleArr;
@end

@implementation BabyChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(certainclick)];
    [self creatDateSource];
    [self creatUITableView];
    
    
    // Do any additional setup after loading the view.
}
-(NSMutableArray *)babyArr{
    if (_babyArr == nil) {
        _babyArr = [[NSMutableArray alloc]init];
    }
    return _babyArr;
}
-(NSMutableArray *)resuleArr{
    if (_resuleArr == nil) {
        _resuleArr = [[NSMutableArray alloc]init];
    }
    return _resuleArr;
}

-(void)creatDateSource{
   
    BabyModel * baby1 = [[BabyModel alloc]init];
    baby1.babyName = @"李小冉";
    baby1.cover = @"头像";
    baby1.classes = @"一年级三班";
    [self.babyArr addObject:baby1];
    
    BabyModel * baby2 = [[BabyModel alloc]init];
    baby2.babyName = @"刘语熙";
    baby2.cover = @"头像";
    baby2.classes = @"二年级一班";
    [self.babyArr addObject:baby2];
    
    BabyModel * baby3 = [[BabyModel alloc]init];
    baby3.babyName = @"王尔琳";
    baby3.cover = @"头像";
    baby3.classes = @"一年级一班";
    [self.babyArr addObject:baby3];

    
    
}
-(void)certainclick{
    [self.navigationController popViewControllerAnimated:YES];
    //BabyModel * baby = [[BabyModel alloc]init];
    BabyModel * baby =(id) self.babyArr[current];
    [UserInfo sharedUserInfo].babyName =baby.babyName;
    [[UserInfo sharedUserInfo] saveUserInofFromSanbox];

    
  }
#pragma mark -创建表格视图
-(void)creatUITableView{
     myTable =[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:myTable];
    myTable.delegate=self;
    myTable.dataSource=self;
    myTable.backgroundColor=RGBColor(244, 251, 255);

    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID=@"cellId";

    BabyChooseCell * babyCell =[tableView dequeueReusableCellWithIdentifier:cellID];
        if (babyCell == nil) {
            babyCell = [[BabyChooseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
    }
        babyCell.choosedBabyModel=self.babyArr[indexPath.row];
    
    babyCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
       return  babyCell;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.babyArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreen_Height/10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    current=indexPath.row;
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    [user setInteger:current  forKey:@"select"];
    [user synchronize];
    [myTable reloadData];
   
}
- (UITableViewCellAccessoryType)tableView:(UITableView*)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath*)indexPath
{
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    current =[user integerForKey:@"select"];
    
    if(current==indexPath.row)
    {
        return UITableViewCellAccessoryCheckmark;
    }
    else
    {
        return UITableViewCellAccessoryNone;
    }
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
