
//

#import "UserHelperCell.h"
#import "Masonry.h"
@implementation UserHelperCell

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.triangle];
    }
    return self;
}
-(UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
       _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor darkGrayColor];
    }
    return _titleLabel;
}

-(UIImageView *)triangle
{
    if (_triangle == nil) {
        _triangle = [[UIImageView alloc] init];
        _triangle.image = [UIImage imageNamed:@"向右"];
    }
    return _triangle;
}
-(UIImageView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIImageView alloc] init];
        _lineView.backgroundColor =[UIColor grayColor];
        _lineView.alpha = 0.5;
    }
    return _lineView;
}

-(void)layoutSubviews
{
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kScreen_Width, 0.5));
    }];

       [self.triangle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
}

@end
