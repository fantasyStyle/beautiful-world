//
//  ReUserTableCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/2/24.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReUserModel;
@protocol TapUserClickDelegate <NSObject>

-(void)TapUserCellDelegate:(ReUserModel *)userData andIntag:(NSInteger)tag;

@end

@interface ReUserTableCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSMutableArray * userModelArray;
@property(nonatomic,assign)int  tags; //所在section
@property(nonatomic,assign)id userDelegate;

@end
