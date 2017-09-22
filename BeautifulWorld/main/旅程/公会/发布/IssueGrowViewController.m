//
//  IssueGrowViewController.m
//  demo
//
//  Created by yuanju001 on 16/9/27.
//  Copyright © 2016年 yuanju001. All rights reserved.
//

#import "IssueGrowViewController.h"
#import "CXXChooseImageViewController.h"

@interface IssueGrowViewController ()<UITableViewDelegate,UITableViewDataSource,CXXChooseImageViewControllerDelegate>{
    //文字数组
    NSMutableArray *_dataArray;
    //详情数组
    NSMutableArray * _detailArr;
    
    NSMutableArray * imgArr;
    
    CXXChooseImageViewController *vc;
//    //上传图片
//    UIButton * part;
}

@property (nonatomic, strong) CXXChooseImageViewController *vc;
@property (strong,nonatomic)  UIView * footView; //脚视图
@property (strong,nonatomic) UITableView * myTable;//表视图
@property (strong,nonatomic) UILabel * label;
@property (assign,nonatomic) CGPoint point;
@end

@implementation IssueGrowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(issueClick)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    [self creatUITableView];

    // Do any additional setup after loading the view.
}

-(void)issueClick{
    CBTextView * text = (id)[self.view viewWithTag:123];
    CBTextView * text1 = (id)[self.view viewWithTag:122];
    NSLog(@"%@获取的内容为％％％％％％％％%@",text1.textView.text,text.textView.text);
   // NSLog(@"%@",vc.dataArr);
    imgArr = [[NSMutableArray alloc]init];
    for (int i = 0;i<vc.dataArr.count ; i++) {
        UIImage * image = vc.dataArr[i];
        NSData * imaData = UIImageJPEGRepresentation(image, 0.5);
        NSString * pictureDataString=[imaData base64Encoding];
        [imgArr addObject:pictureDataString];
    }
    NSLog(@"发布的图片数组个数%ld",imgArr.count);
    
    
      NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:imgArr forKey:@"img"];
    [params addUnEmptyString:[UserInfo sharedUserInfo].user_id forKey:@"user_id"];
    if ([text.textView.text isEqualToString:@"说点什么吧"]) {
        text.textView.text = @"";
    }
    if ([text1.textView.text isEqualToString:@"您的联系方式"]) {
        text1.textView.text = @"";
    }
    [params addUnEmptyString:text.textView.text forKey:@"content"];
    [params addUnEmptyString:text1.textView.text forKey:@"phone"];
    
    [[HttpClient shareInstance] requestApiWithurl:@"sell" parmar:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"上传成功%@",responseObject);
        [HUD showAlertWithTitle:@"上传成功"];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failuer:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
          NSLog(@"上传失败%@",responseObject);
    }];
}

#pragma mark -创建表格视图
-(void)creatUITableView{
    _myTable =[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:_myTable];
    _myTable.delegate=self;
    _myTable.dataSource=self;
    //    _myTable.backgroundColor=RGBColor(244, 251, 255);
    
    [self addFootViewCust];
    
}
-(void)addFootViewCust{
    
    vc = [[CXXChooseImageViewController alloc] init];
    vc.delegate = self;
    self.vc = vc;
    [self addChildViewController:vc];
    
    [vc setOrigin:CGPointMake(0, 0) ItemSize:CGSizeMake((self.view.frame.size.width - 40) / 3, (self.view.frame.size.width - 40) / 3) rowCount:3]; //注意要满足 ItemSize的宽度 * rowCount < 屏幕宽度
    [_myTable setTableFooterView:vc.view];
    _point = self.myTable.tableFooterView.frame.origin;
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(10, _point.y - 18, kScreen_Width, 15)];
    self.label.text = @"最多可以选三张照片";
    self.label.font = [UIFont systemFontOfSize:14];
    self.label.textColor = [UIColor grayColor];
    self.label.hidden = YES;
    [self.myTable addSubview:self.label];
    if (self.isThreeOrNine == YES) {
        vc.maxImageCount = 9;
    }else{
        vc.maxImageCount = 3;
        self.label.hidden = NO;
    }
    
}
- (void)chooseImageViewControllerDidChangeCollectionViewHeigh:(CGFloat)height{
    self.vc.view.frame =  CGRectMake(_point.x, _point.y, kScreen_Width, height);
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSInteger row = [indexPath row];
    
    static NSString  *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
    }
    //cell.textLabel.textColor = [UIColor darkGrayColor];
    
    
    _textView = [[CBTextView alloc] init];
    _textView.placeHolderColor = [UIColor grayColor];
    
    switch (indexPath.row) {
        case 0:{
            CGRect textFieldRect = CGRectMake(0, 0, kScreen_Width - 20, 50);
            _textView.placeHolder = @"您的联系方式";
            _textView.tag = 122;
            [_textView setFrame:textFieldRect];
            //cell.accessoryView = _textView;
        }
            break;
        case 1:{
            CGRect textFieldRect = CGRectMake(0, 0, kScreen_Width - 20, 150);
            _textView.placeHolder = @"说点什么吧";
            _textView.tag = 123;
            [_textView setFrame:textFieldRect];
            //cell.accessoryView = _textView;
        }
            
            break;
        default:
            break;
    }
    
    cell.accessoryView = _textView;
    
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat heightRow ;
    switch (indexPath.row) {
        case 0:
            heightRow = 50;
            break;
        case 1:
            heightRow = 150;
            break;
        default:
            break;
    }
    return heightRow;
}



@end
