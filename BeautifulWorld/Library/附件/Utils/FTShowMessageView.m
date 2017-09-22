//
//  FTShowMessageView.m
//  NewWorld
//
//  Created by fantasy  on 2017/2/16.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "FTShowMessageView.h"
#import "MMProgressHUD.h"
@implementation FTShowMessageView
+ (void)showErrorWithMessage:(NSString *)message{
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleSwingRight];
    [MMProgressHUD setDisplayStyle:MMProgressHUDDisplayStyleBordered];
    [MMProgressHUD dismissWithError:nil title:message afterDelay:2.0];
}
+ (void)showSuccessWithMessage:(NSString *)message
{
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleSwingRight];
    [MMProgressHUD setDisplayStyle:MMProgressHUDDisplayStyleBordered];
    [MMProgressHUD dismissWithSuccess:nil title:message afterDelay:2.0];
}
+ (void)showStatusWithMessage:(NSString *)message
{
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleExpand];
    [MMProgressHUD showWithTitle:nil status:message];
}
+ (void)dismissSuccessView:(NSString *)message
{
    [MMProgressHUD dismissWithSuccess:message];
}
+ (void)dismissErrorView:(NSString *)message
{
    [MMProgressHUD dismissWithError:message];
}
+(void)dismiss{
    [MMProgressHUD dismiss];
}
@end
