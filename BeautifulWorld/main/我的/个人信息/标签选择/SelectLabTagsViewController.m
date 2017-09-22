//
//  SelectLabTagsViewController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/20.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "SelectLabTagsViewController.h"
#import "VOTagList.h"
@interface SelectLabTagsViewController ()

@end

@implementation SelectLabTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *tags = @[@"卡通", @"水粉", @"陶艺", @"素描",@"速写", @"色彩", @"动漫", @"简笔画",@"油画棒"];
    VOTagList *tagList = [[VOTagList alloc] initWithTags:tags];
    tagList.frame = CGRectMake(20, 80, kScreen_Width, kScreen_Height/4);
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectedTagsChanged: (VOTagList *)tagList{
    NSLog(@"selected: %@", tagList.selectedIndexSet);
}

@end
