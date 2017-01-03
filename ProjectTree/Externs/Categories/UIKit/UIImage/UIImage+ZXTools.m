//
//  UIImage+ZXTools.m
//  PublicDrugComment-OC
//
//  Created by Caizhixian on 15/10/15.
//  Copyright © 2015年 Shanghai Xuanyao Network Technology Co., Ltd. All rights reserved.
//

#import "UIImage+ZXTools.h"

@implementation UIImage (ZXTools)

+ (instancetype)imageWithOriginalName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)resizableWithImageName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

+ (instancetype)resizableImageName:(NSString *)imageName capInsets:(UIEdgeInsets)capInsets{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
}

@end
