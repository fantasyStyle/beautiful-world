//
//  ExhibitWorksCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/31.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
@class ExhibitModel;
@protocol TapWorksClickDelegate <NSObject>

-(void)TapWorksCellDelegate:(ExhibitModel *)exhibit AndINtag:(NSInteger)tag;

@end
@interface ExhibitWorksCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSMutableArray * exhibitArray;
@property(nonatomic,assign)int  tags; //所在section
@property(nonatomic,assign)id worksDelegate;
@end
