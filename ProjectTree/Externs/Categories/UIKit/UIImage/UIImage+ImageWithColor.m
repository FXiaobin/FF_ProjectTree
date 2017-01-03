//
//  UIImage+ImageWithColor.m
//  SZAirReBuild
//
//  Created by admin on 14-6-20.
//  Copyright (c) 2014年 null. All rights reserved.
//

#import "UIImage+ImageWithColor.h"

@implementation UIImage (ImageWithColor)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [UIImage imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)roundedRect {
    //
    CGSize size = CGSizeMake(self.size.width, self.size.height);
    //创建图片上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    //绘制边框的圆
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, size.width, size.height));

    CGContextFillPath(context);
    //设置头像frame
    CGFloat iconW = size.width;
    CGFloat iconH = size.height;
    //绘制圆形头像范围
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, iconW, iconH));
    //剪切可视范围
    CGContextClip(context);
    //绘制头像
    [self drawInRect:CGRectMake(0, 0, iconW, iconH)];
    //取出整个图片上下文的图片
    UIImage *iconImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return iconImage;
}

- (UIImage *)circleImage{
    CGSize imageSize = self.size;
    // 开启图形上下文
    UIGraphicsBeginImageContext(imageSize);
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 矩形框
    CGRect rect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    // 添加一个圆
    CGContextAddEllipseInRect(ctx, rect);
    // 裁剪(裁剪成刚才添加的图形形状)
    CGContextClip(ctx);
    // 往圆上面画一张图片
    [self drawInRect:rect];
    // 获得上下文中的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
