//
//  UIViewController+HUD.m
//  ProjectTree
//
//  Created by lovepinyao on 16/9/26.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "UIViewController+HUD.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

NSString * const kFFHUDMsgLoading = @"正在下载，请稍后...";
NSTimeInterval kFFHUDHideTimeInterval = 2.0f;

static CGFloat FONT_SIZE = 14.0f;


@implementation UIViewController (HUD)


- (MBProgressHUD *)showSuccess:(NSString *)tipText{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    return [self showImageTip:tipText hideAfter:kFFHUDHideTimeInterval msgType:FFHUDImagesTypeSuccessful];
}

- (MBProgressHUD *)showError:(NSString *)tipText {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    return [self showImageTip:tipText hideAfter:kFFHUDHideTimeInterval msgType:FFHUDImagesTypeError];
}

- (MBProgressHUD *)showWarning:(NSString *)tipText{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    return [self showImageTip:tipText hideAfter:kFFHUDHideTimeInterval msgType:FFHUDImagesTypeWarning];
}

- (MBProgressHUD *)showInfo:(NSString *)tipText{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    return [self showImageTip:tipText hideAfter:kFFHUDHideTimeInterval msgType:FFHUDImagesTypeInfo];
}

- (void)styleWithHUD:(MBProgressHUD *)HUD{
    //模糊风格 另一种是纯色
    HUD.bezelView.style = FF_HUD_BackgoundStyle;
    HUD.animationType = FF_HUD_AnimationType;
    HUD.bezelView.color = FF_HUD_BezelViewColor;
    HUD.contentColor = FF_HUD_ContentColor;
}

- (MBProgressHUD *)showIndicatorHUDWithTitle:(NSString *)title animated:(BOOL)animated {
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:animated];
    HUD.label.font = [UIFont systemFontOfSize:FONT_SIZE];
    HUD.label.text = title;
    
    [self styleWithHUD:HUD];
    
    return HUD;
}

- (MBProgressHUD *)showIndicatorHUDWithTitle:(NSString *)title {
    return [self showIndicatorHUDWithTitle:title animated:YES];
}

- (MBProgressHUD *)showGifHUDWithImageArray:(NSArray *)images title:(NSString *)title inView:(UIView *)view{
    
    if (images.count == 0) {
        return nil;
    }
    
    NSMutableArray *imageArr = [NSMutableArray arrayWithCapacity:images.count];
    for (NSString *imageName in images) {
        UIImage *image = [UIImage imageNamed:imageName];
        [imageArr addObject:image];
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    if (title.length) {
        hud.label.text = title;
    }
    
    UIImageView *imaegCustomView = [[UIImageView alloc] init];
    imaegCustomView.animationImages = imageArr;
    [imaegCustomView setAnimationRepeatCount:0];
    [imaegCustomView setAnimationDuration:(imageArr.count + 1) * 0.075];
    [imaegCustomView startAnimating];
    
    hud.customView = imaegCustomView;
    hud.square = NO;
    [self styleWithHUD:hud];
    
    return hud;
}

- (void)hideHUD{
    [self hideAfter:0.0];
}

- (void)hideAfter:(NSTimeInterval)afterSecond {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
    hud.animationType = FF_HUD_AnimationType;
    [hud hideAnimated:YES afterDelay:afterSecond];
}

- (MBProgressHUD *)showTextTip:(NSString *)tipText{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.label.font = [UIFont systemFontOfSize:FONT_SIZE];
    HUD.label.text = tipText;
    [self styleWithHUD:HUD];
    
    return HUD;
}

- (MBProgressHUD *)showTextTip:(NSString *)tipText hideAfter:(NSTimeInterval)afterSecond {
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.label.font = [UIFont systemFontOfSize:FONT_SIZE];
    HUD.label.text = tipText;
    [self styleWithHUD:HUD];
    [HUD hideAnimated:YES afterDelay:afterSecond];
    return HUD;
}

- (MBProgressHUD *)showImageTip:(NSString *)tipText
                      hideAfter:(NSTimeInterval)afterSecond
                        msgType:(FFHUDImagesType)msgType {
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    HUD.label.font = [UIFont systemFontOfSize:FONT_SIZE];
    
    NSString *imageNamed = [self p_imageNamedWithMsgType:msgType];
    
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNamed]];
    HUD.label.text = tipText;
    
    [self styleWithHUD:HUD];
    
    [HUD hideAnimated:YES afterDelay:afterSecond];
    return HUD;
    
}

- (NSString *)p_imageNamedWithMsgType:(FFHUDImagesType)msgType {
    NSString *imageNamed = nil;
    if (msgType == FFHUDImagesTypeSuccessful) {
        imageNamed = @"ff_hud_success";
    } else if (msgType == FFHUDImagesTypeError) {
        imageNamed = @"ff_hud_error";
    } else if (msgType == FFHUDImagesTypeWarning) {
        imageNamed = @"ff_hud_warning";
    } else if (msgType == FFHUDImagesTypeInfo) {
        imageNamed = @"ff_hud_info";
    }
    return imageNamed;
}

- (MBProgressHUD *)showImageTip:(NSString *)tipText hideAfter:(NSTimeInterval)afterSecond imageName:(NSString *)imageName{
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.label.font = [UIFont systemFontOfSize:FONT_SIZE];
    
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    HUD.label.text = tipText;
    //[HUD setOffset:CGPointMake(0, 50)];
    
    [self styleWithHUD:HUD];
    
    [HUD hideAnimated:YES afterDelay:afterSecond];
    return HUD;
    
}

- (MBProgressHUD *)showDeterminateHUD {
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.mode = MBProgressHUDModeDeterminate;
    HUD.animationType = MBProgressHUDAnimationZoom;
    HUD.label.text = kFFHUDMsgLoading;
    HUD.label.font = [UIFont systemFontOfSize:FONT_SIZE];
    HUD.progress = 0.0;
    
    [self styleWithHUD:HUD];
    
    return HUD;
}

- (MBProgressHUD *)showDeterminateAnnularHUD{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.mode = MBProgressHUDModeAnnularDeterminate;
    HUD.animationType = MBProgressHUDAnimationZoom;
    //HUD.label.text = kFFMBProgressHUDMsgLoading;
    //HUD.label.font = [UIFont systemFontOfSize:FONT_SIZE];
    HUD.progress = 0.0;
    
    [self styleWithHUD:HUD];
    
    return HUD;
}

- (MBProgressHUD *)showDeterminateBarHUD{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
    HUD.animationType = MBProgressHUDAnimationZoom;
    HUD.label.text = kFFHUDMsgLoading;
    HUD.label.font = [UIFont systemFontOfSize:FONT_SIZE];
    HUD.progress = 0.0;
    
    [self styleWithHUD:HUD];
    
    return HUD;
}

- (MBProgressHUD *)updateDeterminateHUDProgress:(CGFloat)progress{
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
    hud.progress = progress;
    if (progress >= 1.0) {
        [self hideAfter:0.5];
    }
    return hud;
}

- (void)updateDeterminateHUD:(MBProgressHUD *)hud progress:(CGFloat)progress{
    hud.progress = progress;
    if (progress >= 1.0) {
        [self hideAfter:0.5];
    }
}

- (void)setHideTimeInterval:(NSTimeInterval)second fontSize:(CGFloat)fontSize {
    kFFHUDHideTimeInterval = second;
    FONT_SIZE = fontSize;
}


@end
