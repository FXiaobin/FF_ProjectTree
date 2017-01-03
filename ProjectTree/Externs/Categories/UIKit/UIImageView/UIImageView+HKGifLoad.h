//
//  UIImageView+HKGifLoad.h
//  HKGifExample
//
//  Created by huangkuan01 on 15/8/7.
//  Copyright (c) 2015年 Widehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>
#import <CoreFoundation/CoreFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

@interface UIImageView (HKGifLoad)

- (instancetype)initWithGifImageName:(NSString *)gifImageName;
- (void)addGifImageWithName:(NSString *)gifImageName;

/**
 *  重启和暂停动画
 */
- (void)restoreAnimating;
- (void)pauseAnimating;

@end
