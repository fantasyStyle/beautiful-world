//
//  PersonInfoViewController.h
//  demo
//
//  Created by yuanju001 on 16/9/21.
//  Copyright © 2016年 yuanju001. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SavePerInfoDelegate <NSObject>
-(void)onClickSaveWithNickName:(NSString *)nickName andSign:(NSString *)mySign andHeadIcon:(NSData *)imaIcon;
@end
@interface PersonInfoViewController : UIViewController

@property (nonatomic, strong) id<SavePerInfoDelegate> saveInfoDelegate;
@end
