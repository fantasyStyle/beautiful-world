//
//  addressViewController.m
//  gowuche
//
//  Created by 上海点硕 on 16/4/19.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//

#import "addressViewController.h"
#import "paperViewCell.h"
#import "addLocationViewController.h"
#import "locationModel.h"

@interface addressViewController ()<UITableViewDelegate,UITableViewDataSource,passModelDelegate>

@end

@implementation addressViewController
{
    NSMutableArray *dataArray;
    UITableView *tableview;
    locationModel *model;
    UIView *footView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataArray = [NSMutableArray array];
    
    self.view.backgroundColor= [UIColor whiteColor];
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height+64) style:UITableViewStyleGrouped];
    
    [self.view addSubview:tableview];
    tableview.rowHeight= 134;
    tableview.delegate= self;
    tableview.dataSource= self;
    footView = [[UIView alloc] init];
    footView.frame= CGRectMake(0, 0, self.view.bounds.size.width, 54);
    footView.backgroundColor= [UIColor colorWithRed:235/250.0 green:235/250.0 blue:241/250.0 alpha:1];
    UIButton *addlocationBtn  = [[UIButton alloc] init];
     addlocationBtn.frame= CGRectMake(0, 18, self.view.bounds.size.width, 36);
     addlocationBtn.backgroundColor= [UIColor whiteColor];
    [addlocationBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    
    [addlocationBtn setTitle:@"新增收货地址" forState:UIControlStateNormal];
    [addlocationBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
     addlocationBtn.titleLabel.font=[UIFont systemFontOfSize:13];
     addlocationBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [addlocationBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -250, 0, 0)];
    [addlocationBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,-200, 0, 10)];
    [footView addSubview:addlocationBtn];
    [addlocationBtn addTarget:self action:@selector(sendLocation) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *line = [[UILabel alloc] init];
    line.frame= CGRectMake(0, 18, self.view.bounds.size.width, 1);
    line.backgroundColor= [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
    [footView addSubview:line];
    UILabel *line1 = [[UILabel alloc] init];
    line1.frame= CGRectMake(0, 54, self.view.bounds.size.width, 1);
    line1.backgroundColor= [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
    [footView addSubview:line1];
     tableview.tableFooterView=footView;
   
   
   
    
}

- (void)sendLocation
{
    addLocationViewController * vc = [[addLocationViewController alloc] init];
    vc.delegate= self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
   
    return 0.0000001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        
        return 0.0000001;
    }
    
    return 12;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cell";
    // 自定义cell
    paperViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil)
    {
        cell= [[[NSBundle mainBundle]loadNibNamed:@"paperViewCell" owner:nil options:nil] firstObject];
        if (indexPath.section==2) {
            cell.name.text=model.name;
            cell.tell.text= model.tell;
            cell.dizhi.text= model.dizhi;
            
        }
        
    }
    
    return cell;
    
}
- (void)passModel:(NSString *)name andtell:(NSString *)tell anddizhi:(NSString *)detailLocation
{
    
    model = [[locationModel alloc] init];
    model.name= name;
    model.tell= tell;
    model.dizhi= detailLocation;
      [dataArray addObject:model];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:dataArray.count-1 inSection:0];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableview insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    });
  
 
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

@end
