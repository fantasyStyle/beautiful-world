//
//  SDWeiXinPhotoContainerView.h
//  SDAutoLayout 测试 Demo
//
//  Created by gsd on 15/12/23.
//  Copyright © 2015年 gsd. All rights reserved.
//


/*
 
 *********************************************************************************

 *********************************************************************************
 
 */

#import <UIKit/UIKit.h>

@protocol SDWeiXinPhotoContainerViewDelegate <NSObject>

-(void)didSelectedImageHidKeyboard;

@end


@interface SDWeiXinPhotoContainerView : UIView

@property (nonatomic, strong) NSArray *picPathStringsArray;

@property(nonatomic,weak)id<SDWeiXinPhotoContainerViewDelegate>delegate;

@end
