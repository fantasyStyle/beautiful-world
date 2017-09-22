
//

#import "HelpDetailCell.h"

@implementation HelpDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=RGBColor(244, 251, 255);

        //[self initTitleLabWithTitle:self.titileLab.text];
    }
    return self;
}
-(void)initTitleLabWithTitle:(NSString *)str{
    self.titileLab = [[UILabel alloc]init];
    _titileLab.frame = CGRectMake(0, 0, kScreen_Width,0 );
    [_titileLab setNumberOfLines:0];
   // NSString * str = @"尊敬的用户，您好！为提高系统运行效率，时光宝贝系统正在进行维护，维护期间您将无法进行正常的登录以及相关业务操作。系统维护期间。";
    _titileLab.textColor = [UIColor grayColor];
    _titileLab.font = [UIFont systemFontOfSize:14];
    _titileLab.text = str;
    _titileLab.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [_titileLab sizeThatFits:CGSizeMake(_titileLab.frame.size.width, MAXFLOAT)];
    _titileLab.frame = CGRectMake(5, 0, kScreen_Width-20, size.height);
    self.viewHeight = size.height;
    [self addSubview:_titileLab];
    
}
#pragma mark -- 高度返回
- (CGFloat)getViewHeight{
    
    return _viewHeight;
    
}
@end
