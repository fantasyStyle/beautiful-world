//
//  CommentTableViewCell.h
//  demo
//
//  Created by yuanju002 on 16/9/23.
//  Copyright © 2016年 yuanju001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "commentModel.h"

@protocol CommentTableViewCellDelegate <NSObject>

-(void)pressZan:(NSString *)likeNum;

@end
@interface CommentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *date;

@property (weak, nonatomic) IBOutlet UILabel *content;

@property (weak, nonatomic) IBOutlet UIButton *zan;

@property (weak, nonatomic) IBOutlet UIView *line;


@property(nonatomic,weak) id<CommentTableViewCellDelegate>delegate;

-(void)setContents:(commentModel *)model;

+(CGFloat)cellHeight:(commentModel *)model;

@end
