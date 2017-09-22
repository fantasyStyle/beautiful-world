//
//  CommentBar.m
//  SchTimeBaby
//
//  Created by yuanju002 on 16/11/17.
//  Copyright © 2016年 yuanju001. All rights reserved.
//

#import "CommentBar.h"


@implementation CommentBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createContent];
    }
    return self;
}
-(void)createContent{
    
    self.bgImage =[[UIImageView alloc]initWithFrame:self.bounds];
    self.bgImage.image = [UIImage imageNamed:@"EaseUIResource.bundle/messageToolbarBg"];
    self.bgImage.backgroundColor =[UIColor whiteColor];
    
    self.bgImage.userInteractionEnabled = YES;
    [self addSubview:self.bgImage];
    
    self.bgview =[[UIView alloc]initWithFrame:CGRectMake(kScreen_Width/3, 10, kScreen_Width/3*2-10, 30)];
    self.bgview.backgroundColor =[UIColor clearColor];
    self.bgview.layer.cornerRadius = 15;
    self.bgview.layer.masksToBounds = YES;
    [self.bgImage addSubview:self.bgview];
    
    UIButton * placeHolderBtn =[[UIButton alloc]initWithFrame:CGRectMake(3, 0, kScreen_Width/3*2-10, 30)];
    placeHolderBtn.tag = CommentBtnTag + 1;
    [placeHolderBtn setTitle:@"我也来说一句" forState:UIControlStateNormal];
    [placeHolderBtn  setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [placeHolderBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -0.2 * kScreen_Width, 0, 0)];
    [placeHolderBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    placeHolderBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.bgview addSubview:placeHolderBtn];
    
    
}

-(void)BtnClick:(UIButton *)btn{
    
    [self.delegate CommentBarClickWithButton:btn];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
