//
//  MBProgressHUD+ADD.h
//  CCPAFNNetworking
//
//  Created by DR on 16/9/9.
//  Copyright © 2016年 CCP. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (ADD)
/**
 *  信息提示
 *  @param information 提示文字
 *  @param view        HUD展示的view
 *  @param afterDelay  展示的时间
 */
+ (MBProgressHUD *)showInformation:(NSString *)information toView:(UIView *)view andAfterDelay:(float)afterDelay;

/**
 *  自定义view
 *  @param customview 自定义的view
 *  @param textString 提示文字
 *  @param view       HUD展示的view
 *  @param afterDelay 展示时间
 */
+ (void)showCustomview:(UIView *)customview andTextString:(NSString *)textString toView:(UIView *)view andAfterDelay:(float)afterDelay;


/**
 *  隐藏 HUD
 */
+ (void) dissmissShowView:(UIView *)showView;

/**
 *  显示 HUD
 *
 *  iamgeArr 为 loading 图片数组，如果为nil 则为默认的loading样式
 */
+ (instancetype) showHUDWithImageArr:(NSMutableArray *)imageArr andShowView:(UIView *)showView;

@end
