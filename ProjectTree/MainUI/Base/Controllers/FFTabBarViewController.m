//
//  FFTabBarViewController.m
//  ProjectTree
//
//  Created by lovepinyao on 16/8/17.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "FFTabBarViewController.h"

#import "HomeViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FifthViewController.h"

#import "BaseNavigationController.h"

@interface FFTabBarViewController ()

@end

@implementation FFTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initViewControllers];
    
    
    
}

- (void)initViewControllers{
    
    NSArray *titleArr = @[@"首页",@"第二页",@"",@"第四页",@"第五页"];
    NSArray *itemIconArr = @[@"main_page",@"main_page",@"order_alixPay_normal",@"main_page",@"main_page"];
    
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:titleArr.count];
    NSArray *viewControllNames = @[@"HomeViewController",@"SecondViewController",@"ThirdViewController",@"FourthViewController",@"FifthViewController"];
    
    for (int i = 0; i < viewControllNames.count; i++) {
        Class cls = NSClassFromString(viewControllNames[i]);
        UIViewController *viewController = [[cls alloc] init];
        viewController.navigationItem.title = titleArr[i];
        
        //BaseNavigationController *navigationController = [[BaseNavigationController alloc] initWithRootViewController:viewController];
      
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:titleArr[i] image:[UIImage imageNamed:itemIconArr[i]] selectedImage:[UIImage imageNamed:[titleArr[i] stringByAppendingString:@"_selected"]]];
        tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
        tabBarItem.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0);
        
        if (i == 2) {
            //tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
            tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        }
        
        navigationController.tabBarItem = tabBarItem;
        
        [viewControllers addObject:navigationController];
    }
    
    self.tabBar.tintColor = MAIN_COLOR;
    self.tabBar.barTintColor = BG_COLOR;

    
    self.viewControllers = viewControllers;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
