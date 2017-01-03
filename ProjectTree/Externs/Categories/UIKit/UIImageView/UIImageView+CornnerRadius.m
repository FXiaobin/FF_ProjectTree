//
//  UIImageView+CornnerRadius.m
//  ProjectTree
//
//  Created by lovepinyao on 16/9/8.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "UIImageView+CornnerRadius.h"

@implementation UIImageView (CornnerRadius)

-(void)setCornnerRadiusWithImage:(UIImage *)image{
    self.backgroundColor = [UIColor clearColor];
    self.image = [self circleImageWithImage:image];
}

- (UIImage *)circleImageWithImage:(UIImage *)image{
    CGSize imageSize = image.size;
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
    [image drawInRect:rect];
    // 获得上下文中的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
