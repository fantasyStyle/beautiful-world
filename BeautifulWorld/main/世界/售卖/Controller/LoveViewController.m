//
//  WorldSellViewController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/5/4.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "LoveViewController.h"
#import "SDTimeLineCell.h"
#import "SDTimeLineCellModel.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "IssueGrowViewController.h"
//#import "CommentToolBar.h"

#define kTimeLineTableViewCellId @"SDTimeLineCell"

@interface LoveViewController ()<SDTimeLineCellDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray * dataArr;

//
//@property(nonatomic,strong)CommentToolBar * commentToolBar;

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,assign)NSInteger row;

@end

@implementation LoveViewController
#pragma mark -懒加载
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _dataArr;
}

#pragma mark - UI
-(void)createUI{

    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(issueClick)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.edgesForExtendedLayout = UIRectEdgeTop;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height+NavBar_Height+StatusBar_Height)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIView * headView =[[UIView alloc]init];
    headView.backgroundColor = RGBColor(50, 158, 224);
    headView.frame = CGRectMake(0, 0, kScreen_Width, 50);
    //_tableView.tableHeaderView = headView;
    
    UIImageView * notify = [[UIImageView alloc]init];
    notify.frame = CGRectMake(20, 10, 70, 31);
    notify.image =LoadImageByName(@"tongzhi_03");
    [headView addSubview:notify];
    
    UILabel * notifyLab = [[UILabel alloc]init];
    notifyLab.frame = CGRectMake(100, 15, kScreen_Width-100, 20);
    notifyLab.textColor = [UIColor whiteColor];
    notifyLab.font = font15;
    notifyLab.text = @"用户馨于2017.04.26完成交易";
    [headView addSubview:notifyLab];

//    [self.dataArr addObjectsFromArray:[self creatModelsWithCount:10]];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(downKeyboard)];
    [self.tableView addGestureRecognizer:tap];
    
    [self.tableView registerClass:[SDTimeLineCell class] forCellReuseIdentifier:kTimeLineTableViewCellId];
    
//    self.commentToolBar = [[CommentToolBar alloc]initWithFrame:CGRectMake(0, kScreen_Height, kScreen_Width, 46) isSendItem:YES];
//    self.commentToolBar.delegate =self;
//    [self.view addSubview:self.commentToolBar];
}


#pragma mark - lifeCircle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"售卖";
    self.view.backgroundColor = RGBColor(235, 235, 241);
     [FTShowMessageView showStatusWithMessage:@"Loading..."];
    [self loadData];
    //[self createUI];

}

-(void)loadData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //顶部
    [[HttpClient shareInstance] requestApiWithurl:@"sellInfo"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        id  dic = [response objectForKey:@"result"];
        [FTShowMessageView dismiss];
        NSLog(@"求购信息的的%@",dic);
        for (NSMutableDictionary * subdic in dic) {
            SDTimeLineCellModel *model = [SDTimeLineCellModel new];
            model.iconName = subdic[@"head"];
            model.name = subdic[@"name"];
            model.msgContent = subdic[@"content"];
            model.time = subdic[@"time"];
            model.picNamesArray = subdic[@"picture"];
            model.phone = subdic[@"phone"];
            
            
            [self.dataArr addObject:model];
            [_tableView reloadData];
            
        }
        [self createUI];
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        [FTShowMessageView dismiss];
       
    
    }];

}

- (NSArray *)creatModelsWithCount:(NSInteger)count
{
    NSArray *iconImageNamesArray = @[@"head_wu_04",
                                     @"head_wu_04",
                                     @"head_wu_04",
                                     @"head_wu_04",
                                     @"head_wu_04",
                                     ];
    
    NSArray *namesArray = @[@"GSD_iOS",
                            @"风口上的猪",
                            @"当今世界网名都不好起了",
                            @"我叫郭德纲",
                            @"Hello Kitty"];
    
    NSArray *textArray = @[@"当你的 app 没有提供 3x 的 LaunchImage 时，系统默认进入兼容模式，https://github.com/gsdios/SDAutoLayout大屏幕一切按照 320 宽度渲染，屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，https://github.com/gsdios/SDAutoLayout等于把小屏完全拉伸。",
                           @"当你的 app 没有提供 3x 的 LaunchImage 时屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；https://github.com/gsdios/SDAutoLayout然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。",
                           @"但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
                           @"屏幕宽度返回 320；https://github.com/gsdios/SDAutoLayout然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。"
                           ];
    
    NSArray *commentsArray = @[@"社会主义好！👌👌👌👌",
                               @"正宗好凉茶，正宗好声音。。。",
                               @"你好，我好，大家好才是真的好",
                               @"有意思",
                               @"你瞅啥？",
                               @"瞅你咋地？？？！！！",
                               @"hello，看我",
                               @"曾经在幽幽暗暗反反复复中追问，才知道平平淡淡从从容容才是真，再回首恍然如梦，再回首我心依旧，只有那不变的长路伴着我",
                               @"人艰不拆",
                               @"咯咯哒",
                               @"呵呵~~~~~~~~",
                               @"我勒个去，啥世道啊",
                               @"真有意思啊你💢💢💢"];
    
    NSArray *picImageNamesArray = @[ @"renwu_01_03",
                                     @"renwu_02_03",
                                     @"renwu_03_03",
                                     @"renwu_04_03",
                                     @"renwu_05_03",
                                     @"renwu_06_03",
                                     @"renwu_02_03",
                                     @"renwu_03_03",
                                     @"renwu_05_03"
                                     ];
    NSMutableArray *resArr = [NSMutableArray new];
    
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(5);
        int nameRandomIndex = arc4random_uniform(5);
        int contentRandomIndex = arc4random_uniform(5);
        
        SDTimeLineCellModel *model = [SDTimeLineCellModel new];
        model.iconName = iconImageNamesArray[iconRandomIndex];
        model.name = namesArray[nameRandomIndex];
        model.msgContent = textArray[contentRandomIndex];
        
        
        // 模拟“随机图片”
        int random = arc4random_uniform(10);
        
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < random; i++) {
            int randomIndex = arc4random_uniform(9);
            [temp addObject:picImageNamesArray[randomIndex]];
        }
        if (temp.count) {
            model.picNamesArray = [temp copy];
        }
        
