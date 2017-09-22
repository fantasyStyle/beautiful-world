//
//  ReUserTableCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/2/24.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "ReUserTableCell.h"
#import "RecommendUserCell.h"
static NSString *cellIdentifier = @"cellIdentifier";
@implementation ReUserTableCell

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
    layout.itemSize = CGSizeMake((kScreen_Width-15)/2,kScreen_Height/6 );
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing=0;
    
    layout.sectionInset = UIEdgeInsetsMake(5,5,5,5);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/6) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.bounces=NO;
    _collectionView.scrollEnabled=NO;
    _collectionView.showsVerticalScrollIndicator=NO; //指示条
    
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    
    
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
    
    _collectionView.backgroundColor=[UIColor whiteColor];
    [_collectionView registerClass:[RecommendUserCell class] forCellWithReuseIdentifier:cellIdentifier];
    [self addSubview:_collectionView];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.userModelArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //重用cell
    RecommendUserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    //    NSLog(@"显示商品为%@",self.modelArray);
    cell.reUserModel=self.userModelArray[indexPath.row];
    
     //cell.backgroundColor = [UIColor redColor];
    return cell;
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ReUserModel *userlD=self.userModelArray[indexPath.item];
    
    [self.userDelegate TapUserCellDelegate:userlD andIntag:indexPath.item];
    
    //NSLog(@"cc:%ld--%ld--%@",(long)indexPath.section,indexPath.item);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
