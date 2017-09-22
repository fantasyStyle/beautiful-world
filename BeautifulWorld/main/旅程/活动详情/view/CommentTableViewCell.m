//
//  CommentTableViewCell.m
//  demo
//
//  Created by yuanju002 on 16/9/23.
//  Copyright © 2016年 yuanju001. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.zan setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.zan setTitleColor:UIColorFromRGB(0xFF0026) forState:UIControlStateSelected];
    [self.zan setImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
    [self.zan setImage:[UIImage imageNamed:@"点赞（选中）"] forState:UIControlStateSelected];
    [self.zan setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [self.zan setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    self.icon.layer.cornerRadius = 25;
    self.icon.layer.masksToBounds = YES;
    // Initialization code
}
-(void)setContents:(commentModel *)model{
    
//    self.icon.image = [UIImage imageNamed:model.icon];
    NSString * str = [NSString stringWithFormat:@"%@%@",BaseShopUrl,model.icon];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:str]];

    self.name.text = model.title;
    self.date.text = model.date;
    self.content.text = model.detail;
    self.content.numberOfLines = 999;
    self.content.lineBreakMode = NSLineBreakByWordWrapping;
    [self.content sizeToFit];
    [self.zan setTitle:model.number forState:UIControlStateNormal];
    
}
+(CGFloat)cellHeight:(commentModel *)model{
    CGFloat height = 20 + 5 + 20 + 15 + 20 + 13 + 0.5;
    CGRect   rect = [model.detail boundingRectWithSize:CGSizeMake(kScreen_Width - 80, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    height += rect.size.height;
    return height;
}
- (IBAction)pressZan:(id)sender {

    self.zan.selected = YES;
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @" + 1";
    label.textColor = UIColorFromRGB(0xFF0026);
    label.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = self.zan.frame;
    label.y = self.zan.y - 20;
    
    label.transform = CGAffineTransformMakeScale(0.2, 0.2);
    label.alpha = 0.0;
    [UIView animateWithDuration:0.2 animations:^{
        label.transform = CGAffineTransformMakeScale(1.2, 1.2);
        label.alpha = 1.0f;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [label removeFromSuperview];
        });
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.zan.transform = CGAffineTransformMakeScale(0.9, 0.9);
        [self.zan setTitle:[NSString stringWithFormat:@"%ld",self.zan.currentTitle.integerValue + 1] forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.zan.transform = CGAffineTransformIdentity;
            self.zan.userInteractionEnabled = NO;
        } completion:^(BOOL finished) {
            
        }];
    }];
    
    
    
    [self.delegate pressZan:self.zan.currentTitle];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
