//
//  UIImage+Utils.m
//  iOSCodeProject
//
//  Created by Fox on 14-7-18.
//  Copyright (c) 2014年 翔傲信息科技（上海）有限公司. All rights reserved.
//

#import "UIImage+Utils.h"

CGFloat TTIDegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat TTIRadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};

@implementation UIImage (Utils)

- (UIImage *)subImageAtRect:(CGRect)rect{

    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
	CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef),
                                    CGImageGetHeight(subImageRef));
	
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);

    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef scale:1.0f
                                        orientation:self.imageOrientation];
    
    UIGraphicsEndImageContext();
	CFRelease(subImageRef);
    return smallImage;
}

- (UIImage *)imageRotatedByRadians:(CGFloat)radians{

    //沿着一定弧度旋转
    return [self imageRotatedByDegrees:TTIRadiansToDegrees(radians)];
}

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees{
    
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
	CGAffineTransform t = CGAffineTransformMakeRotation(TTIDegreesToRadians(degrees));
	rotatedViewBox.transform = t;
	CGSize rotatedSize = rotatedViewBox.frame.size;
    
	// Create the bitmap context
	UIGraphicsBeginImageContext(rotatedSize);
	CGContextRef bitmap = UIGraphicsGetCurrentContext();
	
	// Move the origin to the middle of the image so we will rotate and scale around the center.
	CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
	
	//   // Rotate the image context
	CGContextRotateCTM(bitmap, TTIDegreesToRadians(degrees));
	
	// Now, draw the rotated/scaled image into the context
	CGContextScaleCTM(bitmap, 1.0, -1.0);
	CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
	
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

- (UIImage *)imageScaledToSize:(CGSize)size{

    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
	
	float verticalRadio = size.height*1.0/height;
	float horizontalRadio = size.width*1.0/width;
	
	float radio = 1;
	if(verticalRadio>1 && horizontalRadio>1)
	{
		radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
	}
	else
	{
		radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
	}
	
	width = width*radio;
	height = height*radio;
	
    //	int xPos = (size.width - width)/2;
    //	int yPos = (size.height-height)/2;
	
	// 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
	
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, width, height)];
	
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
	
    // 返回新的改变大小后的图片
    return scaledImage;
}

@end
