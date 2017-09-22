//
//  SDWeiXinPhotoContainerView.m
//  SDAutoLayout 测试 Demo
//
//  Created by gsd on 15/12/23.
//  Copyright © 2015年 gsd. All rights reserved.
//


/*
 
 *********************************************************************************
 
 *********************************************************************************
 
 */

#import "SDWeiXinPhotoContainerView.h"

#import "UIView+SDAutoLayout.h"

#import "SDPhotoBrowser.h"

@interface SDWeiXinPhotoContainerView () <SDPhotoBrowserDelegate>{
   
}

@property (nonatomic, strong) NSArray *imageViewsArray;

@end

@implementation SDWeiXinPhotoContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [UIImageView new];
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    
    self.imageViewsArray = [temp copy];
}


//- (void)setPicPathStringsArray:(NSArray *)picPathStringsArray
//{
//    _picPathStringsArray = picPathStringsArray;
//    
//    for (long i = _picPathStringsArray.count; i < self.imageViewsArray.count; i++) {
//        NSString *imageName =[NSString stringWithFormat:@"%@%@",worldsell,[self.imageViewsArray objectAtIndex:i]];
//       UIImageView *imageVi;
//        [imageVi sd_setImageWithURL:[NSURL URLWithString:imageName]];
//        imageVi.hidden = YES;
//    }
//    
//    if (_picPathStringsArray.count == 0) {
//        self.height = 0;
//        self.fixedHeight = @(0);
//        return;
//    }
//    
//    CGFloat itemW = [self itemWidthForPicPathArray:_picPathStringsArray];
//    CGFloat itemH = 0;
//    if (_picPathStringsArray.count == 1) {
////        UIImage *image = [UIImage imageNamed:_picPathStringsArray.firstObject];
//         NSString *imageName =[NSString stringWithFormat:@"%@%@",worldsell,_picPathStringsArray.firstObject];
//        UIImageView * sdIma;
//        [sdIma sd_setImageWithURL:[NSURL URLWithString:imageName]];
//        
//        if (sdIma.size.width) {
//            itemH = sdIma.size.height / sdIma.size.width * itemW;
//        }
//    } else {
//        itemH = itemW;
//    }
//    long perRowItemCount = [self perRowItemCountForPicPathArray:_picPathStringsArray];
//    CGFloat margin = 5;
//    
//    [_picPathStringsArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        long columnIndex = idx % perRowItemCount;
//        long rowIndex = idx / perRowItemCount;
////        UIImageView *imageView = [_imageViewsArray objectAtIndex:idx];
//        UIImageView * imageView;
//        imageView.hidden = NO;
//        NSString *imageName =[NSString stringWithFormat:@"%@%@",worldsell,[_imageViewsArray objectAtIndex:idx]];
//        [imageView sd_setImageWithURL:[NSURL URLWithString:imageName]];
////        imageView.image = [UIImage imageNamed:obj];
//        imageView.frame = CGRectMake(columnIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
//    }];
//    
//    CGFloat w = perRowItemCount * itemW + (perRowItemCount - 1) * margin;
//    int columnCount = ceilf(_picPathStringsArray.count * 1.0 / perRowItemCount);
//    CGFloat h = columnCount * itemH + (columnCount - 1) * margin;
//    self.width = w;
//    self.height = h;
//    
//    self.fixedHeight = @(h);
//    self.fixedWith = @(w);
//}
- (void)setPicPathStringsArray:(NSArray *)picPathStringsArray
{
    _picPathStringsArray = picPathStringsArray;
    
    for (long i = _picPathStringsArray.count; i < self.imageViewsArray.count; i++) {
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
        imageView.hidden = YES;
    }
    
    if (_picPathStringsArray.count == 0) {
        self.height = 0;
        self.fixedHeight = @(0);
        return;
    }
    
    CGFloat itemW = [self itemWidthForPicPathArray:_picPathStringsArray];
    CGFloat itemH = 0;
    if (_picPathStringsArray.count == 1) {
       // UIImage *image = [UIImage imageNamed:_picPathStringsArray.firstObject];
        
        UIImageView *imageView = _imageViewsArray.firstObject;
        NSString* str = [NSString stringWithFormat:@"%@",_imageViewsArray.firstObject];
        imageView.hidden = NO;
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",worldsell,str]]];
        imageView.frame = CGRectMake((kScreen_Width-150)/2, (itemH + 5), 200, 200);

        if (imageView.size.width) {
            itemH = imageView.size.height / imageView.size.width * itemW;
        }
    } else {
        itemH = itemW;
    }
    long perRowItemCount = [self perRowItemCountForPicPathArray:_picPathStringsArray];
    CGFloat margin = 5;
    
    [_picPathStringsArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        NSLog(@"得到的数组%ld",idx);
        long columnIndex = idx % perRowItemCount;
        long rowIndex = idx / perRowItemCount;
        UIImageView *imageView = [_imageViewsArray objectAtIndex:idx];
        imageView.hidden = NO;
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",worldsell,obj]]];
        imageView.frame = CGRectMake(columnIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
    }];
    
    CGFloat w = perRowItemCount * itemW + (perRowItemCount - 1) * margin;
    int columnCount = ceilf(_picPathStringsArray.count * 1.0 / perRowItemCount);
    CGFloat h = columnCount * itemH + (columnCount - 1) * margin;
    self.width = w;
    self.height = h;
    
    self.fixedHeight = @(h);
    self.fixedWith = @(w);
}


#pragma mark - private actions

- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    UIView *imageView = tap.view;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = imageView.tag;
    browser.sourceImagesContainerView = self;
    browser.imageCount = self.picPathStringsArray.count;
    browser.delegate = self;
    [browser show];
    
    if ([self.delegate respondsToSelector:@selector(didSelectedImageHidKeyboard)]) {
        [self.delegate performSelector:@selector(didSelectedImageHidKeyboard)];
    }
}

- (CGFloat)itemWidthForPicPathArray:(NSArray *)array
{
    if (array.count == 1) {
        return 120;
    } else {
//        CGFloat w = [UIScreen mainScreen].bounds.size.width > 320 ? 80 : 70;
        CGFloat w = (kScreen_Width - 30) / 3;
        return w;
    }
}

- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array
{
    if (array.count <= 3) {
        return array.count;
    }
//    else if (array.count == 4) {
//        return 3;
//    }
    else {
        return 3;
    }
}


#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *imageName =[NSString stringWithFormat:@"%@%@",worldsell,self.picPathStringsArray[index]];
    //NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
    NSURL * url = [NSURL URLWithString:imageName];
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.subviews[index];
    return imageView.image;
}

@end
