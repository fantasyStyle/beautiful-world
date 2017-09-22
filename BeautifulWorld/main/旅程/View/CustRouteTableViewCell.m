//
//  CustRouteTableViewCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/26.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "CustRouteTableViewCell.h"
#import "RouteSchoolTableViewCell.h"
static NSString *cellIdentifier = @"cellIdentifier";
@implementation CustRouteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self initCell];
        
        
    }
    
    return self;
}
-(void)initCell{
    _myTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/8*3) style:UITableViewStyleGrouped];
    _myTabelView.delegate = self;
    _myTabelView.dataSource = self;
    _myTabelView.bounces=NO;
    _myTabelView.showsVerticalScrollIndicator=NO; //指示条

    _myTabelView.transform  = CGAffineTransformMakeRotation(-M_PI_2);
    
    _myTabelView.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height/5);
    _myTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self addSubview:_myTabelView];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreen_Width/3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _classModelArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RouteSchoolTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[RouteSchoolTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.routeModel = _classModelArray[indexPath.section];
        return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RouteModel * model = self.classModelArray[indexPath.section];
    [self.routeDelegate tapRoute:model andIntag:indexPath.section];
      NSLog(@"光明学院%ld--%@",indexPath.section ,model);
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
