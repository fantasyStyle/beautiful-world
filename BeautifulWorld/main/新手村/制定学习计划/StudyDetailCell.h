//
//  StudyDetailCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/4/12.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudyDetailCell : UITableViewCell{
    BOOL isSelected;
}
@property(nonatomic, strong)UILabel * selectLab1;
@property(nonatomic, strong)UILabel * selectLab2;
@property (nonatomic,strong)UIButton * selectBtn1;
@property (nonatomic,strong)UIButton * selectBtn2;
@property (nonatomic,strong)UIButton * selectedBtn;
@property (nonatomic,strong)UIButton * submitBtn;

@end
