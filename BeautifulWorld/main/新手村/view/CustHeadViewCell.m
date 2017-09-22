//
//  CustHeadViewCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/8.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "CustHeadViewCell.h"
#define kheadH kScreen_Height/18
@implementation CustHeadViewCell
-(id)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreen_Width, kheadH);
        self.backgroundColor = [UIColor whiteColor];
         [self initViewWithColor];
        
            }

    return self;
}

-(void)initViewWithColor{

   
    _backIma = [[UIImageView alloc]init];
    _backIma.frame = CGRectMake(20, 8, 2, kheadH-16);
    [self addSubview:_backIma];
    
    _iconIma = [[UIImageView alloc]init];
    _iconIma.frame =CGRectMake(40, 10, 20, 20);
    [self addSubview:_iconIma];
    
    _headTitle = [[UILabel alloc]init];
    _headTitle.frame = CGRectMake(70, 0, kScreen_Width/2, kheadH);
    if (iPhone5) {
        _headTitle.frame = CGRectMake(10, 0, kScreen_Width/4-10, kheadH);
        _headTitle.font = [UIFont systemFontOfSize:13];
    }
    CGAffineTransform matrix = CGAffineTransformMake(1, 0, tanf(-15 * (CGFloat)M_PI / 180), 1, 0, 0);
    _headTitle.transform = matrix;
    [self addSubview:_headTitle];
    
    UIImageView * line = [[UIImageView alloc]initWithFrame:CGRectMake(0, kheadH-1, kScreen_Width, 1)];
    line.image = LoadImageByName(@"line_02");
    [self addSubview:line];

    _moreTitle = [[UILabel alloc]init];
    _moreTitle.frame = CGRectMake(kScreen_Width-50, (kheadH-20)/2, 40, 20);
    _moreTitle.textColor  = [UIColor darkGrayColor];
    _moreTitle.font = font14;
    _moreTitle.textAlignment = NSTextAlignmentCenter;
    _moreTitle.text = @"全部";
    [self addSubview:_moreTitle];
                                  
                                  }

@end
