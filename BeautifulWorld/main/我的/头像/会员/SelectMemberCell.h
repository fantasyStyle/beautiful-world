//
//  SelectMemberCell.h
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/23.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SelectMemberDelegate <NSObject>
-(void)onSelectVIPMember;
-(void)onSelectSuperMember;
@end
@interface SelectMemberCell : UITableViewCell{
    BOOL isSelected;
}
@property (nonatomic,strong)UIButton * vipBtn;
@property (nonatomic,strong)UIButton * superBtn;
@property (nonatomic,strong)UIButton * selectedBtn;
@property (nonatomic,strong)id<SelectMemberDelegate> memberDelegate;
@end
