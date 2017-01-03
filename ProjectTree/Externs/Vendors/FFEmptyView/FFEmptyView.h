//
//  FFEmptyView.h
//  FFEmptyView
//
//  Created by lovepinyao on 16/9/1.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FFEmptyView;

typedef void(^reloadBtnActionBlock)(FFEmptyView *aEmptyView, UIButton *sender);

@interface FFEmptyView : UIView

@property (nonatomic,strong) UIImageView *emptyIcon;

@property (nonatomic,strong) UILabel *tipLabel;

@property (nonatomic,strong) UIButton *reloadBtn;

@property (nonatomic,copy) reloadBtnActionBlock reloadBtnBlock;


//重新布局子视图（图片宽高比不是2:1的时候需要调用此方法来重新布局子视图）
- (void)updateFrameWithIconSize:(CGSize)iconSize;
//设置按钮大小
- (void)updateReloadBtnSize:(CGSize)btnSize;

//初始化
-(void)showInView:(UIView *)showView tipText:(NSString *)tipText iconName:(NSString *)iconName reloadBtnTitle:(NSString *)btnTitle;

@end
