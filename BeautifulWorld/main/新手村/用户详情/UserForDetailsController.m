//
//  UserForDetailsController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/6.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "UserForDetailsController.h"
#import "YFViewPager.h"

#import "StudyTableViewCell.h"
#import "BookTableViewCell.h"
@interface UserForDetailsController ()<UITableViewDelegate,UITableViewDataSource>{
    YFViewPager *_viewPager;
    UIWebView    *_webView;
    
    UIView * studyView;//学习
    UIView * bookView;//帖子
    UIView * favoriteView;//喜欢
}
@property (nonatomic,strong)UITableView * studyTabView;

@property (nonatomic,strong)UITableView * bookTabView;

@property (nonatomic,strong)UITableView * favotiteTabView;

@property (nonatomic,strong)NSMutableArray * studyArr;

@property (nonatomic,strong)NSMutableArray * bookArr;

@property (nonatomic,strong)NSMutableArray * favoriteArr;
@end

@implementation UserForDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];

    [self setUpheadVIew];
    [self initViewPager];
    // Do any additional setup after loading the view.
}
-(void)setUpheadVIew{
   
    CGFloat KHhead = kScreen_Height/4;
    UIView * headView = [[UIView alloc]init];
    headView.backgroundColor = [UIColor whiteColor];
    headView.frame = CGRectMake(0, 0, kScreen_Width, KHhead);
//    UIImageView * ima = [[UIImageView alloc]initWithFrame:headView.bounds];
//    ima.image = LoadImageByName(@"6.jpg");
//    [headView addSubview:ima];
    [self.view addSubview:headView];
    
    //等级
    UILabel * gradeLab = [[UILabel alloc]init];
    gradeLab.frame = CGRectMake(5, KHhead -70, kScreen_Width/3, 20);
    gradeLab.text  = @"等级: 0";
    gradeLab.font = [UIFont systemFontOfSize:15];
    gradeLab.textColor =[UIColor darkGrayColor];
    [headView addSubview:gradeLab];
    
    //完成课程数
    UILabel * courseLab = [[UILabel alloc]init];
    courseLab.frame = CGRectMake(5, gradeLab.y+20, kScreen_Width/3, 20);
    courseLab.text  = @"完成课程数: 0次";
    courseLab.font = [UIFont systemFontOfSize:15];
    courseLab.textColor =[UIColor darkGrayColor];
    [headView addSubview:courseLab];
    
    //性别
    UILabel * sexLab  = [[UILabel alloc]init];
    sexLab.frame = CGRectMake(5, courseLab.y+20, kScreen_Width/3, 20);
    sexLab.text  = @"性别: 男";
    sexLab.font = [UIFont systemFontOfSize:15];
    sexLab.textColor =[UIColor darkGrayColor];
    [headView addSubview:sexLab];
    
    //关注
    UILabel * focusLab  = [[UILabel alloc]init];
    focusLab.frame = CGRectMake(kScreen_Width/5*3, gradeLab.y, kScreen_Width/5, 20);
    focusLab.text  = @"关注: 2";
    focusLab.textAlignment  =NSTextAlignmentCenter;
    focusLab.font = [UIFont systemFontOfSize:15];
    focusLab.textColor =[UIColor darkGrayColor];
    [headView addSubview:focusLab];
    
    //粉丝
    UILabel * fansLab  = [[UILabel alloc]init];
    fansLab.frame = CGRectMake(kScreen_Width/5*4, gradeLab.y, kScreen_Width/5, 20);
    fansLab.text  = @"粉丝: 0";
    fansLab.font = [UIFont systemFontOfSize:15];
    fansLab.textAlignment  =NSTextAlignmentCenter;
    fansLab.textColor =[UIColor darkGrayColor];
    [headView addSubview:fansLab];
    
    //分割线
    UIView * line = [[UIView alloc]init];
    line.frame = CGRectMake(kScreen_Width/5*4-1, gradeLab.y-5, 1, 30);
    line.backgroundColor = [UIColor grayColor];
    [headView addSubview:line];
    
    //关注按钮
    UIButton * focusbtn= [UIButton buttonWithType:UIButtonTypeCustom];
    focusbtn.frame = CGRectMake(kScreen_Width/2, line.y+35, kScreen_Width/5, 25);
    focusbtn.layer.masksToBounds = YES;
    focusbtn.layer.cornerRadius = 5;
    focusbtn.backgroundColor = RGBColor(25, 136, 204);
    [focusbtn setTitle:@"关注" forState:UIControlStateNormal];
    
    focusbtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [headView addSubview:focusbtn];


     //私聊
    UIButton * chatbtn= [UIButton buttonWithType:UIButtonTypeCustom];
    chatbtn.frame = CGRectMake(kScreen_Width/4*3, line.y+35, kScreen_Width/5, 25);
    chatbtn.layer.masksToBounds = YES;
    chatbtn.layer.cornerRadius = 5;
    chatbtn.backgroundColor = RGBColor(25, 136, 204);
    [chatbtn setTitle:@"私聊" forState:UIControlStateNormal];
    chatbtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [headView addSubview:chatbtn];
    

    


}

