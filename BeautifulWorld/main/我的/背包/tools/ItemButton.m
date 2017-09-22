//
//  ItemButton.m
//  趣旅游
//
//  Created by 千锋 on 16/2/26.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "ItemButton.h"

@implementation ItemButton
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self.titleLabel setFont:[UIFont systemFontOfSize:20]];
        
    }
    return self;
}
-(void)setIsRecord:(BOOL)isRecord{
    _isRecord=isRecord;
    
    [self setNeedsDisplay];
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (self.isRecord) {
        [[UIColor colorWithRed:110/255.0 green:205/255.0 blue:215/255.0 alpha:1]set];
        [self setTitleColor:[UIColor colorWithRed:110/255.0 green:205/255.0 blue:215/255.0 alpha:1] forState:UIControlStateNormal];
        

        UIRectFill(CGRectMake(20, self.bounds.size.height-2, self.bounds.size.width-40,2));
    }
    else {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }

}
@end
