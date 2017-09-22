//
//  LabelVerticalAlignment.h
//  qwqw
//
//  Created by hff on 15/7/20.
//  Copyright (c) 2015年 ttti. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface LabelVerticalAlignment : UILabel
{
   // VerticalAlignment verticalAlignment;
}

@property (nonatomic) VerticalAlignment verticalAlignment;
@end
