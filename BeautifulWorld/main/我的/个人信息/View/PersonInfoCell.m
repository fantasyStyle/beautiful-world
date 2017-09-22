//
//  PersonInfoCell.m
//  demo
//
//  Created by yuanju001 on 16/9/21.
//  Copyright © 2016年 yuanju001. All rights reserved.
//

#import "PersonInfoCell.h"

@implementation PersonInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatIcon];
    }
    return self;
}
-(void)creatIcon{
    _iconPerson =[[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width/3*2 + kScreen_Width/15, (kScreen_Height / 10 - kScreen_Height/12)/2, kScreen_Height/12, kScreen_Height/12)];
    _iconPerson.layer.cornerRadius = kScreen_Height/24;
    _iconPerson.layer.masksToBounds=YES;
    _iconPerson.contentMode = UIViewContentModeScaleAspectFit;
    
  
    [self addSubview:_iconPerson];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
