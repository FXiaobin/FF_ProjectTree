//
//  PDCWebViewController.m
//  PublicDrugComment-OC
//
//  Created by TaoYingjun on 16/4/25.
//  Copyright © 2016年 Shanghai Xuanyao Network Technology Co., Ltd. All rights reserved.
//

#import "PDCWebViewController.h"

@interface PDCWebViewController ()

@end

@implementation PDCWebViewController

+ (instancetype)py_viewControllerWithUrl:(NSString *)url {
    NSURL *URL = [NSURL URLWithString:url];
    PDCWebViewController *webViewController = [[PDCWebViewController alloc] initWithURL:URL];
    
    webViewController.supportedWebNavigationTools = DZNWebNavigationToolNone;
    webViewController.supportedWebActions = DZNWebActionNone;
    webViewController.showLoadingProgress = YES;
    webViewController.allowHistory = YES;
    webViewController.hideBarsWithGestures = NO;
    webViewController.showPageTitleAndURL = NO;
    
    return webViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
