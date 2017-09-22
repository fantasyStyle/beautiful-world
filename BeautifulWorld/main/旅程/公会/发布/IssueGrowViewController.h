//
//  IssueGrowViewController.h
//  demo
//
//  Created by yuanju001 on 16/9/27.
//  Copyright © 2016年 yuanju001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBTextView.h"
@interface IssueGrowViewController : UIViewController
@property (strong, nonatomic) CBTextView *textView;
@property (strong, nonatomic) UIButton *aButton;
@property (assign, nonatomic) BOOL isThreeOrNine;

@end
