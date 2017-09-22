//
//  addLocationViewController.h
//  gowuche
//
//  Created by 上海点硕 on 16/4/20.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol passModelDelegate<NSObject>
- (void)passModel:(NSString *)name andtell:(NSString *)tell anddizhi:(NSString *)detailLocation;
@end

@interface addLocationViewController : UIViewController
@property(assign,nonatomic)id<passModelDelegate>delegate;
@end
