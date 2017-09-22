//
//  NSAttributedString+Extension.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/2/28.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "NSAttributedString+Extension.h"

@implementation NSAttributedString (Extension)
+ (NSAttributedString *)attributedStringWithString:(NSString *)string color:(UIColor *)color font:(UIFont *)font {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = color;
    attrs[NSFontAttributeName] = font;
    NSAttributedString *attributedStr = [[NSAttributedString alloc] initWithString:string attributes:attrs];
    return attributedStr;
}
@end
