//
//  SDTimeLineCell.m
//  GSD_WeiXin(wechat)
//
//  Created by gsd on 16/2/25.
//  Copyright © 2016年 GSD. All rights reserved.
//



#import "SDTimeLineCell.h"

#import "SDTimeLineCellModel.h"
#import "UIView+SDAutoLayout.h"
#import "SDTimeLineCellCommentView.h"
#import "SDWeiXinPhotoContainerView.h"

@interface SDTimeLineCell ()<SDTimeLineCellCommentViewDelegate,SDWeiXinPhotoContainerViewDelegate>

@end


const CGFloat contentLabelFontSize = 15;
CGFloat maxContentLabelHeight = 0; // 根据具体font而定


@implementation SDTimeLineCell

{
    UIImageView *_iconView;
    UILabel *_nameLable;
    UILabel * _timeLable;
    UILabel *_contentLabel;
    
    UILabel * _phoneLab;
    SDWeiXinPhotoContainerView *_picContainerView;
    UIImageView * _eyeImage;
    UILabel *_numberLabel;
    UIButton *_moreButton;
    UIButton *_operationButton;
    UIButton * _favoriteBtn;
    UIButton * _shareBtn;
    SDTimeLineCellCommentView *_commentView;
    BOOL _shouldOpenContentLabel;

}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setup
{
    
    _shouldOpenContentLabel = NO;
    
    _iconView = [UIImageView new];
    _iconView.userInteractionEnabled = YES;
    
    
    _nameLable = [UILabel new];
    _nameLable.font = [UIFont systemFontOfSize:14];
    _nameLable.textColor = [UIColor colorWithRed:(54 / 255.0) green:(71 / 255.0) blue:(121 / 255.0) alpha:0.9];
    _nameLable.userInteractionEnabled= YES;
    
    
    _timeLable =[UILabel new];
    _timeLable.font = [UIFont systemFontOfSize:12];
    _timeLable.textColor = [UIColor lightGrayColor];
    
    _contentLabel = [UILabel new];
    _contentLabel.font = [UIFont systemFontOfSize:contentLabelFontSize];
    
    _phoneLab = [UILabel new];
    _phoneLab.font = font14;
    _phoneLab.textColor = [UIColor darkGrayColor];
    if (maxContentLabelHeight == 0) {
        maxContentLabelHeight = _contentLabel.font.lineHeight * 3;
    }
    
    _moreButton = [UIButton new];
    [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
    [_moreButton setTitleColor:TimeLineCellHighlightedColor forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    _operationButton = [UIButton new];
//    [_operationButton setImage:[UIImage imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
    [_operationButton setTitle:@"回复" forState:UIControlStateNormal];
    [_operationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _operationButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_operationButton addTarget:self action:@selector(operationButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _picContainerView = [SDWeiXinPhotoContainerView new];
    _picContainerView.delegate = self;
    
    _commentView = [SDTimeLineCellCommentView new];
    _commentView.delegate = self;
    _numberLabel = [UILabel new];
    _numberLabel.font = [UIFont systemFontOfSize:13];
    _numberLabel.textColor = [UIColor lightGrayColor];
    
    _eyeImage =[UIImageView new];
    
    _favoriteBtn = [UIButton new];
    [_favoriteBtn addTarget:self action:@selector(favoriteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _shareBtn =[UIButton new];
    [_shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
   NSArray *views = @[_iconView, _nameLable,_timeLable, _contentLabel,_phoneLab, _moreButton, _picContainerView, _numberLabel, _commentView,_eyeImage];
    
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    
    _iconView.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(contentView, margin + 5)
    .widthIs(40)
    .heightIs(40);
    
    _nameLable.sd_layout
    .leftSpaceToView(_iconView, margin)
    .topEqualToView(_iconView)
    .heightIs(18);
    [_nameLable setSingleLineAutoResizeWithMaxWidth:200];
    
    _timeLable.sd_layout
    .leftEqualToView(_nameLable)
    .topSpaceToView(_nameLable,margin)
    .heightIs(15);
    [_timeLable setSingleLineAutoResizeWithMaxWidth:200];
    
    _contentLabel.sd_layout
    .leftSpaceToView(self.contentView,margin)
    .topSpaceToView(_iconView, margin)
    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0);
    
    // morebutton的高度在setmodel里面设置
    _moreButton.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_contentLabel, 0)
    .widthIs(30);
    
    _phoneLab.sd_layout
    .leftSpaceToView(self.contentView,margin)
    .topSpaceToView(_contentLabel, margin)
    .heightIs(15);
    [_phoneLab setSingleLineAutoResizeWithMaxWidth:200];

    
    
    _picContainerView.sd_layout
    .leftEqualToView(_contentLabel); // 已经在内部实现宽度和高度自适应所以不需要再设置宽度高度，top值是具体有无图片在setModel方法中设置
    
    
    _eyeImage.sd_layout
    .leftEqualToView(_iconView)
    .topSpaceToView(_picContainerView,1)
    .widthIs(20)
    .heightIs(1);
//
    _numberLabel.sd_layout
    .leftSpaceToView(_eyeImage,margin)
    .topSpaceToView(_picContainerView, 1)
    .widthIs(50)
    .heightIs(1);
    //    .autoHeightRatio(0);
    
    
    _shareBtn.sd_layout
    .rightSpaceToView(self.contentView,margin)
    .topSpaceToView(_picContainerView,1)
    .heightIs(1)
    .widthIs(25);
    
    _favoriteBtn.sd_layout
    .rightSpaceToView(_shareBtn,margin)
    .topEqualToView(_shareBtn)
    .widthIs(25)
    .heightIs(1);
    
    _operationButton.sd_layout
    .rightSpaceToView(_favoriteBtn, margin)
    .topEqualToView(_shareBtn)
//    .centerYEqualToView(_timeLabel)
    .heightIs(1)
    .widthIs(40);
    
    
    
    _commentView.sd_layout
    .leftEqualToView(_contentLabel)
    .rightSpaceToView(self.contentView, margin)
    .topSpaceToView(_operationButton, 1); // 已经在内部实现高度自适应所以不需要再设置高度
    
    
    
}


- (void)setModel:(SDTimeLineCellModel *)model
{
    _model = model;
    
    _eyeImage.image =[UIImage imageNamed:@"eye"];
    [_favoriteBtn setImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];
    [_shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    
//    _commentView.frame = CGRectZero;
//    [_commentView setupWithLikeItemsArray:model.likeItemsArray commentItemsArray:model.commentItemsArray];
    
    _shouldOpenContentLabel = NO;
    
    //_iconView.image = [UIImage imageNamed:model.iconName];
    NSString * str = [NSString stringWithFormat:@"%@%@",BaseShopUrl,model.iconName];
    [_iconView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:LoadImageByName(@"head_wu_04")];
    _iconView.layer.cornerRadius = 20;
    _iconView.contentMode  =UIViewContentModeScaleAspectFit;
    _iconView.layer.masksToBounds = YES;
//    UITapGestureRecognizer * iconTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(operationButtonClicked)];
//    [_iconView addGestureRecognizer:iconTap];
    
    _nameLable.text = model.name;
    _phoneLab.text = [NSString stringWithFormat:@"联系电话：%@",model.phone];
//    UITapGestureRecognizer * nameTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(operationButtonClicked)];
//    [_nameLable addGestureRecognizer:nameTap];
    // 防止单行文本label在重用时宽度计算不准的问题
    [_nameLable sizeToFit];
    _contentLabel.text = model.msgContent;
    _picContainerView.picPathStringsArray = model.picNamesArray;
    
    if (model.shouldShowMoreButton) { // 如果文字高度超过60
        _moreButton.sd_layout.heightIs(20);
        _moreButton.hidden = NO;
        if (model.isOpening) { // 如果需要展开
            _contentLabel.sd_layout.maxHeightIs(MAXFLOAT);
            [_moreButton setTitle:@"收起" forState:UIControlStateNormal];
        } else {
            _contentLabel.sd_layout.maxHeightIs(maxContentLabelHeight);
            [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
        }
    } else {
        _moreButton.sd_layout.heightIs(0);
        _moreButton.hidden = YES;
    }
    
    CGFloat picContainerTopMargin = 0;
    if (model.picNamesArray.count) {
        picContainerTopMargin = 40;
    }
    _picContainerView.sd_layout.topSpaceToView(_moreButton, picContainerTopMargin);
    
    UIView *bottomView;
    
    if (!model.commentItemsArray.count && !model.likeItemsArray.count) {
        _commentView.fixedWith = @0; // 如果没有评论或者点赞，设置commentview的固定宽度为0（设置了fixedWith的控件将不再在自动布局过程中调整宽度）
        _commentView.fixedHeight = @0; // 如果没有评论或者点赞，设置commentview的固定高度为0（设置了fixedHeight的控件将不再在自动布局过程中调整高度）
        _commentView.sd_layout.topSpaceToView(_numberLabel, 0);
        bottomView = _numberLabel;
    } else {
        _commentView.fixedHeight = nil; // 取消固定宽度约束
        _commentView.fixedWith = nil; // 取消固定高度约束
        _commentView.sd_layout.topSpaceToView(_numberLabel, 10);
        bottomView = _commentView;
    }
//
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:15];
    
    _numberLabel.text = @"592次";
    _numberLabel.hidden = YES;
//    NSString * time = [NSDate dateFormTimestampStringForDay:model.time];
  

    _timeLable.text = model.time;
}

#pragma mark - private actions

- (void)moreButtonClicked
{
    if (self.moreButtonClickedBlock) {
        self.moreButtonClickedBlock(self.indexPath);
    }
}

- (void)operationButtonClicked
{
    
    [self.delegate pressReplyBtn:@selector(operationButtonClicked)];
}

-(void)favoriteBtnClick:(UIButton *)btn{
    [self.delegate pressFavoriteBtn:@selector(favoriteBtnClick:)];
}

-(void)shareBtnClick{
    [self.delegate pressShareBtn:@selector(shareBtnClick)];
}

#pragma mark - SDTimeLineCellCommentViewDelegate

-(void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel{
    [self.delegate didClickLink:link linkText:linkText linkLabel:linkLabel];
}

-(void)CommentClickWithItemIndex:(NSInteger)index{
    [self.delegate CommentsLabelClickWithItemIndex:index andIndexPath:self.indexPath];
}

#pragma mark - SDWeiXinPhotoContainerViewDelegate

-(void)didSelectedImageHidKeyboard{
    if ([self.delegate respondsToSelector:@selector(didSelectedImageHidKeyboard)]) {
        [self.delegate performSelector:@selector(didSelectedImageHidKeyboard)];
    }
}

@end
