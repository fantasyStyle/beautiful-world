//
//  NewWorldCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/8.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "NewWorldCell.h"
#define KcellH kScreen_Height/8
@implementation NewWorldCell

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
    imaShow.frame = CGRectMake(5,5,kScreen_Width/4 ,KcellH - 10);
    
    [self addSubview:imaShow];
    
    
    imaTitleLab  = [[UILabel alloc]init];
    imaTitleLab.frame = CGRectMake(kScreen_Width/4+10, 5, kScreen_Width/4*3-30, 40);
    imaTitleLab.numberOfLines = 2;
    imaTitleLab.font = [UIFont systemFontOfSize:13];
    imaTitleLab.textColor = [UIColor darkGrayColor];
    [self addSubview:imaTitleLab];
    
    
    zanbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    zanbtn.frame = CGRectMake(imaTitleLab.x, KcellH - 25, 45, 20);
    [zanbtn addTarget:self action:@selector(zanClick) forControlEvents:UIControlEventTouchUpInside];
 
    [zanbtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [zanbtn setTitleColor:UIColorFromRGB(0xFF0026) forState:UIControlStateSelected];
    zanbtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [zanbtn setImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
    [zanbtn setImage:[UIImage imageNamed:@"点赞（选中）"] forState:UIControlStateSelected];
    [zanbtn setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [zanbtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
       [self addSubview:zanbtn];

    
   
    
//    zanLab = [[UILabel alloc]init];
//    zanLab.frame = CGRectMake(zanbtn.x +40, zanbtn.y, 30, 20);
//    zanLab.textColor = [UIColor darkGrayColor];
//    zanLab.font = [UIFont systemFontOfSize:14];
//    [self addSubview:zanLab];
    
    
    UIButton * commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commentBtn.frame = CGRectMake(zanbtn.x +80, KcellH - 25, 30, 20);
    [commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    commentBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    commentBtn.backgroundColor = RGBColor(25, 136, 204);
    [self addSubview:commentBtn];
    
    commentLab = [[UILabel alloc]init];
    commentLab.frame = CGRectMake(commentBtn.x +40, commentBtn.y, 30, 20);
    commentLab.textColor = [UIColor darkGrayColor];
    commentLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:commentLab];


}
-(void)zanClick{
    
    zanbtn.selected = YES;
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @" + 1";
    label.textColor = UIColorFromRGB(0xFF0026);
    label.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = zanbtn.frame;
    label.y = zanbtn.y - 20;
    
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
        zanbtn.transform = CGAffineTransformMakeScale(0.9, 0.9);
        [zanbtn setTitle:[NSString stringWithFormat:@"%ld",zanbtn.currentTitle.integerValue + 1] forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            zanbtn.transform = CGAffineTransformIdentity;
            zanbtn.userInteractionEnabled = NO;
        } completion:^(BOOL finished) {
            
        }];
    }];
    
    
    
}

-(void)setMyNewModel:(NewWorldModel *)myNewModel{
    imaShow.image  =LoadImageByName(myNewModel.imaName) ;
    imaTitleLab.text = myNewModel.imaTitle;
    [zanbtn setTitle:myNewModel.zanCount forState:UIControlStateNormal];     commentLab.text = myNewModel.commentCount;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
