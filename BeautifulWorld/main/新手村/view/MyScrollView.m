//
//  MyScrollView.m
//  ScrollViewTest1
//
//  Created by 吕中威 on 16/8/9.
//  Copyright © 2016年 吕中威. All rights reserved.
//

#import "MyScrollView.h"
#import <math.h>


#define SPACE 5
#define WIDTH ([UIScreen mainScreen].bounds.size.width - 150)

@implementation MyScrollView{
    
    UIScrollView *_scrollView;
    NSArray *_arr;
    NSInteger _count;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (id)initWithFrame:(CGRect)frame imageArr:(NSArray *)imageArr{
    
    if (self = [super initWithFrame:frame]) {
        
        _arr = [NSArray arrayWithArray:imageArr];
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        [self createScrollView:frame];
    }
    return self;

}

- (void)createScrollView:(CGRect)frame{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(75, 0, WIDTH, frame.size.height)];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
//    self.clipsToBounds = YES;
    _scrollView.clipsToBounds = NO;
    _scrollView.bounces = NO;
    _count = _arr.count + 2;
//    _scrollView.backgroundColor = [UIColor grayColor];

  
    for (int i = 0; i < _count; ++i) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((i * WIDTH)+SPACE, 0, WIDTH - SPACE * 2, frame.size.height)];
        
        UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGR:)];
//        imageView.contentMode = UIViewContentModeScaleAspectFill;
//        imageView.clipsToBounds = YES;
        if (i == 0) {
            
            imageView.image = [UIImage imageNamed:_arr[_count -3]];
        }else if (i == _count - 1){
            
            imageView.image = [UIImage imageNamed:_arr[0]];
        }else{
            
            imageView.image = [UIImage imageNamed:_arr[i - 1]];
        }
        imageView.tag = i+1000;
        [imageView addGestureRecognizer:tapGR];
        imageView.userInteractionEnabled = YES;
        [_scrollView addSubview:imageView];
    }
    _scrollView.contentSize = CGSizeMake(WIDTH * _count , frame.size.height);
      NSLog(@"%f",_scrollView.contentSize.width);
    [_scrollView setContentOffset:CGPointMake(WIDTH, 0)];
    [self addSubview:_scrollView];
    
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    UIView *view  = [super hitTest:point withEvent:event];
    
    if ([view isEqual:self]) {
        
        for (UIView *subview in _scrollView.subviews) {
            
            CGPoint offset = CGPointMake(point.x - _scrollView.frame.origin.x + _scrollView.contentOffset.x - subview.frame.origin.x,
                                         point.y - _scrollView.frame.origin.y + _scrollView.contentOffset.y - subview.frame.origin.y);
            
            NSLog(@"%f,%f",offset.x,offset.y);
            if ((view = [subview hitTest:offset withEvent:event]))
            {
                return view;
            }
        }
        return [_scrollView hitTest:point withEvent:event];
    }
    return view;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offset_x = _scrollView.contentOffset.x;
    
    if (fmod(offset_x, WIDTH) != 0) {
        
        if (offset_x / WIDTH > 0 && offset_x / WIDTH < 1 && offset_x < WIDTH / 2) {
            
            _scrollView.contentOffset = CGPointMake((_count - 2) * WIDTH + offset_x, 0);
        }else if (offset_x / WIDTH < _count - 1 && offset_x / WIDTH > _count -2 && offset_x - WIDTH *(_count -2) > WIDTH / 2){
            
            _scrollView.contentOffset = CGPointMake(offset_x - (WIDTH *(_count -2)), 0);
        }
    }
    
}

- (void)handleTapGR:(UIPanGestureRecognizer *)tap {
    
    
    NSLog(@"****%ld",tap.view.tag);
}

@end
