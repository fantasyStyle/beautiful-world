//
//  UIView+UIViewTap_Extension.m
//  IOS_H_ProjectDemo
//
//  Created by Apple on 16/4/2.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UIView+UIViewTap_Extension.h"

@implementation UIView (UIViewTap_Extension)

-(void)addTapTraget:(id)traget withAction:(SEL)sel
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:traget action:sel];
    [self addGestureRecognizer:tap];
    self.userInteractionEnabled = YES;
}

@end
