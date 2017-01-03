//
//  UIColor+Extras.m
//  ProjectTree
//
//  Created by lovepinyao on 16/8/24.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "UIColor+Extras.h"

@implementation UIColor (Extras)


+(UIColor *)mainColor{
    
    return [UIColor colorWithRed:0.2 green:0.3 blue:0.5 alpha:1.0];
}


+(UIColor *)randomColor{
    
   return [self randomColorWithAlpha:1.0];
}

+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha{
   
    CGFloat r = arc4random_uniform(255) / 255.0;
    CGFloat g = arc4random_uniform(255) / 255.0;
    CGFloat b = arc4random_uniform(255) / 255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}

+(UIColor *)colorWithHexValue:(unsigned long)hexValue{
  
    return [self colorWithHexValue:hexValue alpha:1.0];
}

+(UIColor *)colorWithHexValue:(unsigned long)hexValue alpha:(CGFloat)alpha{
    
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)hexValue{
    
    return [self colorWithHexString:hexValue alpha:1.0];
}

//支持 @"0xf3d65a"   @"#f3d65a"   @"f3d65a" 这三种格式
+ (UIColor *)colorWithHexString:(NSString *)hexValue alpha:(CGFloat)alpha{
    
    //删除字符串中的空格
    NSString *cString = [[hexValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6){
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"]){
        cString = [cString substringFromIndex:2];
    }
    
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"]){
        cString = [cString substringFromIndex:1];
    }
    
    if ([cString length] != 6){
        return [UIColor clearColor];
    }
   
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
   
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
    
}



@end
