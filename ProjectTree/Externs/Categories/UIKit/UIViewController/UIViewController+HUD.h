//
//  UIViewController+HUD.h
//  ProjectTree
//
//  Created by lovepinyao on 16/9/26.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

//HUD样式配置
#define FF_HUD_ContentColor        [UIColor whiteColor]
#define FF_HUD_BezelViewColor      [UIColor blackColor]
#define FF_HUD_BackgoundStyle      MBProgressHUDBackgroundStyleBlur
#define FF_HUD_AnimationType       MBProgressHUDAnimationZoom

extern NSTimeInterval kFFHUDHideTimeInterval;

typedef NS_ENUM(NSUInteger, FFHUDImagesType) {
    FFHUDImagesTypeSuccessful,
    FFHUDImagesTypeError,
    FFHUDImagesTypeWarning,
    FFHUDImagesTypeInfo
};

@interface UIViewController (HUD)


///4中提示（自动隐藏）
- (MBProgressHUD *)showSuccess:(NSString *)tipText;
- (MBProgressHUD *)showError:(NSString *)tipText;
- (MBProgressHUD *)showWarning:(NSString *)tipText;
- (MBProgressHUD *)showInfo:(NSString *)tipText;

///加载显示（不自动隐藏）
- (MBProgressHUD *)showIndicatorHUDWithTitle:(NSString *)title animated:(BOOL)animated;
- (MBProgressHUD *)showIndicatorHUDWithTitle:(NSString *)title;
- (MBProgressHUD *)showGifHUDWithImageArray:(NSArray *)images title:(NSString *)title inView:(UIView *)view;

///隐藏HUD
- (void)hideHUD;
- (void)hideAfter:(NSTimeInterval)afterSecond;

///文本提示（不自动隐藏）
- (MBProgressHUD *)showTextTip:(NSString *)tipText;
///文本提示（自动隐藏）
- (MBProgressHUD *)showTextTip:(NSString *)tipText hideAfter:(NSTimeInterval)afterSecond;

///图片提示（自动隐藏）
- (MBProgressHUD *)showImageTip:(NSString *)tipText hideAfter:(NSTimeInterval)afterSecond msgType:(FFHUDImagesType)msgType;
- (NSString *)p_imageNamedWithMsgType:(FFHUDImagesType)msgType;
- (MBProgressHUD *)showImageTip:(NSString *)tipText hideAfter:(NSTimeInterval)afterSecond imageName:(NSString *)imageName;

///加载进度提示（需要调用update方法来更新进度，progress = 1.0时 自动隐藏）
- (MBProgressHUD *)showDeterminateHUD;
- (MBProgressHUD *)showDeterminateAnnularHUD;
- (MBProgressHUD *)showDeterminateBarHUD;
- (MBProgressHUD *)updateDeterminateHUDProgress:(CGFloat)progress;
- (void)updateDeterminateHUD:(MBProgressHUD *)hud progress:(CGFloat)progress;

///重设HUD的一些默认值
- (void)setHideTimeInterval:(NSTimeInterval)second fontSize:(CGFloat)fontSize;

@end
