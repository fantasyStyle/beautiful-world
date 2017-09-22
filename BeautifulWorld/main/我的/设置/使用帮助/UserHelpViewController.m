

#import "UserHelpViewController.h"
#import "HelpDetailCell.h"
#import "UserHelperCell.h"
#import "Helper.h"

static NSString *CellIdentifier2 = @"cellidentifer2";

static NSString *CellIdentifier1 = @"cellidentifer1";
@interface UserHelpViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSIndexPath *selectIndex;
    BOOL isOpen;
  
}
@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,strong)NSMutableArray * detailArr;
@property(nonatomic, strong)UITableView *CategoryTableView;

@end

@implementation UserHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"使用帮助";
    [self initHelpDateArr];
    [self.view addSubview:self.CategoryTableView];
    // Do any additional setup after loading the view.
}
-(NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}
-(NSMutableArray *)detailArr{
    if (_detailArr == nil) {
        _detailArr = [[NSMutableArray alloc]init];
    }
    return _detailArr;
}

-(void)initHelpDateArr{
    self.dataArr =[NSMutableArray arrayWithObjects:@"如何使用美丽新世界",@"美丽新世界欢迎页面",@"新世界的用处",@"学习进程如何记录",@"课程怎么用", nil];
    NSString * item  = @"尊敬的用户，您好！为提高系统运行效率，美丽新世界系统正在进行维护，维护期间您将无法进行正常的登录以及相关业务操作。系统维护期间，访问本系统会自动连接到维护页面。业务咨询及服务，请拨打我们的客服电话：029-88888888。";
        NSString * item1  = @"吹不散的雾，隐没了意图。";
    _detailArr = [NSMutableArray arrayWithObjects:item,item1,item,item1,item, nil];
}

-(UITableView *)CategoryTableView
{
    if (_CategoryTableView == nil) {
        _CategoryTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _CategoryTableView.delegate = self;
        _CategoryTableView.dataSource = self;
        _CategoryTableView.showsHorizontalScrollIndicator = NO;
        _CategoryTableView.showsVerticalScrollIndicator = NO;
        _CategoryTableView.separatorColor = [UIColor clearColor];
        _CategoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
      _CategoryTableView.backgroundColor=RGBColor(244, 251, 255);
    }
    return _CategoryTableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArr count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isOpen && selectIndex.section == section) {
        
        return 2;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isOpen && selectIndex.section == indexPath.section && indexPath.row != 0) {
        HelpDetailCell * cell = [[HelpDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
        [cell initTitleLabWithTitle:_detailArr[indexPath.section]];
        return [cell getViewHeight];
    }
    return kScreen_Height/15;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self gerenateTablecell:tableView indexpath:indexPath];
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(UITableViewCell *)gerenateTablecell:(UITableView *)tableview indexpath:(NSIndexPath *)indexpath
{
    if (isOpen && selectIndex.section == indexpath.section && indexpath.row != 0) {
        HelpDetailCell * cell = [[HelpDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
        //cell1.titileLab = _detailArr[indexpath.section];
        [cell initTitleLabWithTitle:_detailArr[indexpath.section]];
        return cell;
        
    }else{
        UserHelperCell *cell = [tableview dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (!cell) {
            cell = [[UserHelperCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
 
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                cell.titleLabel.text = _dataArr[indexpath.section];
                
            });
        });
        
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        /**
         *  expand cell select method
         */
        if ([indexPath isEqual:selectIndex]) {
            isOpen = NO;
            [self didSelectCellRowFirstDo:NO nextDo:NO];
            selectIndex = nil;
        }else{
            if (!selectIndex) {
                selectIndex = indexPath;
               // [self setModel];
                [self didSelectCellRowFirstDo:YES nextDo:NO];
            }else{
                [self didSelectCellRowFirstDo:NO nextDo:YES];
            }
        }
        
    }else{
        /**
         *  no reaction
         */
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
{
    isOpen = firstDoInsert;
    UserHelperCell *cell = (UserHelperCell *)[self.CategoryTableView cellForRowAtIndexPath:selectIndex];
    [Helper startAnimation:cell.triangle Up:firstDoInsert complete:^{
        
    }];
    
    NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
    NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:1 inSection:selectIndex.section];
    [rowToInsert addObject:indexPathToInsert];
    
    [self.CategoryTableView beginUpdates];
    if (firstDoInsert)
    {
        [self.CategoryTableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    else
    {
        [self.CategoryTableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    
    [self.CategoryTableView endUpdates];
    
    if (nextDoInsert) {
        isOpen = YES;
        selectIndex = [self.CategoryTableView indexPathForSelectedRow];
       // [self setModel];
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
    
    if (isOpen){
        [self.CategoryTableView scrollToRowAtIndexPath:selectIndex atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}
@end
