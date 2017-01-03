//
//  UINavigationBar+BarAlpha.m
//  PublicDrugComment-OC
//
//  Created by TaoYingjun on 15/10/12.
//  Copyright © 2015年 Shanghai Xuanyao Network Technology Co., Ltd. All rights reserved.
//

#import "UINavigationBar+BarAlpha.h"

@implementation UINavigationBar (BarAlpha)

- (void)setBackgroundAlpha:(CGFloat)alpha {
    UIView *backgroundView = self.subviews[0];
    if(alpha >= 0 && alpha <= 1) {
//        [UIView animateWithDuration:0.35 animations:^{
//            
//        }];

        backgroundView.alpha = alpha;

    }
}

- (void)setNavigationBarAlpha:(CGFloat)alpha{
    
    for (UIView *subViews in self.subviews) {
        if ([subViews isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
            if(alpha >= 0 && alpha <= 1) {
                subViews.alpha = alpha;
            }else{
                subViews.alpha = 1.0;
            }
        }
    }
}

@end
