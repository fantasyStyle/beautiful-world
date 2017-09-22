//
//  CYAlertView.m
//  CYAlertView
//
//  Created by A_Dirt on 16/5/5.
//  Copyright © 2016年 A_Dirt. All rights reserved.
//

#import "CYAlertView.h"


@implementation CYAlertView
{
    __weak IBOutlet UIView *alertView;
    __weak IBOutlet UILabel *titleLab;
    __weak IBOutlet UILabel *contenLab;
    __weak IBOutlet UIButton *cancelBtn;
    __weak IBOutlet UIButton *determineBtn;

}

- (void)awakeFromNib {
    
    alertView.layer.cornerRadius = 5;
    alertView.layer.masksToBounds = YES;
    
}


- (void)drawRect:(CGRect)rect {
    if (self.title.length > 0) {
        titleLab.text = self.title;
    }
    if (self.content.length >0) {
        contenLab.text = self.content;
    }
}


- (void)show
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];

    [window addSubview:self];
    
    self.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.center = window.center;
    
}
- (IBAction)buttonClick:(UIButton *)sender {

    if ([sender.titleLabel.text isEqualToString:@"确定"]){
        if (self.delegate) {
            [self.delegate alertView:self clickedButtonAtIndex:1];
            [self removeFromSuperview];
        }
    }else{
        if (self.delegate) {
            [self.delegate alertView:self clickedButtonAtIndex:0];
            [self removeFromSuperview];
        }

        
        
       // [self removeFromSuperview];

    }
    
    }

@end
