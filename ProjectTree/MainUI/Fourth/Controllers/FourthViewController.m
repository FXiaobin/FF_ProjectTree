//
//  FourthViewController.m
//  ProjectTree
//
//  Created by lovepinyao on 16/8/17.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "FourthViewController.h"
#import "FFSegmentedPageViewController.h"

#import "HomeViewController.h"
#import "FifthViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface FourthViewController ()<FFSegmentedPageControllerDataSource,
FFSegmentedPageControllerDelegate>

@property (nonatomic,strong) NSArray *viewControlers;

@property (nonatomic,strong) NSArray *titles;

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];
    
    self.titles = @[@"首页",@"第二页",@"第四页",@"第5页"];
    
    HomeViewController *home = [[HomeViewController alloc] init];
    SecondViewController *svc = [[SecondViewController alloc] init];
    ThirdViewController *fvc = [[ThirdViewController alloc] init];
    FifthViewController *fav = [[FifthViewController alloc] init];
    
    self.viewControlers = @[home,svc,fvc,fav];
    
    FFSegmentedPageViewController *ffvc = [[FFSegmentedPageViewController alloc] init];
    //代理要提前设置好
    ffvc.delegate = self;
    ffvc.dataSource = self;
    ffvc.hasTabBar = YES;
    //ffvc.isLoadAll = YES;   //一次性加载所有视图
    
    [self addChildViewController:ffvc];
    [self.view addSubview:ffvc.view];
    ffvc.view.frame = self.view.bounds;
    
    //当isLoadAll属性设置为NO的时候必须要设置默认选中视图
    [ffvc selectTabbarIndex:0];
    
}

- (NSInteger)numberOfViewControllers{
    return self.titles.count;
}

- (UIViewController *)viewControllerForIndex:(NSInteger)index{
    return self.viewControlers[index];
}

- (NSString *)titleForTabAtIndex:(NSInteger)index{
    return self.titles[index];
}

- (CGFloat)tabHeight{
    return 44.0;
}

- (UIColor *)indicatorColor{
    return [UIColor orangeColor];
}

- (UIColor *)tabBackgroundColor{
    return [UIColor whiteColor];
}

- (UIFont *)titleFont{
    return [UIFont systemFontOfSize:15.0];
}

- (UIColor *)titleColor{
    return [UIColor orangeColor];
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
