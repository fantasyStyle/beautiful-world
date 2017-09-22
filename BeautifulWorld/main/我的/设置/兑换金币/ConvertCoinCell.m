//
//  ConvertCoinCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/23.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "ConvertCoinCell.h"
#define  kcoinH kScreen_Height/12
@implementation ConvertCoinCell

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
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(15, (kcoinH-20)/2, 100, 20)];
    label.text = @"兑换金币";
    [self addSubview:label];
    
    _theTextField = [[UITextField alloc]init];
    _theTextField.placeholder = @"请输入兑换个数";
    _theTextField.frame = CGRectMake(120, label.y, 150, 20);
    [self addSubview:_theTextField];
    
    UIButton * convert = [UIButton buttonWithType:UIButtonTypeCustom];
    convert.frame = CGRectMake(kScreen_Width-50, (kcoinH-23)/2, 40, 23);
    convert.backgroundColor =[UIColor brownColor];
    [convert setTitle:@"兑换" forState:UIControlStateNormal];
    convert.titleLabel.font = font13;
    convert.layer.masksToBounds = YES;
    convert.layer.cornerRadius = 5;
    [self addSubview:convert];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
