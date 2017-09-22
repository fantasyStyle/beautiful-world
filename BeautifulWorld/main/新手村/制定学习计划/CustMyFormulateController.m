//
//  CustMyFormulateController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/20.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "CustMyFormulateController.h"
#import "StudyDetailCell.h"
#import "StudyByOneselfCell.h"
#import "Helper.h"
static NSString *CellIdentifier2 = @"cellidentifer2";

static NSString *CellIdentifier1 = @"cellidentifer1";
@interface CustMyFormulateController ()<UITableViewDelegate,UITableViewDataSource>{
    NSIndexPath *selectIndex;
    BOOL isOpen;
    

}
@property (nonatomic,strong)UITableView * myTab;
@property (nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic,strong)NSMutableArray * detailArr;
@end

@implementation CustMyFormulateController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(230, 231, 234);
    [self loadData];
    [self creatTable];

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
-(void)loadData{
    self.dataArr = [NSMutableArray arrayWithObjects:@"三原色是指？",@"素描的五大调子是指？",@"油画有哪些画派",@"三庭五眼是指？",@"人体比比例是？", nil];
    
}
-(void)creatTable{
    _myTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-NavBar_Height-StatusBar_Height) style:UITableViewStyleGrouped];
    _myTab.delegate = self;
    _myTab.dataSource = self;
    [self.view addSubview:_myTab];
    UIView * head = [[UIView alloc]init];
    head.frame = CGRectMake(0, 0, kScreen_Width, 40);
    head.backgroundColor = [UIColor whiteColor];
    UILabel * lab = [[UILabel alloc]init];
    lab.frame = CGRectMake(15, 10, kScreen_Width-20, 20);
    lab.text = @"您已经看完了视频，现在回答问题赢得积分";
    lab.textColor = [UIColor darkGrayColor];
    lab.font = font14;
    [head addSubview:lab];
    
    if (_isShowHeadView == YES) {
        _myTab.tableHeaderView = head;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (isOpen && selectIndex.section == section) {
        
        return 2;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isOpen && selectIndex.section == indexPath.section && indexPath.row != 0) {
//        HelpDetailCell * cell = [[HelpDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
//        [cell initTitleLabWithTitle:_detailArr[indexPath.section]];
        return 90;
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
        StudyDetailCell * cell = [[StudyDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
        //cell1.titileLab = _detailArr[indexpath.section];
       // [cell initTitleLabWithTitle:_detailArr[indexpath.section]];
        return cell;
        
    }else{
        StudyByOneselfCell *cell = [tableview dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (!cell) {
            cell = [[StudyByOneselfCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                cell.titleLab.text = _dataArr[indexpath.section];
                
            });
        });
        
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
    StudyByOneselfCell *cell = (StudyByOneselfCell *)[self.myTab cellForRowAtIndexPath:selectIndex];
    [Helper startAnimation:cell.triangle Up:firstDoInsert complete:^{
        
    }];
    
    NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
    NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:1 inSection:selectIndex.section];
    [rowToInsert addObject:indexPathToInsert];
    
    [self.myTab beginUpdates];
    if (firstDoInsert)
    {
        [self.myTab insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    else
    {
        [self.myTab deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    
    [self.myTab endUpdates];
    
    if (nextDoInsert) {
        isOpen = YES;
        selectIndex = [self.myTab indexPathForSelectedRow];
        // [self setModel];
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
    
    if (isOpen){
        [self.myTab scrollToRowAtIndexPath:selectIndex atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

@end
