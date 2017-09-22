//
//  ExhibitWorksCell.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/31.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "ExhibitWorksCell.h"
#import "EchibitCell.h"
static NSString *cellIdentifier = @"EchibitCellIdentifier";
#define  KCellH   kScreen_Height/4
@implementation ExhibitWorksCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCell];
    }
    return self;
}
-(void)initCell{
    UICollectionViewFlowLayout * layout =[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((kScreen_Width-30)/3,KCellH );
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing=0;
    
    layout.sectionInset = UIEdgeInsetsMake(5,5,5,5);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 0, kScreen_Width-10, KCellH) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.bounces=NO;
    _collectionView.scrollEnabled=NO;
    _collectionView.showsVerticalScrollIndicator=NO; //指示条
    
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    
    
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
    
    _collectionView.backgroundColor=[UIColor whiteColor];
    [_collectionView registerClass:[EchibitCell class] forCellWithReuseIdentifier:cellIdentifier];
    [self addSubview:_collectionView];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.exhibitArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //重用cell
    EchibitCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.exhibit=self.exhibitArray[indexPath.row];
    
    //cell.backgroundColor = [UIColor redColor];
    return cell;
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    ExhibitModel * model = self.exhibitArray[indexPath.item];
    [self.worksDelegate TapWorksCellDelegate:model AndINtag:indexPath.row];
    NSLog(@"cc:%ld--%ld--%@",(long)indexPath.section,indexPath.item,model);

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
