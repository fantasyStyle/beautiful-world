//
//  iconUserTableViewCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/15.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
@class IconModel;
@protocol SelectIcondelegate <NSObject>

-(void)selectUserIcon:(IconModel *)userIcon;
-(void)selectFeeIcon:(IconModel *)userIcon;

@end
@interface iconUserTableViewCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSMutableArray * userIconArray;
@property(nonatomic,assign)int  tags; //所在section
@property(nonatomic,assign)id iconDelegate;
@end
