//
//  ResourcesBuyTableViewCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/5/5.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "ResourcesBuyTableViewCell.h"
#define khCell kScreen_Height/10
@implementation ResourcesBuyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCell];
    }
    return self;
}
-(void)initCell{
    titleLab = [[UILabel alloc]initWithFrame:CGRectMake(20, (khCell-20)/2, 40, 20)];
    //titleLab.textColor = [UIColor darkGrayColor];
    titleLab.font = [UIFont systemFontOfSize:18];
    titleLab.text = @"我的";
    [self addSubview:titleLab];
    
    _payIcon = [[UIImageView alloc]init];
    _payIcon.frame = CGRectMake(titleLab.x+45, (khCell-30)/2, 39, 30);
    [self addSubview:_payIcon];
    
    iconCount = [[UILabel alloc]init];
    iconCount.frame = CGRectMake(_payIcon.x+45, (khCell-20)/2, 100, 20);
    iconCount.font = font15;
    iconCount.textColor = [UIColor darkGrayColor];
    [self addSubview:iconCount];
    
    _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _payBtn.frame = CGRectMake(kScreen_Width-80, khCell/4, 70, khCell/2);
    _payBtn.layer.masksToBounds = YES;
    _payBtn.layer.cornerRadius = 5;
    [_payBtn setUserInteractionEnabled:NO];
    _payBtn.backgroundColor = RGBColor(249, 79, 7);
    //[payBtn setTitle:@"购买" forState:UIControlStateNormal];
    [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_payBtn];
    
    
    
}
-(void)setBuyModel:(ResourcesBuyModel *)buyModel{
    iconCount.text = [NSString stringWithFormat:@": x%@",buyModel.count];
//    payIcon.image = LoadImageByName(buyModel.icon);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
