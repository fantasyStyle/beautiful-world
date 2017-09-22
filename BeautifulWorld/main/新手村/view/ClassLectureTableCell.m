//
//  ClassLectureTableCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/1.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "ClassLectureTableCell.h"
#import "After-classLetureCell.h"
static NSString *cellIdentifier = @"cellIdentifier";
@implementation ClassLectureTableCell

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
    _myTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/8*3) style:UITableViewStylePlain];
    _myTabelView.delegate = self;
    _myTabelView.dataSource = self;
    _myTabelView.bounces=NO;
    _myTabelView.scrollEnabled=NO;
    _myTabelView.showsVerticalScrollIndicator=NO; //指示条
    [self addSubview:_myTabelView];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreen_Height/8;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.classModelArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    After_classLetureCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[After_classLetureCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.myClass = self.classModelArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ClassLectureModel * classID = self.classModelArray[indexPath.row];
    [self.classDelegate TapClassCellDelegate:classID AndINtag:indexPath.row];
    NSLog(@"课外讲堂%ld--%@",indexPath.row,classID);
}


@end
