//
//  YCSlideView.h
//  youzer
//
//  Created by 王禹丞 on 15/12/16.
//  Copyright © 2015年 QXSX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCSlideView : UIView

@property (nonatomic,strong)NSArray * vcArray;

//是否一次性加载所有视图
@property (nonatomic,assign) BOOL isloadAll;

- (instancetype)initWithFrame:(CGRect)frame WithViewControllers:(NSArray *)viewControllers;

/*
 使用方法（菜单按钮平均分配）：
 NSArray *viewControllers = @[   @{@"Red" : [RedViewController new]},
                                 @{@"Yellow" : [YellowViewController new]},
                                 @{@"Blue" : [BlueViewController new]},
                                 @{@"Yellow" : [YellowViewController new]},
                                 @{@"Blue" : [BlueViewController new]}
                                 ];
 
 YCSlideView * view = [[YCSlideView alloc]initWithFrame:CGRectMake(0, 64, kWindowWidth, kWindowHeight - 64) WithViewControllers:viewControllers];
 
 [self.view addSubview:view];
 
 */

@end
