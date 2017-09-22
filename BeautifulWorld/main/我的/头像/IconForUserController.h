//
//  IconForUserController.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/15.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SavePerInfoDelegate <NSObject>
-(void)onClickSaveWithHeadIcon:(NSString *)imaIcon;
@end
@interface IconForUserController : UIViewController
@property (nonatomic, strong) id<SavePerInfoDelegate> saveInfoDelegate;
@end
