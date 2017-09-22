//
//  CommunityLiveCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/29.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "CommunityLiveCell.h"
#define cellH kScreen_Height/8
@implementation CommunityLiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCerll];
    }
    return self;
}
-(void)initCerll{
    imaShow = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, cellH-16, cellH-16)];
    imaShow.layer.masksToBounds = YES;
    imaShow.layer.cornerRadius = (cellH - 16)/2;
    [self addSubview:imaShow];
    
    NameLab = [[UILabel alloc]initWithFrame:CGRectMake(cellH, 10, 100, 20)];
    NameLab.font = font15;
    NameLab.textColor = [UIColor darkGrayColor];
    [self addSubview:NameLab];
    
    sexIma = [[UIImageView alloc]init];
    sexIma.frame = CGRectMake(cellH, 35, 18, 18);
    [self addSubview:sexIma];
    
    contentLab = [[UILabel alloc]initWithFrame:CGRectMake(NameLab.x, cellH-25,kScreen_Width-cellH, 20)];
    contentLab.textColor = [UIColor grayColor];
    contentLab.font = font13;
    [self addSubview:contentLab];
}
-(void)setLiveModel:(CommunityLiveModel *)liveModel{
    imaShow.image = LoadImageByName(liveModel.imaName);
    NameLab.text = liveModel.titleName;
    contentLab.text = liveModel.content;
    sexIma.image = LoadImageByName(liveModel.sex);
    if (liveModel.style1) {
        styleIma1 = [[UIImageView alloc]initWithImage:LoadImageByName (liveModel.style1)];
        styleIma1.frame = CGRectMake(sexIma.x+30, sexIma.y, 30, 18);
        [self addSubview:styleIma1];
        if (liveModel.style2) {
            styleIma2 = [[UIImageView alloc]initWithImage:LoadImageByName(liveModel.style2)];
             styleIma2.frame = CGRectMake(styleIma1.x+35, sexIma.y, 30, 18);
            [self addSubview:styleIma2];
            
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
