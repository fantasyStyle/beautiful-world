//
//  FTCustomField.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/2/28.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "FTCustomField.h"
#import "NSAttributedString+Extension.h"
@implementation FTCustomField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
// 设置Placeholder
- (void)customWithPlaceholder: (NSString *)placeholder color: (UIColor *)color font: (UIFont *)font {

// 方法一：修改attributedPlaceholder;
    self.attributedPlaceholder = [NSAttributedString attributedStringWithString:placeholder color:color font:font];
}

// 重写这个方法是为了使Placeholder居中，如果不写会出现类似于下图中的效果，文字稍微偏上了一些
- (void)drawPlaceholderInRect:(CGRect)rect {
    [super drawPlaceholderInRect:CGRectMake(10, 15 , 0, 0)];
}
@end
