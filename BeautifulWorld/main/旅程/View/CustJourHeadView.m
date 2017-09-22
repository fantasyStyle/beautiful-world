//
//  CustJourHeadView.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/10.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "CustJourHeadView.h"

@implementation CustJourHeadView


-(id)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreen_Width, 30);
        self.backgroundColor = [UIColor whiteColor];
       _lineView  = [[UIImageView alloc]init];
        _lineView.frame = CGRectMake(5, 5, 3, 20);
 
        [self addSubview:_lineView];
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.frame =CGRectMake(20, 5, 100, 20);
       
        _titleLab.font = [UIFont systemFontOfSize:15];

        [self addSubview:_titleLab];
        
        
        _moreIma = [[UIImageView alloc]init];
        _moreIma.frame = CGRectMake(kScreen_Width-30, 5, 20, 20);
        _moreIma.image = LoadImageByName(@"moreIma");
//        [_moreIma addTapTraget:self withAction:@selector(onMore)];
        [self addSubview:_moreIma];


    }
    
    return self;
}

@end
