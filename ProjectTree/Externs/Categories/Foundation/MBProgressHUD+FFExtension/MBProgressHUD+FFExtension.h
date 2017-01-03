//
//  MBProgressHUD+FFExtension.h
//  ProjectTree
//
//  Created by lovepinyao on 16/9/26.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "MBProgressHUD.h"

//HUD使用
#define AlertSuccess(text)          [MBProgressHUD showSuccess:text inView:self.view];
#define AlertError(text)            [MBProgressHUD showError:text inView:self.view];
#define AlertInfo(text)             [MBProgressHUD showInfo:text inView:self.view];
#define AlertWarning(text)          [MBProgressHUD showWarning:text inView:self.view];
#define AlertText(text)             [MBProgressHUD showTextTip:text toView:self.view hideAfter:2.0];
#define AlertCustom(text,imgName)   [MBProgressHUD showImageTip:text toView:self.view hideAfter:2.0 imageName:imgName];

#define ShowLoadingHUD          [MBProgressHUD showIndicatorHUDAddedTo:self.view title:@"奋力加载中..."];
#define ShowLoadHUD(text)       [MBProgressHUD showIndicatorHUDAddedTo:self.view title:text];
#define ShowTextHUD(text)       [MBProgressHUD showTextTip:text toView:self.view];
#define ShowGifHUD(images,text) [MBProgressHUD showGifHUDWithImageArray:images title:text inView:self.view];

#define HiddenLoadingHUD                [MBProgressHUD hideHUDForView:self.view animated:YES];
#define HiddenHUDAfter(timeInterval)    [MBProgressHUD hideHUDFromView:self.view after:timeInterval];

//#define ShowImageLoadHUD              [MBProgressHUD showDeterminateHUDTo:self.view];
#define ShowImageLoadHUD                [MBProgressHUD showDeterminateAnnularHUDTo:self.view];
#define UpdateHUDProgress(progress)     [MBProgressHUD updateProgress:progress inView:self.view];

//HUD样式配置
#define HUD_ContentColor        [UIColor whiteColor]
#define HUD_BezelViewColor      [UIColor blackColor]
#define HUD_BackgoundStyle      MBProgressHUDBackgroundStyleBlur
#define HUD_AnimationType       MBProgressHUDAnimationZoom


@interface MBProgressHUD (FFExtension)

extern NSTimeInterval kFFMBProgressHUDHideTimeInterval;

typedef NS_ENUM(NSUInteger, FFMBProgressHUDImagesType) {
    FFMBProgressHUDImagesTypeSuccessful,
    FFMBProgressHUDImagesTypeError,
    FFMBProgressHUDImagesTypeWarning,
    FFMBProgressHUDImagesTypeInfo
};


///成功提示
+ (MBProgressHUD *)showSuccess:(NSString *)tipText inView:(UIView *)view;
///失败提示
+ (MBProgressHUD *)showError:(NSString *)tipText inView:(UIView *)view;
///警告提示
+ (MBProgressHUD *)showWarning:(NSString *)tipText inView:(UIView *)view;
///失败提示
+ (MBProgressHUD *)showInfo:(NSString *)tipText inView:(UIView *)view;


/// 添加一个带菊花的HUD
+ (MBProgressHUD *)showIndicatorHUDAddedTo:(UIView *)view title:(NSString *)title;
+ (MBProgressHUD *)showIndicatorHUDAddedTo:(UIView *)view title:(NSString *)title animated:(BOOL)animated;
/// 添加一个动画HUD
+ (MBProgressHUD *)showGifHUDWithImageArray:(NSArray *)images title:(NSString *)title inView:(UIView *)view;

/// 隐藏HUD
- (void)hideHUD;
- (void)hideAfter:(NSTimeInterval)afterSecond;
+ (MBProgressHUD *)hideHUDFromView:(UIView *)view after:(NSTimeInterval)interval;


/// 显示一个文本提示HUD
+ (MBProgressHUD *)showTextTip:(NSString *)tipText toView:(UIView *)view;  //不自动隐藏
+ (MBProgressHUD *)showTextTip:(NSString *)tipText toView:(UIView *)view hideAfter:(NSTimeInterval)afterSecond;
/// 显示一个图片提示HUD
+ (MBProgressHUD *)showImageTip:(NSString *)tipText toView:(UIView *)view hideAfter:(NSTimeInterval)afterSecond
                    imageName:(NSString *)imageName;

/// 显示一个渐进式的HUD
+ (MBProgressHUD *)showDeterminateHUDTo:(UIView *)view;
+ (MBProgressHUD *)showDeterminateBarHUDTo:(UIView *)view;
+ (MBProgressHUD *)showDeterminateAnnularHUDTo:(UIView *)view;

/// 更新HUD进度
+ (MBProgressHUD *)updateProgress:(CGFloat)progress inView:(UIView *)view;
+ (void)updateDeterminateHUD:(MBProgressHUD *)hud progress:(CGFloat)progress;
+ (void)updateDeterminateHUD:(MBProgressHUD *)hud progress:(CGFloat)progress inView:(UIView *)view;


/** 配置本扩展的默认参数 */
+ (void)setHideTimeInterval:(NSTimeInterval)second fontSize:(CGFloat)fontSize;

@end
