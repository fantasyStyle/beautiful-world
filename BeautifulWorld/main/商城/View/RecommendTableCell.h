//
//  RecommendTableCell.h
//  NewWorld
//
//  Created by fantasy  on 2017/2/9.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsModel;
@protocol RecommendTableCellDelegate <NSObject>

-(void)TapRecommendTableCellDelegate:(GoodsModel *)chaneldata;

@end

@interface RecommendTableCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)NSArray *modelArray;

@property(nonatomic,assign)int  tags; //所在section

@property(nonatomic,assign)id delegate;

@end
