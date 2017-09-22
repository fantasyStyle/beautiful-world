//
//  StudyByOneselfCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/12.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "StudyByOneselfCell.h"
#import "Masonry.h"
@implementation StudyByOneselfCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.icon];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.triangle];
        [self.contentView addSubview:self.payCountLab];
        [self.contentView addSubview:self.jifen];
    }
    return self;
}
-(UILabel *)titleLab
{
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = [UIFont systemFontOfSize:14];
//        _titleLab.backgroundColor = [UIColor redColor];
        _titleLab.textColor = [UIColor darkGrayColor];

    }
    return _titleLab;
}
-(UILabel *)payCountLab
{
    if (_payCountLab == nil) {
        _payCountLab = [[UILabel alloc] init];
        _payCountLab.textAlignment = NSTextAlignmentLeft;
        _payCountLab.font = [UIFont systemFontOfSize:15];
        _payCountLab.textColor = [UIColor darkGrayColor];
       // _payCountLab.backgroundColor = [UIColor greenColor];
        _payCountLab.text = @"X5";
    }
    return _payCountLab;
}

-(UIImageView *)triangle
{
    if (_triangle == nil) {
        _triangle = [[UIImageView alloc] init];
        _triangle.image = [UIImage imageNamed:@"向右"];
    }
    return _triangle;
}
-(UIImageView *)icon
{
    if (_icon == nil) {
        _icon = [[UIImageView alloc] init];
       _icon.image = [UIImage imageNamed:@"Q_03"];
    }
    return _icon;
}
-(UIImageView *)jifen
{
    if (_jifen == nil) {
        _jifen = [[UIImageView alloc] init];
        _jifen.image = [UIImage imageNamed:@"jifen_04"];
    }
    return _jifen;
}

-(void)layoutSubviews
{
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_left).offset(30);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    
    [self.payCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-35);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    [self.jifen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.payCountLab.mas_right).offset(-45);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];

    

    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.triangle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
