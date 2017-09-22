//
//  StudyRankTableViewCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/6.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "StudyRankTableViewCell.h"
#define rankH kScreen_Height/10
@implementation StudyRankTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style  reuseIdentifier:reuseIdentifier];
    if (self) {
//        if (self.tag < 3 ) {
            [self initRankIma];
//        }
//        else{
         //  [self initRankLab];
//        }
       
    }
    return self;
    
}
-(void)initRankIma{
    _rankIma = [[UIImageView alloc]init];
    _rankIma.frame = CGRectMake(10, 15, 20, rankH-30);
    [self addSubview:_rankIma];
    
    [self initRankLab];
    

    
    
}
-(void)initRankLab{
    _rankLab = [[UILabel alloc]init];
    _rankLab.frame = CGRectMake(10, 15, 20, rankH-30);
    _rankLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_rankLab];
    
    [self initView];
}
-(void)initView{
    iconIma = [[UIImageView alloc]init];
    iconIma.frame = CGRectMake(40, 8, rankH - 20, rankH - 16);
    [self addSubview:iconIma];
    
    
    sexIma = [[UIImageView alloc]init];
    sexIma.frame = CGRectMake(iconIma.x+iconIma.frame.size.width +10,(rankH-50)/2 , 20, 20);
    
    [self addSubview:sexIma];
    
    nameLab = [[UILabel alloc]init];
    nameLab.frame = CGRectMake(sexIma.x+25, sexIma.y, 50, 20);
    nameLab.textColor = [UIColor darkGrayColor];
    nameLab.font = font15;
    [self addSubview:nameLab]
    ;
    
    gradeLab = [[UILabel alloc]init];
    gradeLab.frame = CGRectMake(nameLab.x+nameLab.frame.size.width, nameLab.y, 50, 20);
    gradeLab.textColor =[UIColor darkGrayColor];
    gradeLab.font = font15;
    [self addSubview:gradeLab];
    

}
-(void)setRankModel:(StudyRankModel *)rankModel{
    iconIma.image = LoadImageByName(rankModel.personIcon);
    sexIma.image = LoadImageByName(rankModel.sex);
    nameLab.text = rankModel.personName;
    gradeLab.text = [NSString stringWithFormat:@"lv:%@",rankModel.grade];
    CGFloat styleW = 35;
    CGFloat margin = 10;
    for (int i =0; i<rankModel.styleArr.count; i++) {
        styleIma = [[UIImageView alloc]init];
        styleIma.frame = CGRectMake(sexIma.x+(styleW+margin)*i, sexIma.y+25, styleW, 20);
        styleIma.image = LoadImageByName(rankModel.styleArr[i]);
        
        
        [self addSubview:styleIma];    }

}
@end
