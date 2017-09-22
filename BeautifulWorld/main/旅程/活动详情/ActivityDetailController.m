//
//  ActivityDetailController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/13.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "ActivityDetailController.h"
#import "CommentTableViewCell.h"
#import "CommentBar.h"
#import "ActivityShowTableCell.h"
static NSString * actCellIdent = @"ActivityShowTableCell";
@interface ActivityDetailController ()<UITableViewDelegate,UITableViewDataSource,CommentTableViewCellDelegate,CommentBarDelegate>{
    UIView * headView;
    ActivityShowTableCell * actCell;
}

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,strong)NSMutableArray * souceArr;
@property (nonatomic, strong) NSIndexPath * indexPath;
@end

@implementation ActivityDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self loadData];
    self.view.backgroundColor  = [UIColor whiteColor];
    [self initView];
//    [self createUI];
//    [self createBottomBar];
//
    // Do any additional setup after loading the view.
}

-(void)initView{
    UIImageView * backIma = [[UIImageView alloc]init];
    backIma.image = LoadImageByName(@"每日活动_02");
    backIma.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height/1334*750);
    [self.view addSubview:backIma];
    
    
//    UIButton * focus = [UIButton buttonWithType:UIButtonTypeCustom];
//    focus.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    NSArray * btnIma = @[@"guanzhu_06",@"canyu_03"];
    CGFloat btnMargin = kScreen_Width/7;
    CGFloat btnw = kScreen_Width/7*2;
    for (int i =0; i < 2; i++) {
            UIButton * focus = [UIButton buttonWithType:UIButtonTypeCustom];
        focus.frame = CGRectMake(btnMargin+(btnMargin+btnw)*i, CGRectGetHeight(backIma.frame)+20, btnw, 35);
        if (i==0) {
            [focus setBackgroundImage:LoadImageByName(@"yiguanzhu_04") forState:UIControlStateSelected];
        }
        [focus setImage:LoadImageByName(btnIma[i]) forState:UIControlStateNormal];
        [self.view addSubview:focus];
        

    }
}
//
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.bottomBar.hidden = NO;
//}
//-(void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    self.bottomBar.hidden = YES;
//}
#pragma mark -UI
-(void)createBottomBar{
    
    CommentBar * commentBar =[[CommentBar alloc]initWithFrame:CGRectMake(0, kScreen_Height - NavBar_Height - StatusBar_Height - Tabbar_Height, kScreen_Width, Tabbar_Height)];
    commentBar.delegate = self;
    commentBar.bgview.backgroundColor =[UIColor clearColor];
    commentBar.bgview.layer.borderColor = [UIColor lightGrayColor].CGColor;    commentBar.bgview.layer.borderWidth = 1;
    [self.view addSubview:commentBar];
    
}


#pragma mark - 懒加载
-(NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _dataArr;
}
-(NSMutableArray *)souceArr{
    if (_souceArr == nil) {
        _souceArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _souceArr;
}
-(void)createUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height -NavBar_Height - StatusBar_Height)style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    UIView * tabHead = [[UIView alloc]init];
    tabHead.frame =CGRectMake(0, 0, kScreen_Width, kScreen_Height/2+kScreen_Height/6);
    tabHead.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = tabHead;
    
    UIImageView * imaIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, kScreen_Width/6, kScreen_Width/6)];
    imaIcon.image = LoadImageByName(@"教师风采");
    [tabHead addSubview:imaIcon];
    
    UILabel * nameLab = [[UILabel alloc]init];
    nameLab.frame = CGRectMake(20+imaIcon.frame.size.width, 12, 100, 20);
    nameLab.text = @"李文峰";
    nameLab.font = [UIFont systemFontOfSize:14];
    [tabHead addSubview:nameLab];
    
    //关注
    UIButton * focus = [UIButton buttonWithType:UIButtonTypeCustom];
    focus.frame = CGRectMake(kScreen_Width-60, 20, 50, 25);
    focus.backgroundColor = RGBColor(230, 231, 234);
    [focus setTitleColor:BlueTitileColor forState:UIControlStateNormal];
    [focus setTitle:@"关注" forState:UIControlStateNormal];
    focus.layer.masksToBounds = YES;
    focus.layer.cornerRadius = 5;
    [tabHead addSubview:focus];
    
    UILabel * timeLab = [[UILabel alloc]initWithFrame:CGRectMake(nameLab.x, 35, kScreen_Width/3, 18)];
    timeLab.text =@"发布于2小时以前";
    timeLab.font = [UIFont systemFontOfSize:13];
    [tabHead addSubview:timeLab];
    
    UILabel * theme = [[UILabel alloc]initWithFrame:CGRectMake(10, 75, kScreen_Width/3, 20)];
    theme.font =[UIFont systemFontOfSize:14];
    theme.text = @"活动主题";
    [tabHead addSubview:theme];
    
    UILabel * content1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 97, kScreen_Width-20, 40)];
    content1.text = @"活动内容活动内容活动内容活动内容活动内容活动内容活动内容v活动内容活动内容活动内容活动内容";
    content1.numberOfLines = 2;
    content1.font =[UIFont systemFontOfSize:12];
    [tabHead addSubview:content1];
    
    UIImageView * imaShow = [[UIImageView alloc]initWithFrame:CGRectMake(10, 140, kScreen_Width-20, kScreen_Height/2/3)];
    imaShow.image = LoadImageByName(@"0.jpg");
    [tabHead addSubview:imaShow];
    
    
    UILabel * content2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 145+kScreen_Height/6, kScreen_Width-20, 40)];
    content2.text = @"活动内容活动内容活动内容活动内容活动内容活动内容活动内容v活动内容活动内容活动内容活动内容";
    content2.numberOfLines = 2;
    content2.font =[UIFont systemFontOfSize:12];
    [tabHead addSubview:content2];
    
    
    UIButton * joinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    joinBtn.frame = CGRectMake(kScreen_Width/5*2, content2.y+40, kScreen_Width/5, 25);
    joinBtn.backgroundColor = RGBColor(230, 231, 234);
    [joinBtn setTitle:@"参与" forState:UIControlStateNormal];
    joinBtn.layer.masksToBounds = YES;
    joinBtn.layer.cornerRadius = 5;
    [joinBtn setTitleColor:BlueTitileColor forState:UIControlStateNormal];
    [tabHead addSubview:joinBtn];
    
    
    UILabel * joinNum = [[UILabel alloc]init];
    joinNum.frame = CGRectMake(10, joinBtn.y+40, kScreen_Width/3, 20);
    joinNum.text = @"共20人参与";
    joinNum.font = [UIFont systemFontOfSize:14];
    [tabHead addSubview:joinNum];
    CGFloat margin = 15;
    CGFloat iconW = (kScreen_Width - margin*7)/6;
    for (NSInteger i =0 ; i<6; i++) {
        UIImageView * joinIcon = [[UIImageView alloc]init];
        joinIcon.frame = CGRectMake(margin+(margin+iconW)*i, joinNum.y+25, iconW, iconW);
        joinIcon.layer.masksToBounds = YES;
        joinIcon.layer.cornerRadius = iconW/2;
        NSString * ima = [NSString stringWithFormat:@"%ld.jpg",(long)i];
        joinIcon.image = LoadImageByName(ima);
        [tabHead addSubview:joinIcon];
        
    }
    

    
    
    
