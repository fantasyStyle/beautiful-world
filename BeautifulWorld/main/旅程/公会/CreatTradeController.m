//
//  CreatTradeController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/21.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "CreatTradeController.h"
#import "HUD.h"
#import "VOTagList.h"
@interface CreatTradeController ()<UITextFieldDelegate>{
    //文字数组
    NSMutableArray *_dataArray;
    //输入框
    UITextField *theTextField;
    
    
    

}



@end

@implementation CreatTradeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"编辑工会资料";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
  
    // Do any additional setup after loading the view.
}
-(void)initView{
    UIButton * photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoBtn setImage:LoadImageByName(@"photo_03") forState:UIControlStateNormal];
    photoBtn.frame = CGRectMake(kScreen_Width/8*3, kScreen_Height/8, kScreen_Width/4, kScreen_Width/4);
    [self.view addSubview:photoBtn];
    
    theTextField = [[UITextField alloc]init];
    theTextField.delegate = self;
    theTextField.placeholder = @"填写公会名称（2～10个字）";
    theTextField.frame  = CGRectMake(kScreen_Width/5, photoBtn.y*2+photoBtn.frame.size.height, kScreen_Width/5*3, 20);
    [self.view addSubview:theTextField];
    
    UIView * line = [[UIView alloc]init];
    line.frame = CGRectMake(kScreen_Width/5-10, theTextField.y+25,theTextField.frame.size.width+20 ,1);
    line.backgroundColor = RGBColor(50, 158, 224);
    [self.view addSubview:line];
    
    UILabel * selectLab = [[UILabel alloc]init];
    selectLab.frame = CGRectMake(30, line.y+40, kScreen_Width/2, 20);
    selectLab.text = @"选择公会标签 (2~6个)";
    selectLab.font = font15;
    [self.view addSubview:selectLab];
    
//    NSArray * labArr = @[@"卡通",@"水粉",@"陶艺",@"素描",@"速写",@"色彩",@"动漫",@"简笔画",@"油画棒"];
//    CGFloat margin = 25;
//    CGFloat marginX = 30;
//    CGFloat labW =( kScreen_Width - margin * 4 - marginX *2)/5;
//    CGFloat labH = labW/5*3;
//    for (int i =0; i<labArr.count; i++) {
//        NSInteger rank = i/5;//行
//        NSInteger column = i%5;//列
//
//        UIButton * labBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        labBtn.frame = CGRectMake(marginX + (labW + margin)*column, selectLab.y+40+(labH + 15)*rank, labW, labH);
//        labBtn.tag = i+10;
//        [labBtn addTarget:self action:@selector(selectedBtn:) forControlEvents:UIControlEventTouchUpInside];
//        [labBtn setBackgroundImage:LoadImageByName(@"按钮（未选中）") forState:UIControlStateNormal];
//        [labBtn setBackgroundImage:LoadImageByName(@"按钮（选中）") forState:UIControlStateSelected];
//        labBtn.layer.masksToBounds = YES;
//        labBtn.layer.cornerRadius = 15;
//        //[labBtn sizeToFit];
//        [labBtn setTitle:labArr[i] forState:UIControlStateNormal];
//        if (i>6) {
//             labBtn.frame = CGRectMake(marginX + (labW + margin/2*3)*column, selectLab.y+40+(labH + 15)*rank, labW/2*3, labH);
//        }
//        [self.view addSubview:labBtn];

        

    //}
    
    NSArray *tags = @[@"卡通", @"水粉", @"陶艺", @"素描",@"速写", @"色彩", @"动漫", @"简笔画",@"油画棒"];
    VOTagList *tagList = [[VOTagList alloc] initWithTags:tags];
    tagList.frame = CGRectMake(20, selectLab.y+40, kScreen_Width-40, kScreen_Height/4);
    tagList.multiLine = YES;
    tagList.multiSelect = YES;
    tagList.allowNoSelection = YES;
    tagList.vertSpacing = 20;
    tagList.horiSpacing = 20;
    tagList.selectedTextColor = [UIColor whiteColor];
    tagList.tagBackgroundColor = RGBColor(211, 212, 213);
    tagList.selectedTagBackgroundColor = RGBColor(159, 224, 37);
    tagList.tagCornerRadius = 5;
    
    tagList.tagEdge = UIEdgeInsetsMake(8, 8, 8, 8);
    [tagList addTarget:self action:@selector(selectedTagsChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:tagList];

    
    
    UIButton * submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(20, kScreen_Height-NavBar_Height-StatusBar_Height-60, kScreen_Width-40, 40);
    submitBtn.backgroundColor = RGBColor(50, 158, 224);
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 10;
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
}
- (void)selectedTagsChanged: (VOTagList *)tagList{
    NSLog(@"selected: %@", tagList.selectedIndexSet);
}
-(void)submit{
    [HUD showAlertWithTitle:@"已提交"];
    [self.navigationController popViewControllerAnimated:YES];
}
//-(void)selectedBtn:(UIButton *)sender{
//    NSLog(@"选中了%ld",sender.tag);
//    UIButton * btn = (id)[self.view viewWithTag:sender.tag];
//    btn.selected = YES;
//}
@end
