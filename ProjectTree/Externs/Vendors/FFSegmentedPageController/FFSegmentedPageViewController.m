//
//  FFSegmentedPageViewController.m
//  FFSegmentedPageController
//
//  Created by lovepinyao on 16/8/19.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "FFSegmentedPageViewController.h"
#import "SGTopScrollMenu.h"

@interface FFSegmentedPageViewController ()<SGTopScrollMenuDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) SGTopScrollMenu *topScrollMenu;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *viewControllers;

@property (nonatomic,assign) NSInteger currentIndex;

@end

@implementation FFSegmentedPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //调整滚动视图和视图控制器的视图偏移错误的问题
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (self.navigationController.navigationBar) {
         self.navigationController.navigationBar.translucent = NO;
    }
    
    self.view.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1.0];
    self.viewControllers = [NSMutableArray array];
    self.titles = [NSMutableArray array];
    //默认选择第一个
    self.currentIndex = 0;
    
    [self initSubViews];
   
}

- (void)initSubViews{
 
    //1. 获取标题数组和控制器数组
    NSInteger count = [self.dataSource numberOfViewControllers];
    if (count) {
        for (int i = 0; i < count; i++) {
            NSString *title = [self.dataSource titleForTabAtIndex:i];
            [self.titles addObject:title];
            
            UIViewController *viewController = [self.dataSource viewControllerForIndex:i];
            [self.viewControllers addObject:viewController];
        }
    }
    
    //2. 添加所有子控制器
    for (UIViewController *viewController in self.viewControllers) {
        [self addChildViewController:viewController];
    }
    
    //3. 初始化顶部菜单 (菜单显示的所有设置都可以在这里来改变)
    CGFloat tabBarHeight = 44.0;
    if ([self.dataSource respondsToSelector:@selector(tabHeight)]) {
        tabBarHeight = [self.dataSource tabHeight];
    }
    self.topScrollMenu = [SGTopScrollMenu topScrollMenuWithFrame:CGRectMake(0, 0, self.view.frame.size.width, tabBarHeight)];
    self.topScrollMenu.menuBgColor = [self.dataSource tabBackgroundColor];
    self.topScrollMenu.titleSelectedColor = [self.dataSource titleColor];
    self.topScrollMenu.titleFont = [self.dataSource titleFont];
    self.topScrollMenu.indicatorColor = [self.dataSource indicatorColor];
    self.topScrollMenu.indicatorWidthStyle = IndicatorWidthStyleNormalWidth; //这里可以改变指示器的样式设置
    self.topScrollMenu.titleMargin = 15.0;
    self.topScrollMenu.isTitleBig = YES;
    
    //如果所有标题和间距加起来还没屏幕宽就让它等分显示
    CGFloat titleTotoalWidth = 0.0;
    for (int i = 0; i < self.titles.count; i++) {
        UIFont *font = [self.dataSource titleFont] ? [self.dataSource titleFont] : [UIFont systemFontOfSize:15.0];
        CGSize titleSize = [self.titles[i] boundingRectWithSize:CGSizeMake(self.view.bounds.size.width, 40.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
        titleTotoalWidth += (titleSize.width + 2 * 15.0);
    }
    
    if (titleTotoalWidth < self.view.frame.size.width) {
        self.topScrollMenu.isAverage = YES;
    }
    
    self.topScrollMenu.titlesArr = [NSArray arrayWithArray:_titles];
    self.topScrollMenu.topScrollMenuDelegate = self;
    [self.view addSubview:_topScrollMenu];
    
    //4. 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    CGFloat height = self.view.frame.size.height - tabBarHeight - 64.0;
    if (self.hasTabBar) {
        height -= 49.0;
    }
    _mainScrollView.frame = CGRectMake(0, tabBarHeight, self.view.frame.size.width, height);
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width * _titles.count, 0);
    _mainScrollView.backgroundColor = [UIColor clearColor];
    // 开启分页
    _mainScrollView.pagingEnabled = YES;
    // 没有弹簧效果
    _mainScrollView.bounces = NO;
    // 隐藏水平滚动条
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    // 设置代理
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];

    [self.view insertSubview:_mainScrollView belowSubview:_topScrollMenu];

    //5.选择当前页面 （这个在外面设置默认选择视图）
    //[self selectTabbarIndex:self.currentIndex];
    
    //一次性显示完
    if (self.isLoadAll) {
        for (int i = 0; i < self.viewControllers.count; i++) {
            [self showVc:i];
        }
    }
}

- (void)SGTopScrollMenu:(SGTopScrollMenu *)topScrollMenu didSelectTitleAtIndex:(NSInteger)index selectedTitle:(NSString *)selectedTitle     {
    //选中这一页
    [UIView animateWithDuration:0.2 animations:^{
        [self selectTabbarIndex:index];
    }];
}

// 显示控制器的view
- (void)showVc:(NSInteger)index {
    
    CGFloat offsetX = index * self.view.frame.size.width;
    
    UIViewController *vc = self.childViewControllers[index];
    
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    
    [self.mainScrollView addSubview:vc.view];
  
    vc.view.frame = CGRectMake(offsetX, 0, self.mainScrollView.frame.size.width, self.mainScrollView.frame.size.height);
}

#pragma mark - UIScrollViewDelegate
/*
 //这个是用来提前加载前一个视图或者后一个视图的 防止在滚动的时候视图还没有加载而出现空白
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //向右滑动0
    if (scrollView.contentOffset.x > scrollView.bounds.size.width * self.currentIndex) {
        // 1.添加子控制器view
        [self showVc:self.currentIndex];
        //并把它的下一个视图也要加载出来
        if (self.currentIndex < self.viewControllers.count-1) {
            [self showVc:self.currentIndex+1];
        }
        
    //向左滑动
    }else if ((scrollView.contentOffset.x < scrollView.bounds.size.width * self.currentIndex)) {
        //把它前面的那个也显示出来
        if (self.selectedIndex > 0) {
            [self showVc:self.selectedIndex - 1];
        }
    }
}
*/

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    // 选中这一页
    [self selectTabbarIndex:index];
}

-(void)reloadData{
   
    for (UIView *subView in self.view.subviews) {
        for (UIView *sView in subView.subviews) {
            [sView removeFromSuperview];
        }
        [subView removeFromSuperview];
    }
    
    [self.titles removeAllObjects];
    [self.viewControllers removeAllObjects];
    
    [self initSubViews];
}

-(NSInteger)selectedIndex{
    return self.currentIndex;
}

-(void)selectTabbarIndex:(NSInteger)index{
    self.currentIndex = index;

    // 1. 设置标题选中
    UILabel *selLabel = self.topScrollMenu.allTitleLabel[index];
    [self.topScrollMenu selectLabel:selLabel];
    
    // 2.让选中的标题居中
    [self.topScrollMenu setupTitleCenter:selLabel];
    
    // 3. 偏移到当前index并显示视图
    self.mainScrollView.contentOffset = CGPointMake(index * self.view.bounds.size.width, 0);
    
    // 4. 显示当前选中的视图
    if (self.isLoadAll == NO) {
        [self showVc:index];
    }
    
    // 5.代理
    if ([self.delegate respondsToSelector:@selector(tabPager:didTransitionToTabAtIndex:)]) {
        [self.delegate tabPager:self didTransitionToTabAtIndex:index];
    }
 
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
