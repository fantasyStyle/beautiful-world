//
//  MyCustomCell.m
//  ShoppingList_Demo
//
//  Created by 李金华 on 15/4/20.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import "MyCustomCell.h"

#define WIDTH ([UIScreen mainScreen].bounds.size.width)

@implementation MyCustomCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //布局界面
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, kScreen_Height/5)];
        bgView.backgroundColor = [UIColor whiteColor];
        
        UIImageView * imaShow = [[UIImageView alloc]init];
        imaShow.frame = CGRectMake(10, 5, 20, 20);
        imaShow.image = LoadImageByName(@"购物篮");
        [bgView addSubview:imaShow];
        
        
        _goodsLab = [[UILabel alloc]init];
        _goodsLab.frame = CGRectMake(50, 5, 100, 20);
        _goodsLab.font = font13;
        [bgView addSubview:_goodsLab];
        
        //添加商品图片
        _goodsImgV = [[UIImageView alloc]initWithFrame:CGRectMake(40, 35, kScreen_Width/4, kScreen_Width/5)];
        _goodsImgV.backgroundColor = [UIColor greenColor];
        [bgView addSubview:_goodsImgV];
        
       
        
        //添加商品标题
        _goodsTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(50+kScreen_Width/4, 35, 200, 20)];
        _goodsTitleLab.text = @"afadsfa fa";
        _goodsTitleLab.font = font14;
        _goodsTitleLab.backgroundColor = [UIColor clearColor];
        [bgView addSubview:_goodsTitleLab];
        
        //促销价
        _priceTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(_goodsTitleLab.x , 65, 40, 20)];
        _priceTitleLab.text = @"单价:";
        _priceTitleLab.backgroundColor = [UIColor clearColor];
        _priceTitleLab.font = font14;
        [bgView addSubview:_priceTitleLab];
        
        //商品价格
        _priceLab = [[UILabel alloc]initWithFrame:CGRectMake(_goodsTitleLab.x+50, 65, 100, 20)];
        _priceLab.text = @"1990";
        _priceLab.font = font14;
        _priceLab.textColor = [UIColor redColor];
        [bgView addSubview:_priceLab];
        
        //购买数量
        _goodsNumLab = [[UILabel alloc]initWithFrame:CGRectMake(_goodsTitleLab.x, 95, 90, 20)];
        _goodsNumLab.text = @"购买数量：";
        _goodsNumLab.font = font14;
        [bgView addSubview:_goodsNumLab];
        
        //减按钮
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake(_goodsTitleLab.x+90, 85, 25, 25);
        [_deleteBtn setImage:[UIImage imageNamed:@"按钮-.png"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.tag = 11;
        [bgView addSubview:_deleteBtn];
        
        //购买商品的数量
        _numCountLab = [[UILabel alloc]initWithFrame:CGRectMake(_deleteBtn.x+25, 85, 30, 20)];
        _numCountLab.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:_numCountLab];
        
        //加按钮
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.frame = CGRectMake(_deleteBtn.x+55, 85, 25, 25);
        [_addBtn setImage:[UIImage imageNamed:@"按钮+.png"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _addBtn.tag = 12;
        [bgView addSubview:_addBtn];
        
        //是否选中图片
        _isSelectImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, (kScreen_Height/5-20)/2, 20, 20)];
        [bgView addSubview:_isSelectImg];
        
        [self addSubview:bgView];
    }
    return self;
}

/**
 *  给单元格赋值
 *
 *  @param goodsModel 里面存放各个控件需要的数值
 */
-(void)addTheValue:(GoodsInfoModel *)goodsModel
{
    _goodsImgV.image = [UIImage imageNamed:goodsModel.imageName];
    _goodsTitleLab.text = goodsModel.goodsTitle;
    _priceLab.text = goodsModel.goodsPrice;
    _numCountLab.text = [NSString stringWithFormat:@"%d",goodsModel.goodsNum];
    _goodsLab.text = goodsModel.goodsName;
    
    if (goodsModel.selectState)
    {
        _selectState = YES;
        _isSelectImg.image = [UIImage imageNamed:@"复选框-选中"];
    }else{
        _selectState = NO;
        _isSelectImg.image = [UIImage imageNamed:@"复选框-未选中"];
    }
    
}

/**
 *  点击减按钮实现数量的减少
 *
 *  @param sender 减按钮
 */
-(void)deleteBtnAction:(UIButton *)sender
{
    //判断是否选中，选中才能点击
    if (_selectState == YES)
    {
        //调用代理
        [self.delegate btnClick:self andFlag:(int)sender.tag];
    }

}
/**
 *  点击加按钮实现数量的增加
 *
 *  @param sender 加按钮
 */
-(void)addBtnAction:(UIButton *)sender
{
    //判断是否选中，选中才能点击
    if (_selectState == YES)
    {
        //调用代理
        [self.delegate btnClick:self andFlag:(int)sender.tag];
    }

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
