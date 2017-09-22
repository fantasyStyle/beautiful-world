//
//  BuyRecordViewCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/17.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "BuyRecordViewCell.h"
#define kcellH kScreen_Height/7
@implementation BuyRecordViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self) {
        [self initcell];
    }
    return self;
    
}
-(void)initcell{
    imaShow = [[UIImageView alloc]init];
    imaShow.frame = CGRectMake(5, 5, kcellH - 10, kcellH - 10);
    imaShow.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imaShow];
    
    titleLab = [[UILabel alloc]init];
    titleLab.frame = CGRectMake(imaShow.frame.size.width +10, 5, kScreen_Width/3*2, 20);
    titleLab.font = font13;
    titleLab.textColor = [UIColor darkGrayColor];
    [self addSubview:titleLab];
    
    timeLab = [[UILabel alloc]init];
    timeLab.frame = CGRectMake(titleLab.x, 30, kScreen_Width/3, 20);
    timeLab.font = font13;
    timeLab.textColor = [UIColor darkGrayColor];
    [self addSubview:timeLab];
    
//    imaType = [[UIImageView alloc]init];
//    imaType.frame  = CGRectMake(titleLab.x, 55, 16, 16);
//    imaType.contentMode = UIViewContentModeScaleAspectFit;
//    [self addSubview:imaType];
    
    priceLab = [[UILabel alloc]init];
    priceLab.frame = CGRectMake(titleLab.x, 55, kScreen_Width/3*2, 20);
    
    priceLab.textColor = [UIColor redColor];
    priceLab.font = font13;
    //[self addSubview:priceLab];
    
    
}
-(void)setRecord:(RecordModel *)record{
//    imaShow.image = LoadImageByName(record.imaName);
    
    NSString * str = [NSString stringWithFormat:@"%@%@",BaseShopUrl,record.imaName];
    [imaShow sd_setImageWithURL:[NSURL URLWithString:str]];
    titleLab.text =[NSString stringWithFormat:@"饰品名称：%@",record.titleName];
    if (record.time ) {
         timeLab.text =[NSString stringWithFormat:@"交易时间：%@",record.time];
    }else{
        timeLab.hidden = YES;
    }

    if ([record.payType isEqualToString:@"0"] || [record.payType isEqualToString:@"1"]) {
        
        if ([record.payType isEqualToString:@"0"]) {
            priceLab.text =[NSString stringWithFormat:@"价格：%@金币",record.price];

        }else{
            priceLab.text =[NSString stringWithFormat:@"价格：%@钻石",record.price];

        }
       
    }else{
        priceLab.text =[NSString stringWithFormat:@"价格：%@ %@",record.price,record.payType];
    }
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
