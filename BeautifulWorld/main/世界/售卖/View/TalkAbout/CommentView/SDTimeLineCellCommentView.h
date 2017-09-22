//
//  SDTimeLineCellCommentView.h
//  GSD_WeiXin(wechat)
//
//  Created by gsd on 16/2/25.
//  Copyright © 2016年 GSD. All rights reserved.
//

/*
 
 *****************************************************************************
 *********************************************************************************
 
 */

#import <UIKit/UIKit.h>
#import "MLLinkLabel.h"
#import "GlobalDefines.h"

@protocol SDTimeLineCellCommentViewDelegate <NSObject>

-(void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel;

-(void)CommentClickWithItemIndex:(NSInteger)index;

@end

@interface SDTimeLineCellCommentView : UIView

- (void)setupWithLikeItemsArray:(NSArray *)likeItemsArray commentItemsArray:(NSArray *)commentItemsArray;

@property(nonatomic,weak)id<SDTimeLineCellCommentViewDelegate> delegate;
@end
