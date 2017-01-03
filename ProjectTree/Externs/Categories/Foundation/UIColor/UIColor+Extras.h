//
//  UIColor+Extras.h
//  ProjectTree
//
//  Created by lovepinyao on 16/8/24.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HexRGBColor(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface UIColor (Extras)

+ (UIColor *)mainColor;

//随机色
+ (UIColor *)randomColor;
+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha;

//0xf3cb6e
+ (UIColor *)colorWithHexValue:(unsigned long)hexValue;
+ (UIColor *)colorWithHexValue:(unsigned long)hexValue alpha:(CGFloat)alpha;

//@"0xf3d65a"、@"#f3d65a"、@"f3d65a"
+ (UIColor *)colorWithHexString:(NSString *)hexValue;
+ (UIColor *)colorWithHexString:(NSString *)hexValue alpha:(CGFloat)alpha;



@end
