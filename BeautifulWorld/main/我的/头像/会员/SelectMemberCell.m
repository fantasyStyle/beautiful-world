//
//  SelectMemberCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/23.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "SelectMemberCell.h"
#define memberH kScreen_Height/14
@implementation SelectMemberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        isSelected = NO;
        [self inirCell];
    }
    return self;
}
-(void)inirCell{
    UILabel * lab = [[UILabel alloc]init];
    lab.text =@"开通服务";
//    lab.font = font15;
    lab.textColor = [UIColor darkGrayColor];
    lab.frame = CGRectMake(15, (memberH - 20)/2, 100, 20);
    [self addSubview:lab];
    
    
    _vipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _vipBtn.frame =CGRectMake(kScreen_Width/4+20, (memberH - 24)/2, kScreen_Width/6, 24);
    _vipBtn.titleLabel.font = font13;
    _vipBtn.layer.masksToBounds = YES;
    _vipBtn.layer.cornerRadius = 10;
    _vipBtn.tag =1;
    _vipBtn.selected = YES;
    self.selectedBtn = _vipBtn;
    [_vipBtn setBackgroundImage:LoadImageByName(@"按钮（未选中）") forState:UIControlStateNormal];
    [_vipBtn setBackgroundImage:LoadImageByName(@"按钮（选中）") forState:UIControlStateSelected];
    [_vipBtn setTitle:@"普通会员" forState:UIControlStateNormal];
    _vipBtn.backgroundColor = [UIColor grayColor];
    [_vipBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_vipBtn];
    
    _superBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _superBtn.frame =CGRectMake(_vipBtn.x + _vipBtn.frame.size.width +40 , (memberH - 24)/2, kScreen_Width/6, 24);
    [_superBtn setBackgroundImage:LoadImageByName(@"按钮（未选中）") forState:UIControlStateNormal];
    [_superBtn setBackgroundImage:LoadImageByName(@"按钮（选中）") forState:UIControlStateSelected];

    _superBtn.titleLabel.font = font13;
    _superBtn.layer.masksToBounds = YES;
    _superBtn.layer.cornerRadius = 10;
    _superBtn.tag =2;
    _superBtn.backgroundColor = [UIColor grayColor];
    [_superBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];

    [_superBtn setTitle:@"超级会员" forState:UIControlStateNormal];
    [self addSubview:_superBtn];
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
        if ([self.memberDelegate respondsToSelector:@selector(onSelectVIPMember)]) {
            [self.memberDelegate onSelectVIPMember];
        }
    }
        else{
            if ([self.memberDelegate respondsToSelector:@selector(onSelectSuperMember)]) {
                [self.memberDelegate onSelectSuperMember];
            }
        }

    
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
