//
//  CYCropView.h
//  CYImageCrop
//
//  Created by Cyrus on 16/6/9.
//  Copyright © 2016年 Cyrus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CYCropScaleType) {
    CYCropScaleTypeCustom,
    CYCropScaleTypeOriginal,
    CYCropScaleType1To1,
    CYCropScaleType3To2,
    CYCropScaleType2To3,
    CYCropScaleType4To3,
    CYCropScaleType3To4,
    CYCropScaleType16To9,
    CYCropScaleType9To16,
    CYCropScaleType1To2,
    CYCropScaleType2To1,
};

@interface CYCropView : UIView

#pragma mark - 功能

///是否禁用四个角的手势操作 (这个设置尽量放到所有设置的最下面) （自己修改添加的属性）
@property (nonatomic,assign) BOOL enableCornerGes;

/** 裁剪框的 frame */
@property (nonatomic, assign, readonly)CGRect cropFrame;

/** 裁剪框占据整个视图的位置比例（0，0，0，0）是左上角 （1，1，1，1）是右下角*/
@property (nonatomic, assign, readonly)CGRect cropFrameRatio;

/** 设置缩放的长宽比 */
@property (nonatomic, assign)CYCropScaleType scaleType;

/** 设置缩放的长宽比，以及是否进行动画 */
- (void)setScaleType:(CYCropScaleType)scaleType animated:(BOOL)animated;

/** 每次拖动裁剪框后的回调 */
@property (nonatomic, copy)void (^completionHandler) ();

#pragma mark - 外观

/** 裁剪框边框粗细 */
@property (nonatomic, assign)CGFloat borderWidth;
/** 遮罩层颜色 */
@property (nonatomic, strong)UIColor *maskColor;
/** 裁剪框最小边长 */
@property (nonatomic, assign)CGFloat minLenghOfSide;


@end











/*
    使用： 将系统UIimagePickerController的编辑模式设为NO，然后在代理方法didFinished方法中获取原图original（注意不是编辑后的图），然后用picker来present我们自定义的图片编辑控制器，这个控制器中就要用到此库来编辑图片了，当编辑完成的时候让这个视图控制器的代理来dismiss整个picker和这个控制器并回调编辑后的图片（此库可以获得截取的rect范围，需要自己用UIImage的类别方法来截取这个范围的图片）
 */