-(void)initViewPager
{
    
//    _webView = [[UIWebView alloc] init];
//    [_webView loadRequest:[NSURLRequest requestWithURL:[[NSURL alloc] initWithString:@"https://www.baidu.com"]]];
    
    studyView = [[UIView alloc]init];
    studyView.backgroundColor = [UIColor grayColor];
    [self initStudyView];
    
    bookView = [[UIView alloc]init];
    bookView.backgroundColor =[UIColor redColor];
    [self initBookView];
    
   favoriteView = [[UIView alloc]init];
    favoriteView.backgroundColor = [UIColor greenColor];
    
    NSArray *titles = [[NSArray alloc] initWithObjects:
                       @"学习",
                       @"帖子",
                       @"喜欢", nil];
    
    NSArray *views = [[NSArray alloc] initWithObjects:
                      studyView,
                      bookView,
                      favoriteView, nil];
    
    _viewPager = [[YFViewPager alloc] initWithFrame:CGRectMake(0,kScreen_Height/4, kScreen_Width ,kScreen_Height/4*3-20)
                                             titles:titles
                                              icons:nil
                                      selectedIcons:nil
                                              views:views];
    [self.view addSubview:_viewPager];
    
    [_viewPager didSelectedBlock:^(id viewPager, NSInteger index) {
        switch (index) {
            case 0:
            {
                NSLog(@"点击第一个菜单");
            }
                break;
            case 1:
            {
                NSLog(@"点击第二个菜单");
            }
                break;
            case 2:
            {
                NSLog(@"点击第三个菜单");
            }
                break;
                
            default:
                break;
        }
    }];
}



//学习页面
-(void)initStudyView{
       [self initstudyTabView];
}
//帖子页面
-(void)initBookView{
    [self initBookTabView];
}
//喜欢页面
-(void)initFavoriteView{
    
}

-(void)initstudyTabView{
    _studyTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/4*3-20) style:UITableViewStyleGrouped];
    _studyTabView.delegate =self;
    _studyTabView.dataSource =self;
    [studyView addSubview:_studyTabView];
    
}
-(void)initBookTabView{
    _bookTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/4*3-20) style:UITableViewStyleGrouped];
    _bookTabView.delegate =self;
    _bookTabView.dataSource =self;
    [bookView addSubview:_bookTabView];
    
}
-(void)initFavoriteTabView{
    _favotiteTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/4*3-20) style:UITableViewStyleGrouped];
    _favotiteTabView.delegate =self;
    _favotiteTabView.dataSource =self;
    [favoriteView addSubview:_favotiteTabView];
    
}


-(void)loadData{
    NSArray * nameArr = @[@"完成素描课第一节训练",@"完成素描课第二节训练",@"完成素描课第三节训练",@"完成素描课第四节训练"];
    if (!_studyArr) {
        _studyArr = [NSMutableArray array];
    }
//    _studyArr = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i< 4; i++) {
         StudyStateModel * model = [[StudyStateModel alloc]init];
        model.progress = nameArr[i];
        model.time = @"3小时以前";
        model.ynFinish = @"完成训练";
        [_studyArr addObject:model];
    }
    
    
    if (!_bookArr) {
        _bookArr = [NSMutableArray array];
    }
    NSArray * bookNameArr = @[@"今天是个好天气",@"love  is   over ",@"请你不要再说明",@"我的心意不是那样的"];
    for (NSInteger i = 0; i< 4; i++) {

    BookUserModel * bookModel = [[BookUserModel alloc]init];
        bookModel.bookName = bookNameArr[i];
        bookModel.time = @"2017-02-10";
        bookModel.imaName = @"WechatIMG31";
        [_bookArr addObject:bookModel];
    
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _studyTabView) {
        return _studyArr.count;
    }
    if (tableView == _bookTabView) {
        return  _bookArr.count;
    }
    else{
        return 2;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _studyTabView) {
        StudyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"studycellID"];
        if (!cell) {
            cell = [[StudyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"studycellID"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.studyState = _studyArr[indexPath.row];
        return cell;

    }else{
        BookTableViewCell * boolCell = [tableView dequeueReusableCellWithIdentifier:@"bookCell"];
        if (!boolCell) {
            boolCell = [[BookTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bookCell"];
            
        }
        boolCell.selectionStyle = UITableViewCellSelectionStyleNone;
        boolCell.userBook  = _bookArr[indexPath.row];
        return boolCell;
    }
    
    }
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _studyTabView) {
        return 50;
    }
    else{
        return kScreen_Height/8
        ;

    }
    }
-(void)backAction
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)shareAction
{
    NSLog(@"ShareBtn");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


-(NSString *)GetNowTimes
{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    return timeString;
}




@end
