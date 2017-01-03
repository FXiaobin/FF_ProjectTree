//
//  UIImage+ImageWithColor.h
//  SZAirReBuild
//
//  Created by admin on 14-6-20.
//  Copyright (c) 2014年 null. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageWithColor)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

//这两个方法都是剪裁为圆形image
- (UIImage *)roundedRect;
- (UIImage *)circleImage;

@end
