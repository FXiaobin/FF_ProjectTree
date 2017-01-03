//
//  UIViewController+EmptyView.h
//  FFEmptyView
//
//  Created by lovepinyao on 16/9/29.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FFEmptyView;

typedef void(^reloadBtnActionBlock)(FFEmptyView *aEmptyView, UIButton *sender);

@interface UIViewController (EmptyView)

///显示空白视图
- (void)showEmptyViewWithTipText:(NSString *)tipText iconName:(NSString *)iconName reloadBtnTitle:(NSString *)btnTitle reloadBtnActionBlock:(reloadBtnActionBlock)block;

///重新布局子视图（图片宽高比不是2:1的时候需要调用此方法来重新布局子视图）
- (void)updateFrameWithIconSize:(CGSize)iconSize;

///设置按钮大小
- (void)updateReloadBtnSize:(CGSize)btnSize;

///移除空白视图
- (void)removeEmptyView;

@end
