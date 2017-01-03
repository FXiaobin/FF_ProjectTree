//
//  FFWelcomeViewController.m
//  welcomePage
//
//  Created by lovepinyao on 16/8/29.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "FFWelcomeViewController.h"

#define ImageViewTag            5256756277

/*
    在这里可以修改配置数据
 */
#define IndicatorColor          [UIColor grayColor]
#define CurrentPageColor        [UIColor whiteColor]
#define PageControlBottomY      70.0
#define PageControlHeight       40.0

#define ButtomBottomeY          120.0
#define ButtonWidth             160.0
#define ButtonHeight            30.0
#define ButtonTitle             @"立即体验"



@interface FFWelcomeViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UIPageControl *pageControl;

@property (nonatomic,strong) NSArray *imageArr;

@property (nonatomic,assign) BOOL isShow;

@end

@implementation FFWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

-(instancetype)initWithImages:(NSArray *)images isShowPageControl:(BOOL)isShow{
    if (self = [super init]) {
        self.imageArr = images;
        self.isShow = isShow;
        [self createScrollView];
    }
    return self;
}

- (void)createScrollView{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * self.imageArr.count, 0);
    
    [self.view addSubview:self.scrollView];
    
    for (int i = 0; i < self.imageArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        imageView.tag = ImageViewTag + i;
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:self.imageArr[i]];
        
        if (i == self.imageArr.count - 1) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - ButtonWidth) / 2.0, [UIScreen mainScreen].bounds.size.height - ButtomBottomeY, ButtonWidth, ButtonHeight);
            button.backgroundColor = [UIColor clearColor];
            button.layer.borderColor = [UIColor whiteColor].CGColor;
            button.layer.borderWidth = 0.5;
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = 15.0;
            [button setTitle:ButtonTitle forState:UIControlStateNormal];
            [button addTarget:self action:@selector(comeToApplicationAction:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
        }
        
        [self.scrollView addSubview:imageView];
    }
    
    
    if (self.isShow) {
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - PageControlBottomY, [UIScreen mainScreen].bounds.size.width, PageControlHeight)];
        self.pageControl.numberOfPages = self.imageArr.count;
        self.pageControl.pageIndicatorTintColor = IndicatorColor;
        self.pageControl.currentPageIndicatorTintColor = CurrentPageColor;
        self.pageControl.currentPage = 0;
        [self.pageControl addTarget:self action:@selector(pageControlValueChangedAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.pageControl];
    }
    
}

- (void)comeToApplicationAction:(UIButton *)sender{
    
    [UIView animateWithDuration:1.0 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.5, 1.5);
        self.view.alpha = 0;
        
    } completion:^(BOOL finished) {
        if (self.welcomePageAfterSetRootViewControllerBlock) {
            self.welcomePageAfterSetRootViewControllerBlock(self);
        }
        
    }];
}

- (void)pageControlValueChangedAction:(UIPageControl *)sender{
    NSInteger index = sender.currentPage;
    [UIView animateWithDuration:0.2 animations:^{
        [self.scrollView setContentOffset:CGPointMake(index * [UIScreen mainScreen].bounds.size.width, 0) animated:YES];
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    [UIView animateWithDuration:0.2 animations:^{
        self.pageControl.currentPage = index;
    }];
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
