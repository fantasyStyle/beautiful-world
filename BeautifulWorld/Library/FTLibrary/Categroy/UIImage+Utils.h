//
//  UIImage+Utils.h
//  iOSCodeProject
//
//  Created by Fox on 14-7-18.
//  Copyright (c) 2014年 翔傲信息科技（上海）有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  UIImage扩展类别
 */
@interface UIImage (Utils)

/**
 *  截图部分图片
 *
 *  @param rect 截取区域
 *
 *  @return 结果图片
 */
- (UIImage *)subImageAtRect:(CGRect)rect;

/**
 *  沿着一定弧度旋转
 *
 *  @param radians 旋转的弧度
 *
 *  @return 结果图片
 */
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;

/**
 *  沿着一定的角度旋转
 *
 *  @param degrees 旋转的角度
 *
 *  @return 结果图片
 */
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

/**
 *  等比例压缩图片
 *
 *  @param size 压缩到的大小
 *
 *  @return 结果图片
 */
- (UIImage *)imageScaledToSize:(CGSize)size;

@end
