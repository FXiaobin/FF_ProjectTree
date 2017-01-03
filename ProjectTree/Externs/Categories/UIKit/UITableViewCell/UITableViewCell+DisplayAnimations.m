//
//  UITableViewCell+DisplayAnimations.m
//  ProjectTree
//
//  Created by lovepinyao on 16/9/21.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "UITableViewCell+DisplayAnimations.h"

@implementation UITableViewCell (DisplayAnimations)

/// 螺旋天梯状（DNA链状）
- (void)rotationTransform3DForCell{
    
    CATransform3D rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    self.layer.transform = rotation;
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOffset = CGSizeMake(10, 10);
    self.alpha = 0;
    //self.layer.anchorPoint = CGPointMake(0, 0.5);
    
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    self.layer.transform = CATransform3DIdentity;
    self.alpha = 1;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
}

/// 笔直的天梯
- (void)scaleAnimationForCell{
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.2, 0.2, 1)];
    scaleAnimation.toValue  = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [self.layer addAnimation:scaleAnimation forKey:@"transform"];
}

@end
