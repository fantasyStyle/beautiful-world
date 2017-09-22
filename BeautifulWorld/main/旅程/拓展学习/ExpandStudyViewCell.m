//
//  ExpandStudyViewCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/1.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "ExpandStudyViewCell.h"

@implementation ExpandStudyViewCell

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
//    CGFloat Kwidth = (kScreen_Width - 15*3)/2;
    UIImageView * ima1 = [[UIImageView alloc]init];
    ima1.frame = CGRectMake(15, 8,kScreen_Width-30, kScreen_Height/4-16);
    ima1.image = LoadImageByName(@"tu_03");
    [self addSubview:ima1];
    
    UIImageView * ima2 =[[UIImageView alloc]init];
    ima2.frame = CGRectMake(0, 0, kScreen_Width/6, kScreen_Width/6);
    ima2.image = LoadImageByName(@"play_03");
    ima2.center = ima1.center;
    [self addSubview:ima2];

    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
