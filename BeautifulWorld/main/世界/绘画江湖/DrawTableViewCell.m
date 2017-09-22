//
//  DrawTableViewCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/5/2.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "DrawTableViewCell.h"
#import "DrawPicCell.h"
static NSString *cellIdentifier = @"cellIdentifier";
@implementation DrawTableViewCell

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
    _myTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/6) style:UITableViewStyleGrouped];
    _myTabelView.delegate = self;
    _myTabelView.dataSource = self;
    _myTabelView.bounces=NO;
    _myTabelView.showsVerticalScrollIndicator=NO; //指示条
    
    _myTabelView.transform  = CGAffineTransformMakeRotation(-M_PI_2);
    
    _myTabelView.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height/6);
    _myTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self addSubview:_myTabelView];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (kScreen_Width-15)/2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.classModelArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DrawPicCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[DrawPicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   // ReUserModel * model = [[ReUserModel alloc]init];
    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
     cell.reUserModel = _classModelArray[indexPath.section];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ReUserModel * model = self.classModelArray[indexPath.section];
    [self.drawDelegate tapDraw:model andIntag:indexPath.section];
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
