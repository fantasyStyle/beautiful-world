//
//  CYAlertView.h
//  CYAlertView
//
//  Created by A_Dirt on 16/5/5.
//  Copyright © 2016年 A_Dirt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYAlertView;

@protocol CYAlertViewDelegate

@required

- (void)alertView:(CYAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface CYAlertView : UIView

@property (weak, nonatomic) id <CYAlertViewDelegate> delegate;

//标题
@property (strong, nonatomic) NSString *title;
//内容
@property (strong, nonatomic) NSString *content;

- (void)show;

@end
