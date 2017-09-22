//
//  HappyGardenCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/1.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "HappyGardenCell.h"

@implementation HappyGardenCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCell];
    }
    return self;
}
-(void)initCell{
     imaShow = [[UIImageView alloc]init];
    imaShow.frame = CGRectMake(10, 5, kScreen_Width-20, kScreen_Height/4 - 10);
    
  
    [self addSubview:imaShow];
}
-(void)setGardenModel:(HappyGardenModel *)gardenModel{
    imaShow.image = LoadImageByName(gardenModel.happyIma);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
