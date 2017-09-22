//
//  iconUserTableViewCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/15.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "iconUserTableViewCell.h"
#import "IconSelectCell.h"
static NSString *cellIdentifier = @"iconIdentifier";
@implementation iconUserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self creatCollectionView];
        
        
    }
    
    return self;
}
-(void)creatCollectionView{
    UICollectionViewFlowLayout * layout =[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((kScreen_Width-20)/3,kScreen_Height/5 );
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing=0;
    
    layout.sectionInset = UIEdgeInsetsMake(5,5,5,5);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/5) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.bounces=NO;
    _collectionView.scrollEnabled=NO;
    _collectionView.showsVerticalScrollIndicator=NO; //指示条
    
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    
    
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
    
    _collectionView.backgroundColor=[UIColor whiteColor];
    [_collectionView registerClass:[IconSelectCell  class] forCellWithReuseIdentifier:cellIdentifier];
    [self addSubview:_collectionView];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //重用cell
    IconSelectCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
//    NSLog(@"显示商品为%@",self.userIconArray);
    cell.userIcon=self.userIconArray[indexPath.item];
    
    // cell.backgroundColor = [UIColor redColor];
    return cell;
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
      IconModel *userlD=self.userIconArray[indexPath.item];
    if (self.tags == 0) {
         [self.iconDelegate selectUserIcon:userlD];
    }else{
        [self.iconDelegate selectFeeIcon:userlD];
    }
   
    
    NSLog(@"cc:%ld--%ld--%@",(long)indexPath.section,indexPath.item,userlD);
}


@end
