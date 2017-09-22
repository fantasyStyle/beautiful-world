//
//  HotGoodsTableCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/2/24.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>

@class HotModel;
@protocol onClickGoodsDelegate <NSObject>

-(void)TapHotCellDelegate:(HotModel *)chaneldata;

@end

@interface HotGoodsTableCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    
}
@property (nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSMutableArray *modelArray;
@property(nonatomic,assign)int  tags; //所在section
@property(nonatomic,assign)id delegate;
@end
