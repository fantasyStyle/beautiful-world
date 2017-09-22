//
//  RecommendTableCell.m
//  NewWorld
//
//  Created by fantasy  on 2017/2/9.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "RecommendTableCell.h"
#import "FourCollectionViewCell.h"
#import "ZWCollectionViewFlowLayout.h"

static NSString *cellIdentifier = @"cellIdentifier";

@interface RecommendTableCell () <ZWwaterFlowDelegate>
{
    UICollectionView *_CollectionView;
    
    ZWCollectionViewFlowLayout *_flowLayout;//自定义layout
    
    
    int a;
}
@end
@implementation RecommendTableCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
                [self initContentView];
    }
    return self;
}
-(void)initContentView
{
    
    //初始化自定义layout
    _flowLayout = [[ZWCollectionViewFlowLayout alloc] init];
    _flowLayout.colMagrin = 5;
    _flowLayout.rowMagrin = 5;
    
    _flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    _flowLayout.colCount = 3;
    _flowLayout.degelate = self;
    
    _CollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/6) collectionViewLayout:_flowLayout];
    
    //注册显示cell的类型
    UINib *cellNib=[UINib nibWithNibName:@"FourCollectionViewCell" bundle:nil];
    [_CollectionView registerNib:cellNib forCellWithReuseIdentifier:cellIdentifier];
    
    _CollectionView.delegate=self;
    _CollectionView.dataSource=self;
    
    _CollectionView.bounces=NO;
    _CollectionView.scrollEnabled=NO;
    _CollectionView.showsVerticalScrollIndicator=NO; //指示条
    _CollectionView.backgroundColor=[UIColor whiteColor];
       [self addSubview:_CollectionView];
    

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //重用cell
    FourCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.myGoods=self.modelArray[indexPath.item];
    
     return cell;
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GoodsModel *chanelD=self.modelArray[indexPath.item];
    
    [self.delegate TapRecommendTableCellDelegate:chanelD];
    
    NSLog(@"cc:%d--%ld--%@",_tags,indexPath.item,chanelD.goodsImage);
}


#pragma mark ZWwaterFlowDelegate
- (CGFloat)ZWwaterFlow:(ZWCollectionViewFlowLayout *)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPach
{
    return (kScreen_Height/3-10);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
