//
//  StudyDetailCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/12.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "StudyDetailCell.h"

@implementation StudyDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         isSelected = NO;
        [self initView];
    }
    return self;
    
}
-(void)initView{
    _selectBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _selectBtn1.frame =CGRectMake(kScreen_Width/6,15, 20, 20);
    _selectBtn1.tag =1;
    _selectBtn1.selected = YES;
    self.selectedBtn = _selectBtn1;
    [_selectBtn1 setBackgroundImage:LoadImageByName(@"A_01_03") forState:UIControlStateNormal];
    [_selectBtn1 setBackgroundImage:LoadImageByName(@"A_02_03") forState:UIControlStateSelected];

    [_selectBtn1 addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_selectBtn1];
    
    
    _selectLab1 = [[UILabel alloc]init];
    _selectLab1.frame = CGRectMake(_selectBtn1.x+30, 15, 100, 20);
    _selectLab1.text = @"红黄蓝";
    _selectLab1.textColor = [UIColor darkGrayColor];
    _selectLab1.font = font14;
    [self addSubview:_selectLab1];
    
    _selectBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _selectBtn2.frame =CGRectMake(kScreen_Width/3*2, 15, 20, 20);
    [_selectBtn2 setBackgroundImage:LoadImageByName(@"A_01_03") forState:UIControlStateNormal];
    [_selectBtn2 setBackgroundImage:LoadImageByName(@"A_02_03") forState:UIControlStateSelected];
    _selectBtn2.tag =2;
    [_selectBtn2 addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_selectBtn2];
    
    
    _selectLab2 = [[UILabel alloc]init];
    _selectLab2.frame = CGRectMake(_selectBtn2.x+30, 15, 100, 20);
    _selectLab2.text = @"红黄绿";
    _selectLab2.textColor = [UIColor darkGrayColor];
    _selectLab2.font = font14;
    [self addSubview:_selectLab2];
    
    _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _submitBtn.frame = CGRectMake(kScreen_Width/4, 50, kScreen_Width/2, 30);
    _submitBtn.backgroundColor = RGBColor(50, 158, 225);
    [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 5;
    [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_submitBtn];
}
-(void)onClick:(UIButton *)sender{
    
    if (sender != self.selectedBtn) {
        self.selectedBtn.selected = NO;
        self.selectedBtn = sender;
        
        
    }
    self.selectedBtn.selected = YES;
    NSLog(@"选中的是第%ld",sender.tag);
    
    //    NSString * str = @"VIP会员：每月定价8元。在购买期限内免费使用部分头像、边框和皮肤。";
    //    [[NSNotificationCenter defaultCenter]postNotificationName:@"member" object:str userInfo:nil];
    
    
    if (sender.tag ==1) {
//        if ([self.memberDelegate respondsToSelector:@selector(onSelectVIPMember)]) {
//            [self.memberDelegate onSelectVIPMember];
//        }
    }
    else{
//        if ([self.memberDelegate respondsToSelector:@selector(onSelectSuperMember)]) {
//            [self.memberDelegate onSelectSuperMember];
//        }
    }
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
