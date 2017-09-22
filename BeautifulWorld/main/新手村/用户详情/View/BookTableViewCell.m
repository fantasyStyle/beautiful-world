//
//  BookTableViewCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/7.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "BookTableViewCell.h"
#define KcellH kScreen_Height/8
@implementation BookTableViewCell

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
    imaShow  = [[UIImageView alloc]init];
    imaShow.frame = CGRectMake(5, 5, kScreen_Width/4, KcellH -10);

    [self addSubview:imaShow];
    
    
    bookNameLab  = [[UILabel alloc]init];
    bookNameLab.frame = CGRectMake(kScreen_Width/4+10, 6, kScreen_Width/4*3-30, 40);
    bookNameLab.numberOfLines = 2;
    bookNameLab.font = [UIFont systemFontOfSize:14];
    bookNameLab.textColor = [UIColor darkGrayColor];
    [self addSubview:bookNameLab];
    
    timeLab  = [[UILabel alloc]init];
    timeLab.frame = CGRectMake(bookNameLab.x, bookNameLab.y+42, kScreen_Width/4, 20);
    timeLab.font = [UIFont systemFontOfSize:12];
    timeLab.textColor = [UIColor darkGrayColor];
    [self addSubview:timeLab];
    
    inspectBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    inspectBtn.frame = CGRectMake(kScreen_Width-50, bookNameLab.y+40, 40, 23);
    inspectBtn.backgroundColor = RGBColor(25, 136, 204);
    inspectBtn.layer.masksToBounds = YES;
    inspectBtn.layer.cornerRadius = 5;
    [inspectBtn setTitle:@"详情" forState:UIControlStateNormal];
    inspectBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:inspectBtn];

    
}
-(void)setUserBook:(BookUserModel *)userBook{
    imaShow.image = LoadImageByName(userBook.imaName);
    bookNameLab.text = userBook.bookName;
    timeLab.text = userBook.time;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
