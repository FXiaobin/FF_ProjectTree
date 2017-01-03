//
//  UIView+Animation.h
//  ProjectTree
//
//  Created by lovepinyao on 16/8/24.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animation)

- (void)rotationLoopRepeatAnimationWithDuration:(NSTimeInterval)duration;

- (void)postionMoveAnimationFrom:(CGPoint)from to:(CGPoint)to duration:(NSTimeInterval)duration;

- (void)shakeAnimationWithAngle:(CGFloat)angle duration:(NSTimeInterval)duration;

@end
