//
//  UIView+Layer.m
//  ProjectTree
//
//  Created by lovepinyao on 16/9/8.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "UIView+Layer.h"

@implementation UIView (Layer)

-(void)setCornerRadius:(CGFloat)cornerRadius{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}

-(void)setBorderColor:(UIColor *)color borderWidth:(CGFloat)width{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

-(void)setShadowWithColor:(UIColor *)color radius:(CGFloat)radius offset:(CGSize)offset opacity:(CGFloat)opacity{
    self.layer.shadowColor = color.CGColor;
    self.layer.cornerRadius = radius;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
}

-(void)setShadowWithColor:(UIColor *)color radius:(CGFloat)radius opacity:(CGFloat)opacity{
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
}

- (void)restoreAnimating{
    CFTimeInterval pausedTime = [self.layer timeOffset];
    self.layer.speed = 1.0;
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.layer.beginTime = timeSincePause;
}

- (void)pauseAnimating{
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0.0;
    self.layer.timeOffset = pausedTime;
}



@end
