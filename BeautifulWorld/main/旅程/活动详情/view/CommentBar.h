//
//  CommentBar.h
//  SchTimeBaby
//
//  Created by yuanju002 on 16/11/17.
//  Copyright © 2016年 yuanju001. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentBarDelegate <NSObject>

-(void)CommentBarClickWithButton:(UIButton *)btn;

@end

@interface CommentBar : UIView

@property(nonatomic ,strong) UIView * bgview;

@property (nonatomic ,strong) UIImageView * bgImage;

@property (nonatomic, weak) id <CommentBarDelegate> delegate;
@end
