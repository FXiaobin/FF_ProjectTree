//
//  MBProgressHUD+ADD.m
//  CCPAFNNetworking
//
//  Created by DR on 16/9/9.
//  Copyright © 2016年 CCP. All rights reserved.
//

#import "MBProgressHUD+ADD.h"

@implementation MBProgressHUD (ADD)

+ (MBProgressHUD *)showInformation:(NSString *)information toView:(UIView *)view andAfterDelay:(float)afterDelay{
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
 
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    ;

    hud.mode = MBProgressHUDModeText;
    
    hud.label.text = information;
    
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    
    [hud hideAnimated:YES afterDelay:afterDelay];
    
   return hud;
    
}

+ (void)showCustomview:(UIView *)customview andTextString:(NSString *)textString toView:(UIView *)view andAfterDelay:(float)afterDelay{
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    
    hud.bezelView.color = [UIColor clearColor];
    
    hud.customView = customview;

    hud.square = YES;

    hud.label.text = textString;
    
    [hud hideAnimated:YES afterDelay:afterDelay];
    
}

/**
 *  隐藏 HUD
 */
+ (void) dissmissShowView:(UIView *)showView {
    
    if (showView == nil) {
        
        showView = (UIView*)[[[UIApplication sharedApplication]delegate]window];
        
    }
    
    [self hideHUDForView:showView animated:YES];
    
}

/**
 *  显示 HUD
 */

+ (instancetype) showHUDWithImageArr:(NSMutableArray *)imageArr andShowView:(UIView *)showView{
    
    if (showView == nil) {
        
        showView  = (UIView *)[[UIApplication sharedApplication].delegate window];
    }
    
    
    if (imageArr == nil) {
        
        return [self showHUDAddedTo:showView animated:YES];
        
    } else {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:showView animated:YES];
        
        hud.mode = MBProgressHUDModeCustomView;
        
        UIImageView *imaegCustomView = [[UIImageView alloc] init];
        imaegCustomView.animationImages = imageArr;
        [imaegCustomView setAnimationRepeatCount:0];
        [imaegCustomView setAnimationDuration:(imageArr.count + 1) * 0.075];
        [imaegCustomView startAnimating];
        
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        
        hud.bezelView.color = [UIColor clearColor];
        
        hud.customView = imaegCustomView;
        
        hud.square = NO;
        
        return hud;
        
    }
}

@end
