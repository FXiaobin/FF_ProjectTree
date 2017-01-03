//
//  UIViewController+EmptyView.m
//  FFEmptyView
//
//  Created by lovepinyao on 16/9/29.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "UIViewController+EmptyView.h"
#import "FFEmptyView.h"

@implementation UIViewController (EmptyView)

-(void)showEmptyViewWithTipText:(NSString *)tipText iconName:(NSString *)iconName reloadBtnTitle:(NSString *)btnTitle reloadBtnActionBlock:(reloadBtnActionBlock)block{
    
    FFEmptyView *emptyView = [[FFEmptyView alloc] init];
    [emptyView showInView:self.view tipText:tipText iconName:iconName reloadBtnTitle:btnTitle];
    
    emptyView.reloadBtnBlock = ^(FFEmptyView *aEmptyView, UIButton *sender){
        block(aEmptyView, sender);
    };
 
}

-(void)updateFrameWithIconSize:(CGSize)iconSize{
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:[FFEmptyView class]]) {
            FFEmptyView *emptyView = (FFEmptyView *)subView;
            [emptyView updateFrameWithIconSize:iconSize];
        }
    }
}

-(void)updateReloadBtnSize:(CGSize)btnSize{
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:[FFEmptyView class]]) {
            FFEmptyView *emptyView = (FFEmptyView *)subView;
            [emptyView updateReloadBtnSize:btnSize];
        }
    }
}

-(void)removeEmptyView{
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:[FFEmptyView class]]) {
            FFEmptyView *emptyView = (FFEmptyView *)subView;
            for (UIView *eView in emptyView.subviews) {
                [eView removeFromSuperview];
            }
            [emptyView removeFromSuperview];
        }
    }
}

@end
