//
//  ThirdViewController.m
//  ProjectTree
//
//  Created by lovepinyao on 16/8/17.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "ThirdViewController.h"
//#import "UIButton+EdgeInsets.h"
#import "SRActionSheet.h"
#import "UIImage+ImageWithColor.h"
#import "UIImageView+CornnerRadius.h"
#import "UIView+Layer.h"
#import "UIViewController+HUD.h"

#import "TYAttributedLabel.h"

@interface ThirdViewController ()<SRActionSheetDelegate,TYAttributedLabelDelegate>

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    self.navigationItem.title = @"第三页";
   
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor orangeColor];
    btn.tintColor = [UIColor whiteColor];
    [btn setTitle:@"分享" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"dzn_icn_toolbar_action"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //[btn setEdeInsetsWithEdeInsetsType:UIButtomEdeInsetsTypeDownUp space:10.0];
  
    UIImage *image = [UIImage imageNamed:@"lookup_miss_etikate"];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(100, 260, 100, 100)];
    imageV.image = [image circleImage];
    [imageV setCornnerRadiusWithImage:image];
    [imageV setCornerRadius:100/2.0];
    [imageV setBorderColor:[UIColor whiteColor] borderWidth:2.0];
    [imageV setShadowWithColor:[UIColor blackColor] radius:50.0 offset:CGSizeMake(3.0, 3.0) opacity:0.6];
    [imageV setShadowWithColor:[UIColor blackColor] radius:50.0 opacity:1.0];
    
    [self.view addSubview:imageV];
    
    NSString *spaceStr = @"等级啊开发拉的是解放了空间 021-66545878 大师分解落实到";
    NSAttributedString *att = [spaceStr characterSpace:10.0];
    
    UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 200)];
    aLabel.numberOfLines = 0;
    aLabel.attributedText = att;
    [self.view addSubview:aLabel];
    
    TYAttributedLabel *telLabel = [[TYAttributedLabel alloc] init];
    telLabel.frame = CGRectMake(230, 100, 100, 400);
    telLabel.delegate = self;
    telLabel.text = @"罚款了饭卡，拨打 021-12545878 等级啊开发拉的是解放了空间 021-66545878 大师分解落实到 拉大了看到 离开发来的积分阿里附近；来的爱上当雷锋； ";
    telLabel.linesSpacing = 3.0;
    [telLabel addLinkWithLinkData:@"021-12545878" linkColor:[UIColor blueColor] underLineStyle:kCTUnderlineStyleNone range:NSMakeRange(@"罚款了饭卡，拨打 ".length, @"021-12545878".length)];
    [telLabel addLinkWithLinkData:@"021-66545878" linkColor:[UIColor blueColor] underLineStyle:kCTUnderlineStyleNone range:NSMakeRange(@"罚款了饭卡，拨打 021-12545878 等级啊开发拉的是解放了空间 ".length, @"021-66545878".length)];
    
    [self.view addSubview:telLabel];
}

- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageClicked:(id<TYTextStorageProtocol>)textStorage atPoint:(CGPoint)point{
    
    TYLinkTextStorage *storage = attributedLabel.textContainer.textStorages.firstObject;
    if (point.y > 80.0) {
        storage = attributedLabel.textContainer.textStorages.lastObject;
    }
    id linkData = storage.linkData;
    NSLog(@"--- tel = %@",linkData);
    
    
  
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //[self showInfo:@"消息提示"];
    //[self showError:@"加载失败" ];
    //[self showSuccess:@"加载成功"];
    //[self showWarning:@"订单出现异常"];
    
//    [self showIndicatorHUDWithTitle:@"加载中..."];
//    [self hideAfter:2.0];
    
//    [self showTextTip:@"正在处理，请稍后..."];
//    [self hideAfter:2.0];
    
//    [self showTextTip:@"网络出现异常，请稍后再试" hideAfter:2.0];
    
 //   [self showImageTip:@"哈哈成功了" hideAfter:2.0 msgType:FFHUDImagesTypeSuccessful];
    
 //   [self showImageTip:@"测试" hideAfter:2.0 imageName:@"order_alixPay_normal"];
 
    [self showDeterminateAnnularHUD];
    __block int count = 0;
    [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        count += 5;
        CGFloat progress = count / 100.0;
        if (progress <= 1.0) {
            [self updateDeterminateHUDProgress:progress];
        }
    }];
    
}

- (void)share:(UIButton *)sender{
    
    SRActionSheet *sheet = [[SRActionSheet alloc] initWithTitle:@"" cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:@[@"相册",@"拍照",@"最近"] delegate:self];
    [sheet show];
    
    //[SRActionSheet sr_showActionSheetViewWithTitle:@"选择一张图片"  cancelButtonTitle:@"取消"  destructiveButtonTitle:@"确定"  otherButtonTitles:@[@"相册",@"拍照",@"最近"] delegate:self];
}

- (void)actionSheet:(SRActionSheet *)actionSheet didSelectSheet:(NSInteger)index{
    NSLog(@"--- index = %ld",(long)index);
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
