//
//  ShopPayView.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/19.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopPayView : UIView<UITextFieldDelegate>

{
    
    NSString * danprice;
    UIImageView * backIma;
}
@property (nonatomic,strong)UIImageView  * headIcon;
@property (nonatomic,strong)UILabel  * NameLab;
@property (nonatomic,strong)UILabel  * payCountLab;
@property (nonatomic,strong)UIButton * cancelBtn;
@property (nonatomic,strong)UIButton * payBtn;
@property(nonatomic,strong)UIButton * addButn;
@property(nonatomic,strong)UIButton * deleteButn;
@property (strong,nonatomic)UITextField * TF;
@property (nonatomic,strong)UIView * payView;
@property(nonatomic,strong)UIButton * leftBtn;
@property(nonatomic,strong)UIButton * rightBtn;

-(void)initPayViewWithCount:(NSString * )count AndPayType:(NSString *)type AndGoodName:(NSString *)name AndGoodIma:(NSString *)goodIma;
-(void)initOKViewWithPayType:(NSString *)type AndGoodName:(NSString *)name AndGoodIma:(NSString *)goodIma AndFee:(NSString *)fee;

@end
