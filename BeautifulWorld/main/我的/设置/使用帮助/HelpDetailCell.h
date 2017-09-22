
//

#import <UIKit/UIKit.h>

@interface HelpDetailCell : UITableViewCell
@property (nonatomic,assign)CGFloat viewHeight;
@property(nonatomic, strong)UILabel * titileLab;
- (CGFloat)getViewHeight;
-(void)initTitleLabWithTitle:(NSString *)str;
@end
