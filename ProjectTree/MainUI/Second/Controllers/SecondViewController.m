//
//  SecondViewController.m
//  ProjectTree
//
//  Created by lovepinyao on 16/8/17.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "SecondViewController.h"
//#import "UIImage+QRCode.h"
#import "JLAnimatedImagesView.h"
@interface SecondViewController ()<JLAnimatedImagesViewDelegate>

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIImageView *codeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    codeImageView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:codeImageView];
    
    //UIImage *codeImage = [UIImage qrImageByContent:@"http://seagou.lovepinyao.com/product/s3B5KhbBY5"];
    //codeImageView.image = codeImage;
    
    
    JLAnimatedImagesView *ani = [[JLAnimatedImagesView alloc]  initWithFrame:self.view.bounds];
    ani.delegate = self;
    [self.view addSubview:ani];
    
    [ani startAnimating:JLAnimatedType_Translation];
}

- (NSInteger)animatedImagesNumberOfImages:(JLAnimatedImagesView *)animatedImagesView{
    return 2;
}
- (UIImage *)animatedImagesView:(JLAnimatedImagesView *)animatedImagesView imageAtImdex:(NSInteger)index{
    if (index == 0) {
        return [UIImage imageNamed:@"test0"];
    }
    return [UIImage imageNamed:@"test1"];
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
