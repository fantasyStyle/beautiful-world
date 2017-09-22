//
//  GoodsShoppingController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/2/28.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "GoodsShoppingController.h"
#import "GridListCollectionViewCell.h"
#import "GridListModel.h"
#import "NSObject+Property.m"
@interface GoodsShoppingController ()<UICollectionViewDataSource, UICollectionViewDelegate>{
    UIButton *rightbutton;//导航栏右边按钮
    BOOL _isGrid;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;


@end

@implementation GoodsShoppingController

- (void)viewDidLoad {
    [super viewDidLoad];
    rightbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightbutton setImage: [UIImage imageNamed:@"product_list_list_btn"] forState:UIControlStateNormal];
    rightbutton.frame=CGRectMake(0, 0, 35, 35);
    [rightbutton addTarget:self action:@selector(onChangeList:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    
    // 默认列表视图
    _isGrid = NO;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"product" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
   // [self.view addSubview:self.collectionView];
    [FTShowMessageView showStatusWithMessage:@"Loading..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_main_sync_safe(^{
            [FTShowMessageView dismissSuccessView:@"Success"];
        });
        [self.view addSubview:self.collectionView];
    });

    NSArray *products = dict[@"wareInfo"];
    for (id obj in products) {
        [self.dataSource addObject:[GridListModel objectWithDictionary:obj]];
    }


    // Do any additional setup after loading the view.
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GridListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_CollectionViewCell forIndexPath:indexPath];
    cell.isGrid = _isGrid;
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isGrid) {
        return CGSizeMake((kScreen_Width - 6) / 2, (kScreen_Width - 6) / 2 + 40);
    } else {
        return CGSizeMake(kScreen_Width - 4, (kScreen_Width - 6) / 4 + 20);
    }
}
#pragma mark - Action

-(void)onChangeList:(UIButton *)sender{
    _isGrid = !_isGrid;
    [self.collectionView reloadData];
    
    if (_isGrid) {
        [rightbutton setImage:[UIImage imageNamed:@"product_list_grid_btn"] forState:0];
    } else {
        [rightbutton setImage:[UIImage imageNamed:@"product_list_list_btn"] forState:0];
    }

}
#pragma mark - Getters

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        //设置滚动方向
        [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //左右间距
        flowlayout.minimumInteritemSpacing = 2;
        //上下间距
        flowlayout.minimumLineSpacing = 2;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(2 , 2 , kScreen_Width - 4, kScreen_Height - 4) collectionViewLayout:flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        //注册cell
        [_collectionView registerClass:[GridListCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier_CollectionViewCell];
    }
    return _collectionView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