//    [tabHead addSubview:imaIcon];

    [_tableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"CommentTableViewCell"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"ActivityShowTableCell" bundle:nil] forCellReuseIdentifier:actCellIdent];
    [self.view addSubview:_tableView];
    
}
#pragma mark - 加载数据
-(void)loadData{
    ActivityDetailModel * knowledge = [[ActivityDetailModel alloc]init];
    knowledge.icon = @"教师风采";
    knowledge.name = @"李文风";
    knowledge.date = @"2017-3-2";
    knowledge.detail1 = @"孩子之间的冲突时如何发生的,孩子之间的冲突时如何发生的孩子之间的冲突时如何发生的孩子之间的冲突时如何发生的孩子之间的冲突时如何发生的孩子之间";
    knowledge.detail2 = @"孩子之间的冲突时如何发生的,孩子之间的冲突时如何发生的孩子之间的冲突时如何发生的孩子之间的冲突时如何发生的孩子之间的冲突时如何发生的孩子之间";
    knowledge.theme = @"美丽新世界公测";
    knowledge.ima = @"活动1";
    knowledge.joinNum = @"24";

    [self.dataArr addObject:knowledge];
    commentModel * comment1 = [[commentModel alloc]init];
    comment1.icon = @"用户3";
    comment1.title = @"布兰妮";
    comment1.date = @"10分钟前";
    comment1.detail = @"这期内容非常好";
    comment1.number = @"23";
    [self.souceArr addObject:comment1];
    commentModel * comment2 = [[commentModel alloc]init];
    comment2.icon = @"用户2";
    comment2.title = @"艾薇儿";
    comment2.date = @"45分钟前";
    comment2.detail = @"孩子之间的冲突时如何发生的,孩子之间的冲突时如何发生的这期内容非常好,重要的事情说三遍，重要的事情说三遍，重要的事情说三遍";
    comment2.number = @"12";
    [self.souceArr addObject:comment2];
}
#pragma mark - tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section == 0) {
//        return 1;
//    }else{
        return  self.souceArr.count ;
//    }
    

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
//     if (indexPath.section == 0) {
//         actCell = [tableView dequeueReusableCellWithIdentifier:actCellIdent forIndexPath:indexPath];
//
//        actCell.actDetail = self.dataArr[0];
//        actCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        return actCell;
//    }else{
          CommentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CommentTableViewCell" forIndexPath:indexPath];
        self.indexPath = indexPath;
        cell.delegate = self;
        [cell setContents:self.souceArr[indexPath.row]];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        return cell;

//    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
//        return kScreen_Height/3*2;
//    }else{
        return [CommentTableViewCell cellHeight:self.souceArr[indexPath.row ]];

//    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(void)pressZan:(NSString *)likeNum{
    NSLog(@"%@",likeNum);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 1) {
        return 30;
//    }else{
//       return 0.01;
//    }

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
//    if (section == 1) {
        headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 30)];
        headView.backgroundColor = [UIColor whiteColor];
        UILabel * headLab = [[UILabel alloc]init];
        headLab.frame = CGRectMake(10, 5, kScreen_Width/2, 20);
        headLab.text = @"全部评论  (10)";
        headLab.textColor = [UIColor blackColor];
        headLab.font = [UIFont systemFontOfSize:15];
        [headView addSubview:headLab];
        return headView;
//
//    }
//    else{
//        return nil;
//    }
    
    
}

@end
