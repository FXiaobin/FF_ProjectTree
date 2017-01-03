//
//  UIImageView+PopAnimation.m
//  Doubi
//
//  Created by TaoYingjun on 14/10/18.
//  Copyright (c) 2014年 www.d-bi.cn. All rights reserved.
//

#import "UIImageView+PopAnimation.h"
#import <POP.h>

@implementation UIImageView (PopAnimation)

//依赖pop第三方库
- (void)addPopAnimation {
    [self scaleToSmall];
}

- (void)scaleToSmall
{
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.8f, 0.8f)];
    scaleAnimation.duration = 0.1;
    [scaleAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        [self scaleAnimation];
    }];
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSmallAnimation"];
}

- (void)scaleAnimation
{
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(5.f, 5.f)];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scaleAnimation.springBounciness = 18.0f;
    
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSpringAnimation"];
}


@end
