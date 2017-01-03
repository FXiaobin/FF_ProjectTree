//
//  FFSegmentedPageViewController.h
//  FFSegmentedPageController
//
//  Created by lovepinyao on 16/8/19.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FFSegmentedPageViewController;

@protocol FFSegmentedPageControllerDataSource <NSObject>

@required
- (NSInteger)numberOfViewControllers;
- (UIViewController *)viewControllerForIndex:(NSInteger)index;
- (NSString *)titleForTabAtIndex:(NSInteger)index;

@optional
- (UIView *)viewForTabAtIndex:(NSInteger)index;
- (CGFloat)tabHeight;
- (UIColor *)indicatorColor;
- (UIColor *)tabBackgroundColor;
- (UIFont *)titleFont;
- (UIColor *)titleColor;

@end

@protocol FFSegmentedPageControllerDelegate <NSObject>

@optional
- (void)tabPager:(FFSegmentedPageViewController *)tabPager didTransitionToTabAtIndex:(NSInteger)index;

@end

@interface FFSegmentedPageViewController : UIViewController

@property (weak, nonatomic) id<FFSegmentedPageControllerDataSource> dataSource;
@property (weak, nonatomic) id<FFSegmentedPageControllerDelegate> delegate;
//是否有底部bar
@property (assign, nonatomic) BOOL hasTabBar;

//是否一次性加载所有视图 默认为NO
@property (nonatomic,assign) BOOL isLoadAll;

- (void)reloadData;
- (NSInteger)selectedIndex;

- (void)selectTabbarIndex:(NSInteger)index;



@end
