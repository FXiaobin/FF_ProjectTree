//
//  FFWelcomeViewController.h
//  welcomePage
//
//  Created by lovepinyao on 16/8/29.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFWelcomeViewController : UIViewController

-(instancetype)initWithImages:(NSArray *)images isShowPageControl:(BOOL)isShow;

@property (nonatomic,copy) void (^welcomePageAfterSetRootViewControllerBlock) (FFWelcomeViewController *);

@end
