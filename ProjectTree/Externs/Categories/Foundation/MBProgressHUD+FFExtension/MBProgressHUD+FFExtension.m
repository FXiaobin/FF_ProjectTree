//
//  MBProgressHUD+FFExtension.m
//  ProjectTree
//
//  Created by lovepinyao on 16/9/26.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "MBProgressHUD+FFExtension.h"

NSString * const kFFMBProgressHUDMsgLoading = @"正在下载，请稍后...";

NSTimeInterval kFFMBProgressHUDHideTimeInterval = 2.0f;

static CGFloat FONT_SIZE = 14.0f;

@implementation MBProgressHUD (FFExtension)

+ (MBProgressHUD *)showSuccess:(NSString *)tipText inView:(UIView *)view{
    [self hideHUDForView:view animated:YES];
    return [self showImageTip:tipText toView:view hideAfter:kFFMBProgressHUDHideTimeInterval msgType:FFMBProgressHUDImagesTypeSuccessful];
}

+ (MBProgressHUD *)showError:(NSString *)tipText inView:(UIView *)view{
    [self hideHUDForView:view animated:YES];
    return [self showImageTip:tipText toView:view hideAfter:kFFMBProgressHUDHideTimeInterval msgType:FFMBProgressHUDImagesTypeError];
}

+ (MBProgressHUD *)showWarning:(NSString *)tipText inView:(UIView *)view{
    [self hideHUDForView:view animated:YES];
    return [self showImageTip:tipText toView:view hideAfter:kFFMBProgressHUDHideTimeInterval msgType:FFMBProgressHUDImagesTypeWarning];
}

+ (MBProgressHUD *)showInfo:(NSString *)tipText inView:(UIView *)view{
    [self hideHUDForView:view animated:YES];
    return [self showImageTip:tipText toView:view hideAfter:kFFMBProgressHUDHideTimeInterval msgType:FFMBProgressHUDImagesTypeInfo];
}

+ (void)styleWithHUD:(MBProgressHUD *)HUD{
    //模糊风格 另一种是纯色
    HUD.bezelView.style = HUD_BackgoundStyle;
    HUD.animationType = HUD_AnimationType;
    HUD.bezelView.color = HUD_BezelViewColor;
    HUD.contentColor = HUD_ContentColor;
}

+ (MBProgressHUD *)showIndicatorHUDAddedTo:(UIView *)view title:(NSString *)title animated:(BOOL)animated {
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:animated];
    HUD.label.font = [UIFont systemFontOfSize:FONT_SIZE];
    HUD.label.text = title;
   
    [self styleWithHUD:HUD];
    
    return HUD;
}

+ (MBProgressHUD *)showIndicatorHUDAddedTo:(UIView *)view title:(NSString *)title {
    return [self showIndicatorHUDAddedTo:view title:title animated:YES];
}

+ (MBProgressHUD *)showGifHUDWithImageArray:(NSArray *)images title:(NSString *)title inView:(UIView *)view{
    
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

+ (MBProgressHUD *)hideHUDFromView:(UIView *)view after:(NSTimeInterval)interval{
   
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    //hud.label.font = [UIFont systemFontOfSize:16.0];
    [hud hideAfter:interval];
    return hud;
}

-(void)hideHUD{
    [self hideAfter:0.0];
}

- (void)hideAfter:(NSTimeInterval)afterSecond {
    self.animationType = HUD_AnimationType;
    [self hideAnimated:YES afterDelay:afterSecond];
}

+ (MBProgressHUD *)showTextTip:(NSString *)tipText toView:(UIView *)view{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.label.font = [UIFont systemFontOfSize:FONT_SIZE];
    HUD.label.text = tipText;
    [self styleWithHUD:HUD];
    
    return HUD;
}

+ (MBProgressHUD *)showTextTip:(NSString *)tipText toView:(UIView *)view hideAfter:(NSTimeInterval)afterSecond {
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.label.font = [UIFont systemFontOfSize:FONT_SIZE];
    HUD.label.text = tipText;
    [self styleWithHUD:HUD];
    [HUD hideAnimated:YES afterDelay:afterSecond];
    return HUD;
}

+ (MBProgressHUD *)showImageTip:(NSString *)tipText
                          toView:(UIView *)view
                       hideAfter:(NSTimeInterval)afterSecond
                         msgType:(FFMBProgressHUDImagesType)msgType {
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];

    HUD.label.font = [UIFont systemFontOfSize:FONT_SIZE];
    
    NSString *imageNamed = [self p_imageNamedWithMsgType:msgType];
    
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNamed]];
    HUD.label.text = tipText;
    
    [self styleWithHUD:HUD];
    
    [HUD hideAnimated:YES afterDelay:afterSecond];
    return HUD;
    
}

