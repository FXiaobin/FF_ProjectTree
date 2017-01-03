//
//  UIView+Layer.h
//  ProjectTree
//
//  Created by lovepinyao on 16/9/8.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Layer)

//设置圆角
-(void)setCornerRadius:(CGFloat)cornerRadius;

//设置边框
-(void)setBorderColor:(UIColor *)color borderWidth:(CGFloat)width;

//设置阴影
-(void)setShadowWithColor:(UIColor *)color radius:(CGFloat)radius opacity:(CGFloat)opacity;
-(void)setShadowWithColor:(UIColor *)color radius:(CGFloat)radius offset:(CGSize)offset opacity:(CGFloat)opacity;

//重启和暂停动画
- (void)restoreAnimating;
- (void)pauseAnimating;

@end
