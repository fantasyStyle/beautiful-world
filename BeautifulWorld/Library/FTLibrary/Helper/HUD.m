//
//  HUD.m
//  zzz
//
//  Created by zym on 3/12/14.
//  Copyright (c) 2014 zym. All rights reserved.
//

#import "HUD.h"

#define Delay_Time 2.0f

static UIView* lastViewWithHUD = nil;

@implementation HUD


+(UIView *)rootView
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController.view;
}




+(void)hideMBIndicator
{
    [MBProgressHUD hideHUDForView:lastViewWithHUD animated:YES];
}


+(MBProgressHUD *)showAlertWithTitle:(NSString *)title duration:(float)duration
{
    return [self showAlertWithTitle:title inView:nil duration:duration];
}

+(MBProgressHUD *)showAlertWithTitle:(NSString *)title
{
    return [self showAlertWithTitle:title duration:Delay_Time];
}

+(MBProgressHUD *)showAlertWithTitle:(NSString *)title inView:(UIView *)inView
{
    return [self showAlertWithTitle:title inView:inView duration:Delay_Time];
}

+(MBProgressHUD *)showAlertWithTitle:(NSString *)title inView:(UIView *)inView duration:(float)duration
{
    
    UIView* targetView = inView;
    
    if (targetView==nil)
    {
        targetView=[self rootView];
    }
    
    targetView = [UIApplication sharedApplication].keyWindow;
    
    lastViewWithHUD = targetView;

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    hud.userInteractionEnabled = NO;
    hud.color = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
    hud.detailsLabelText=title;
    //hud.detailsLabelColor = [[UIColor whiteColor] colorWithAlphaComponent:0.85f];
    hud.removeFromSuperViewOnHide=YES;
    hud.mode=MBProgressHUDModeText;
    hud.detailsLabelFont=[UIFont systemFontOfSize:14];
    [hud hide:YES afterDelay:duration];
    hud.margin=25;
    hud.yOffset=0;
    return hud;
}
//+(MBProgressHUD *)show{
//    MBProgressHUD * hud = [[MBProgressHUD alloc]init];
//   [hud show:YES];
//    return hud;
//}
@end
