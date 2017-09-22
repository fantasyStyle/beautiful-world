//
//  SDTimeLineCell.h
//  GSD_WeiXin(wechat)
//
//  Created by gsd on 16/2/25.
//  Copyright © 2016年 GSD. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "MLLinkLabel.h"

@protocol SDTimeLineCellDelegate <NSObject>

@optional
-(void)pressFavoriteBtn:(SEL)btn;
-(void)pressShareBtn:(SEL)btn;
-(void)pressReplyBtn:(SEL)btn;

-(void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel;

-(void)CommentsLabelClickWithItemIndex:(NSInteger)index andIndexPath:(NSIndexPath *)indexPath;

-(void)didSelectedImageHidKeyboard;
@end

@class SDTimeLineCellModel;

@interface SDTimeLineCell : UITableViewCell

@property (nonatomic, strong) SDTimeLineCellModel *model;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) void (^moreButtonClickedBlock)(NSIndexPath *indexPath);

@property (nonatomic, weak) id<SDTimeLineCellDelegate>delegate;

@end
