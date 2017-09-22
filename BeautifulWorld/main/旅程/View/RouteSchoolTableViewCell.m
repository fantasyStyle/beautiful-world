//
//  RouteSchoolTableViewCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/26.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "RouteSchoolTableViewCell.h"

@implementation RouteSchoolTableViewCell

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
    routeIma = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width/3, kScreen_Height/5)];
    routeIma.transform = CGAffineTransformMakeRotation(M_PI_2);

    [self addSubview:routeIma];
}
-(void)setRouteModel:(RouteModel *)routeModel{
//    routeIma.image = LoadImageByName(routeModel.imaName);
    NSString * str = [NSString stringWithFormat:@"%@%@",BaseRouteSchoolUrl,routeModel.imaName];
    [routeIma sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:LoadImageByName(@"新世界5")];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
