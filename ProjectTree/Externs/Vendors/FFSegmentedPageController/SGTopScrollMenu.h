//
//  SGTopScrollMenu.h
//  SGTopScrollMenu
//
//  Created by Sorgle on 16/8/14.
//  Copyright © 2016年 Sorgle. All rights reserved.
//

// 欢迎来Github上下载最完整的Demo
// Github下载地址 https://github.com/Hanymore/SGTopScrollMenu.git



#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, IndicatorWidthStyle) {
    
    IndicatorWidthStyleNormalWidth,      //默认宽度:          labelW - labelMargin * 2
    IndicatorWidthStyleTitleWidth,       //跟文字宽度一致      labelTitleW
    IndicatorWidthStyleLabelWidth        //跟Label宽度一致    labelW
    
};

@class SGTopScrollMenu;

@protocol SGTopScrollMenuDelegate <NSObject>

- (void)SGTopScrollMenu:(SGTopScrollMenu *)topScrollMenu didSelectTitleAtIndex:(NSInteger)index selectedTitle:(NSString *)selectedTitle;

@end

@interface SGTopScrollMenu : UIScrollView
/** 顶部标题数组 */
@property (nonatomic, strong) NSArray *titlesArr;
/** 存入所有Label */
@property (nonatomic, strong) NSMutableArray *allTitleLabel;

@property (nonatomic, weak) id<SGTopScrollMenuDelegate> topScrollMenuDelegate;

//标题颜色
@property (nonatomic, strong) UIColor *titleNormalColor;
@property (nonatomic, strong) UIColor *titleSelectedColor;
//标题字体
@property (nonatomic, strong) UIFont *titleFont;
//标题左右各距离label边距的大小 默认15.0
@property (nonatomic, assign) CGFloat titleMargin;
//菜单背景颜色
@property (nonatomic, strong) UIColor *menuBgColor;
//指示器颜色
@property (nonatomic, strong) UIColor *indicatorColor;
//指示器高度（默认2.0）
@property (nonatomic, assign) CGFloat indicatorHeight;
//指示器宽度样式
@property (nonatomic, assign) IndicatorWidthStyle indicatorWidthStyle;
//是否等分
@property (nonatomic, assign) BOOL isAverage;

//选中字体是否变大
@property (nonatomic, assign) BOOL isTitleBig;

/** 类方法 */
+ (instancetype)topScrollMenuWithFrame:(CGRect)frame;


/** 选中label标题的标题颜色改变以及指示器位置变化（只是为了让外界去调用）*/
- (void)selectLabel:(UILabel *)label;
/** 选中的标题居中（只是为了让外界去调用）*/
- (void)setupTitleCenter:(UILabel *)centerLabel;


@end


