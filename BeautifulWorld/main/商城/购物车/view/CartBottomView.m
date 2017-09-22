//
//  BottomView.m
//  仿淘宝
//
//  Created by 华腾软科 on 17/2/21.
//  Copyright © 2017年 华腾软科. All rights reserved.
//

#import "CartBottomView.h"

@interface CartBottomView ()
{
    UIButton *SelectedAll;
    
    UILabel *AllPrice;
}
@end

@implementation CartBottomView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
     
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 1)];
        line.backgroundColor = RGBAColor(230, 230, 230, 1);
        [self addSubview:line];
        
//        SelectedAll = [UIButton buttonWithType:UIButtonTypeCustom];
//        [SelectedAll setImage:LoadImageByName(@"check_box_nor") forState:UIControlStateNormal];
//        SelectedAll.frame = CGRectMake(5, 7, 30, 30);
//        [SelectedAll addTarget:self action:@selector(touchSelectedALL) forControlEvents:UIControlEventTouchUpInside];
//        
//        [self addSubview:SelectedAll];
//        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(SelectedAll.frame), 12, 40, 20)];
        //label1.text = @"全选";
        label1.font = [UIFont systemFontOfSize:15];
        //[self addSubview:label1];
        
        //结算
        _BalanceAccount = [UIButton buttonWithType:UIButtonTypeCustom];
        [_BalanceAccount setTitle:@"结算" forState:UIControlStateNormal];
        [_BalanceAccount setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _BalanceAccount.backgroundColor = [UIColor orangeColor];
        _BalanceAccount.frame = CGRectMake(self.frame.size.width/3 * 2 + 10, 0, self.frame.size.width/3 - 10, 44);
        _BalanceAccount.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_BalanceAccount];
        
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_BalanceAccount.frame) - 50, 12, 50, 20)];
        label2.text = @"不含运费";
        label2.font = [UIFont systemFontOfSize:10];
        label2.textColor = [UIColor grayColor];
        [self addSubview:label2];
        
        //合计商品价格
        AllPrice = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), 12, self.frame.size.width - CGRectGetMaxX(label1.frame) - (self.frame.size.width - CGRectGetMinX(label2.frame)) - 10, 20)];
        AllPrice.text = @"合计: ￥0";
        AllPrice.font = [UIFont systemFontOfSize:13];
        AllPrice.textColor = [UIColor redColor];
        AllPrice.textAlignment = UITextLayoutDirectionRight;
        [self addSubview:AllPrice];
        
        AllPrice.attributedText = [self String:AllPrice.text RangeString:@"￥0"];
        
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Refresh:) name:@"BottomRefresh" object:nil];
        
    }
    return self;

}

-(void)init:(NSDictionary *)dict GoodsData:(NSMutableArray *)goods
{
    [SelectedAll setImage:LoadImageByName(dict[@"SelectIcon"]) forState:UIControlStateNormal];
    
    _AllSelected = [dict[@"SelectedType"] boolValue];
    
    NSLog(@"%@",dict[@"SelectedType"]);
    
   
}
-(void)Refresh:(NSNotification *)info
{
  
    NSString * str = [NSString stringWithFormat:@"合计: %@",info.userInfo[@"Data"]];
    AllPrice.text = str;
    NSLog(@"传过来的价格%@",info.userInfo[@"Data"]);

}
- (NSMutableAttributedString *)String:(NSString *)String RangeString:(NSString *)RangeString
{
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:String];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[hintString string]rangeOfString:RangeString];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range1];
    
    return hintString;
}

@end