//        int commentRandom = arc4random_uniform(6);
//        NSMutableArray *tempComments = [NSMutableArray new];
//        for (int i = 0; i < commentRandom; i++) {
//            SDTimeLineCellCommentItemModel *commentItemModel = [SDTimeLineCellCommentItemModel new];
//            int index = arc4random_uniform((int)namesArray.count);
//            commentItemModel.firstUserName = namesArray[index];
//            commentItemModel.firstUserId = @"666";
//            if (arc4random_uniform(10) < 5) {
//                commentItemModel.secondUserName = namesArray[arc4random_uniform((int)namesArray.count)];
//                commentItemModel.secondUserId = @"888";
//            }
//            //commentItemModel.commentString = commentsArray[arc4random_uniform((int)commentsArray.count)];
//            [tempComments addObject:commentItemModel];
//        }
       // model.commentItemsArray = [tempComments copy];
        
        [resArr addObject:model];
    }
    return [resArr copy];
}

#pragma mark - 点击事件
-(void)issueClick{
    IssueGrowViewController * issue = [[IssueGrowViewController alloc]init];
    issue.title = self.title;
    issue.isThreeOrNine = YES;
    [self.navigationController pushViewController:issue animated:YES];
}


#pragma mark - tableView代理


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SDTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimeLineTableViewCellId];
    cell.delegate = self;
    cell.indexPath = indexPath;
    __weak typeof(self) weakSelf = self;
    if (!cell.moreButtonClickedBlock) {
        [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
            SDTimeLineCellModel *model = weakSelf.dataArr[indexPath.row];
            model.isOpening = !model.isOpening;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
    
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    id model = self.dataArr[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[SDTimeLineCell class] contentViewWidth:[self cellContentViewWith]];
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
////    _row = indexPath.row;
////    NSLog(@"**********************%ld",_row);
//}
-(void)downKeyboard{
//    [UIView animateWithDuration:0.3 animations:^{
//        self.commentToolBar.y = kScreen_Height;
//        [self.commentToolBar endEditing:YES];
//    }];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [UIView animateWithDuration:0.3 animations:^{
//        self.commentToolBar.y = kScreen_Height;
//        [self.commentToolBar endEditing:YES];
//    }];
//    
}

#pragma mark - SDTimeLineCellDelegate
-(void)pressFavoriteBtn:(SEL)btn{
    NSLog(@"");
}
-(void)pressShareBtn:(SEL)btn{
    NSLog(@"");
}
-(void)pressReplyBtn:(SEL)btn{
    
    
//    [UIView animateWithDuration:0.3 animations:^{
//        self.commentToolBar.y = kScreen_Height - 46-NavBar_Height - StatusBar_Height;
//        [self.commentToolBar.inputTextView becomeFirstResponder];
//    }];
    
}

-(void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel{
    NSLog(@"%@",link.linkValue);
    
}
-(void)CommentsLabelClickWithItemIndex:(NSInteger)index andIndexPath:(NSIndexPath *)indexPath{


    SDTimeLineCellModel * model = self.dataArr[indexPath.row];
    NSArray * arr = model.commentItemsArray;
    SDTimeLineCellCommentItemModel * itemModel = arr[index];
//    [UIView animateWithDuration:0.3 animations:^{
//        self.commentToolBar.y = kScreen_Height - 46-NavBar_Height - StatusBar_Height;
//        [self.commentToolBar.inputTextView becomeFirstResponder];
//        self.commentToolBar.inputTextView.placeHolder = [NSString stringWithFormat:@"回复%@",itemModel.firstUserName];
//    }];
//
}

-(void)didSelectedImageHidKeyboard{
//    [UIView animateWithDuration:0.3 animations:^{
//        self.commentToolBar.y = kScreen_Height;
//        [self.commentToolBar endEditing:YES];
//    }];
}


#pragma mark - CommentToolBarDelegate

-(void)didSendText:(NSString *)text{
    NSLog(@"%@",text);
}
- (void)chatToolbarDidChangeFrameToHeight:(CGFloat)toHeight{
    
}
@end
