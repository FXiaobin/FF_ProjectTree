//
//  UIImage+ZXTools.h
//  PublicDrugComment-OC
//
//  Created by Caizhixian on 15/10/15.
//  Copyright © 2015年 Shanghai Xuanyao Network Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZXTools)

+ (instancetype)imageWithOriginalName:(NSString *)imageName;

+ (instancetype)resizableWithImageName:(NSString *)imageName;

+ (instancetype)resizableImageName:(NSString *)imageName capInsets:(UIEdgeInsets)capInsets;

@end
