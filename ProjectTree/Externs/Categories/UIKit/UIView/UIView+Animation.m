//
//  UIView+Animation.m
//  ProjectTree
//
//  Created by lovepinyao on 16/8/24.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

//duration：转一圈所用的时间
- (void)rotationLoopRepeatAnimationWithDuration:(NSTimeInterval)duration{
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = CGFLOAT_MAX;
    
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)postionMoveAnimationFrom:(CGPoint)from to:(CGPoint)to duration:(NSTimeInterval)duration{
    
    CABasicAnimation* postionAnimation;
    postionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    postionAnimation.fromValue = [NSValue valueWithCGPoint:from];
    postionAnimation.toValue = [NSValue valueWithCGPoint:to];
    postionAnimation.duration = duration;
    postionAnimation.repeatCount = 1;
    postionAnimation.fillMode = kCAFillModeForwards;
    postionAnimation.removedOnCompletion = NO;
    
    [self.layer addAnimation:postionAnimation forKey:@"positionAnimation"];
}

- (void)shakeAnimationWithAngle:(CGFloat)angle duration:(NSTimeInterval)duration{

    CAKeyframeAnimation *keyAnima = [CAKeyframeAnimation animation];
    keyAnima.keyPath = @"transform.rotation";
    keyAnima.duration = duration;
    //把度数转换为弧度  度数/180*M_PI
    keyAnima.values=@[@(-(angle)/180.0*M_PI), @((angle)/180.0*M_PI), @(-(angle)/180.0*M_PI)];
    keyAnima.repeatCount=MAXFLOAT;
    keyAnima.fillMode=kCAFillModeForwards;
    keyAnima.removedOnCompletion=NO;

    [self.layer addAnimation:keyAnima forKey:nil];
}

@end
