//
//  PurchaseTableViewCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/5/4.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "PurchaseTableViewCell.h"

@implementation PurchaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setContents:(PurchaseModel *)model{
    
   // self.icon.image = [UIImage imageNamed:model.icon];
    NSString * str = [NSString stringWithFormat:@"%@%@",BaseShopUrl,model.icon];
    self.icon.contentMode = UIViewContentModeScaleAspectFit;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:LoadImageByName(@"head_wu_04")];

    self.name.text = model.title;
    self.date.text = model.date;
    self.content.text = model.detail;
    self.content.numberOfLines = 999;
    self.content.lineBreakMode = NSLineBreakByWordWrapping;
    [self.content sizeToFit];
    self.phone.text =[NSString stringWithFormat:@"联系电话: %@",model.phoneNumber];
    
}
+(CGFloat)cellHeight:(PurchaseModel *)model{
    CGFloat height = 20 + 5 + 20 + 15 + 20 + 13 + 0.5;
    CGRect   rect = [model.detail boundingRectWithSize:CGSizeMake(kScreen_Width - 80, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    height += rect.size.height;
    return height;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
