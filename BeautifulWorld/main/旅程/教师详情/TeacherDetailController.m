//
//  TeacherDetailController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/7.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "TeacherDetailController.h"
#import "TeacherDetailCell.h"
#import "RecommendHeadView.h"
#import "HotGoodsTableCell.h"
#import "HotModel.h"
@interface TeacherDetailController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>{
    UIView * headView;
     UIView * footView;
     RecommendHeadView *_cellHeadView;
    NSMutableArray * _shopArray;

}
@property (nonatomic,strong)UITableView * tacherTab;
@property (nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation TeacherDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatData];
    [self loadShopData];
    [self initTabView];
    // Do any additional setup after loading the view.
}

-(void)loadShopData{
    _shopArray = [[NSMutableArray alloc]init];
    NSArray * ima = @[@"WechatIMG31",@"WechatIMG32",@"WechatIMG33",@"WechatIMG34"];
    for (int i = 0; i<4; i++) {
        HotModel * goods = [[HotModel alloc]init];
        //        NSString * img = [NSString stringWithFormat:@"%d.jpg",i];
        goods.cover = ima[i];
        goods.works = @"美丽世界";
        goods.author = @"JayChou";
        goods.price = @"12.00";
        
        
        [_shopArray addObject:goods];
    }
    
}

-(void)initTabView{
    _tacherTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-NavBar_Height) style:UITableViewStyleGrouped];
    _tacherTab.delegate =self;
    _tacherTab.dataSource =self;
    headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/3)];
    headView.backgroundColor = [UIColor whiteColor];
    _tacherTab.tableHeaderView = headView;
    [self.view addSubview:_tacherTab];
    
    
    
    [self initHeadView];
}
-(void)initHeadView{
    //关注
    UILabel * focusLab  = [[UILabel alloc]init];
    focusLab.frame = CGRectMake(kScreen_Width/5*3,kScreen_Height/3/5*2, kScreen_Width/5, 20);
    focusLab.text  = @"关注: 2";
    focusLab.textAlignment  =NSTextAlignmentCenter;
    focusLab.font = [UIFont systemFontOfSize:15];
    focusLab.textColor =[UIColor darkGrayColor];
    [headView addSubview:focusLab];
    
    //粉丝
    UILabel * fansLab  = [[UILabel alloc]init];
    fansLab.frame = CGRectMake(kScreen_Width/5*4, focusLab.y, kScreen_Width/5, 20);
    fansLab.text  = @"粉丝: 0";
    fansLab.font = [UIFont systemFontOfSize:15];
    fansLab.textAlignment  =NSTextAlignmentCenter;
    fansLab.textColor =[UIColor darkGrayColor];
    [headView addSubview:fansLab];
    
    //分割线
    UIView * line = [[UIView alloc]init];
    line.frame = CGRectMake(kScreen_Width/5*4-1, focusLab.y-5, 1, 30);
    line.backgroundColor = [UIColor grayColor];
    [headView addSubview:line];
    
    //拜师按钮
    UIButton * focusbtn= [UIButton buttonWithType:UIButtonTypeCustom];
    focusbtn.frame = CGRectMake(kScreen_Width/2+10, line.y+35, kScreen_Width/5, 25);
    focusbtn.layer.masksToBounds = YES;
    focusbtn.layer.cornerRadius = 5;
    focusbtn.backgroundColor = RGBColor(25, 136, 204);
    [focusbtn setTitle:@"拜师" forState:UIControlStateNormal];
    
    focusbtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [headView addSubview:focusbtn];
    
    
    //关注
    UIButton * chatbtn= [UIButton buttonWithType:UIButtonTypeCustom];
    chatbtn.frame = CGRectMake(kScreen_Width/4*3+10, line.y+35, kScreen_Width/5, 25);
    chatbtn.layer.masksToBounds = YES;
    chatbtn.layer.cornerRadius = 5;
    chatbtn.backgroundColor = RGBColor(25, 136, 204);
    [chatbtn setTitle:@"关注" forState:UIControlStateNormal];
    chatbtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [headView addSubview:chatbtn];
    
    UILabel * introduceLab = [[UILabel alloc]init];
    introduceLab.frame = CGRectMake(5, line.y+50, kScreen_Width - 10, kHeight - line.y-50);
    introduceLab.text = @"李明老师，西安美术学院教授，教学经验丰富，西安美术学院教授，教学经验丰富，西安美术学院教授，教学经验丰富";
    introduceLab.textColor = [UIColor darkGrayColor];
    introduceLab.font = [UIFont systemFontOfSize:12];
    introduceLab.numberOfLines = 4;
    
    [headView addSubview:introduceLab];
    

}
-(NSMutableArray*)dataArr{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}
-(void)creatData{
    
   
    _dataArr = [NSMutableArray array];
    for (NSInteger i = 0; i < 3 ; i++) {
        TeacherDetailModel * teachModel = [[TeacherDetailModel alloc]init];
        NSString * ima = [NSString stringWithFormat:@"%ld.jpg",i];
        teachModel.imaName =ima ;
        teachModel.courseName = @"国画艺术";
        teachModel.introduce = @"中国绘画有着深厚的审美内涵，人们欣赏中国绘画，不但可以了解许多社会的、历史的、文化的知识，而且在潜移默化之中，陶冶情操、提高审美能力、获得美的享受。";
        [_dataArr addObject:teachModel];
        
     }
  }
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _dataArr.count;

    }else{
        return 1;
    }
   }
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TeacherDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TeacherDetailCell"];
    if (!cell) {
        cell = [[TeacherDetailCell alloc]init];
        
    }
    
    static NSString *identfire=@"HotGoodsTableCell";
    
    HotGoodsTableCell *hotcell=[tableView dequeueReusableCellWithIdentifier:identfire];
    
    if (!hotcell) {
        
        hotcell=[[HotGoodsTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfire];
    }
    
    
    if (indexPath.section == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.course = _dataArr[indexPath.row];
        return cell;
    }
    else{
        hotcell.modelArray=_shopArray;
        hotcell.delegate=self;
        hotcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return hotcell;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
         return kScreen_Height/8;
    }else{
        return kScreen_Height/2;
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section ==0) {
        return kScreen_Height/15;
    }else{
        return 0;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return 0;
    }else{
        return 30;
    }

}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/15)];
        footView.backgroundColor = [UIColor whiteColor];
        
        UIButton * allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        allBtn.frame = CGRectMake(kScreen_Width/8*3, 10, kScreen_Width/4, 25);
        [allBtn setTitle:@"查看全部" forState:UIControlStateNormal];
        allBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [footView addSubview:allBtn];
        return footView;

    }else{
        return nil;
    }
    }
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    _cellHeadView=[[RecommendHeadView alloc]init];
    _cellHeadView.tag=section;
    
    if (section==0) {
        
        _cellHeadView.more.hidden=YES;
        _cellHeadView.moreimage.hidden=YES;
        _cellHeadView.Title.text=@"";
    }else{
        _cellHeadView.Title.text=@"推荐作品";
        UITapGestureRecognizer *tapHeadView=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHeadView:)];
        tapHeadView.delegate=self;
        [_cellHeadView addGestureRecognizer:tapHeadView];
        
    }
    
    return _cellHeadView;
}
-(void)tapHeadView:(UIGestureRecognizer*)sender
{
    
    
    NSLog(@"fhdetheiurtho ew");
   }

@end