+ (NSString *)p_imageNamedWithMsgType:(FFMBProgressHUDImagesType)msgType {
    NSString *imageNamed = nil;
    if (msgType == FFMBProgressHUDImagesTypeSuccessful) {
        imageNamed = @"ff_hud_success";
    } else if (msgType == FFMBProgressHUDImagesTypeError) {
        imageNamed = @"ff_hud_error";
    } else if (msgType == FFMBProgressHUDImagesTypeWarning) {
        imageNamed = @"ff_hud_warning";
    } else if (msgType == FFMBProgressHUDImagesTypeInfo) {
        imageNamed = @"ff_hud_info";
    }
    return imageNamed;
}

+ (MBProgressHUD *)showImageTip:(NSString *)tipText toView:(UIView *)view
                      hideAfter:(NSTimeInterval)afterSecond imageName:(NSString *)imageName{
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.label.font = [UIFont systemFontOfSize:FONT_SIZE];

    HUD.mode = MBProgressHUDModeCustomView;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    HUD.label.text = tipText;
    
    [self styleWithHUD:HUD];
    
    [HUD hideAnimated:YES afterDelay:afterSecond];
    return HUD;

}

+ (MBProgressHUD *)showDeterminateHUDTo:(UIView *)view {
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = MBProgressHUDModeDeterminate;
    HUD.animationType = MBProgressHUDAnimationZoom;
    HUD.label.text = kFFMBProgressHUDMsgLoading;
    HUD.label.font = [UIFont systemFontOfSize:FONT_SIZE];
    HUD.progress = 0.0;
    
    [self styleWithHUD:HUD];
    
    return HUD;
}

+ (MBProgressHUD *)showDeterminateAnnularHUDTo:(UIView *)view {
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = MBProgressHUDModeAnnularDeterminate;
    HUD.animationType = MBProgressHUDAnimationZoom;
    //HUD.label.text = kFFMBProgressHUDMsgLoading;
    //HUD.label.font = [UIFont systemFontOfSize:FONT_SIZE];
    HUD.progress = 0.0;
    
    [self styleWithHUD:HUD];
    
    return HUD;
}

+ (MBProgressHUD *)showDeterminateBarHUDTo:(UIView *)view {
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
    HUD.animationType = MBProgressHUDAnimationZoom;
    HUD.label.text = kFFMBProgressHUDMsgLoading;
    HUD.label.font = [UIFont systemFontOfSize:FONT_SIZE];
    HUD.progress = 0.0;
    
    [self styleWithHUD:HUD];
    
    return HUD;
}

+ (MBProgressHUD *)updateProgress:(CGFloat)progress inView:(UIView *)view{
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    hud.progress = progress;
    if (progress >= 1.0) {
        [self hideHUDForView:view animated:YES];
    }
    return hud;
}

+ (void)updateDeterminateHUD:(MBProgressHUD *)hud progress:(CGFloat)progress{
    [self updateDeterminateHUD:hud progress:progress inView:nil];
}

+ (void)updateDeterminateHUD:(MBProgressHUD *)hud progress:(CGFloat)progress inView:(UIView *)view{
    hud.progress = progress;
    
    if (progress >= 1.0) {
        [hud hideHUD];
        if (view) {
            [self showImageTip:@"下载完成" toView:view hideAfter:kFFMBProgressHUDHideTimeInterval msgType:FFMBProgressHUDImagesTypeSuccessful];
        }
    }
}

+ (void)setHideTimeInterval:(NSTimeInterval)second fontSize:(CGFloat)fontSize {
    kFFMBProgressHUDHideTimeInterval = second;
    FONT_SIZE = fontSize;
}


@end
