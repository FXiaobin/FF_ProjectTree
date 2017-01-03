//
//  MusicDetialViewController.m
//  ProjectTree
//
//  Created by lovepinyao on 16/8/26.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "MusicDetialViewController.h"
#import "MarqueeLabel.h"

@interface MusicDetialViewController ()


@property (weak, nonatomic) IBOutlet MarqueeLabel *topTitleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *headerIcon;

@property (weak, nonatomic) IBOutlet UISlider *playProgressSlider;

@property (weak, nonatomic) IBOutlet UIImageView *smallHeaderIcon;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;

- (IBAction)playBtnAction:(UIButton *)sender;

@property (nonatomic,strong) MarqueeLabel *label;

@end

@implementation MusicDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = self.infoDic[@"title"];
    
    self.headerIcon.clipsToBounds = YES;
    self.headerIcon.layer.cornerRadius = 160.0 / 2.0;
   
    //文字的宽度一定要大于label.frame的宽度才会滚动
    self.topTitleLabel.marqueeType = MLContinuousReverse;
    self.topTitleLabel.animationCurve = UIViewAnimationOptionCurveLinear;
    self.topTitleLabel.fadeLength = 20.0f;
    self.topTitleLabel.leadingBuffer = 30.0f;
    self.topTitleLabel.trailingBuffer = 20.0f;
    self.topTitleLabel.scrollDuration = 10.0;
    self.topTitleLabel.text = [NSString stringWithFormat:@"%@  %@  %@",self.infoDic[@"title"],self.infoDic[@"title"],self.infoDic[@"title"]];
    
    [self.headerIcon sd_setImageWithURL:[NSURL URLWithString:self.infoDic[@"coverLarge"]]];
    
    [self.headerIcon rotationLoopRepeatAnimationWithDuration:3.0];
    
    self.playProgressSlider.value = 0.0;
    [self.playProgressSlider addTarget:self action:@selector(changePlayProgressAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.smallHeaderIcon sd_setImageWithURL:[NSURL URLWithString:self.infoDic[@"smallLogo"]]];
    self.nameLabel.text = self.infoDic[@"title"];
    self.authorNameLabel.text = self.infoDic[@"nickname"];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateSliderValue) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)updateSliderValue{
    
    CGFloat progress = self.audioStreamer.progress / self.audioStreamer.duration;
    self.playProgressSlider.value = progress;
    if (progress >= 1.0) {
        [self.audioStreamer pause];
    }
}

- (void)changePlayProgressAction:(UISlider *)slider{
    
    NSInteger curTime = self.audioStreamer.duration * slider.value;
    [self.audioStreamer seekToTime: curTime ];
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

- (IBAction)playBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        
        [sender setTitle:@"播放" forState:UIControlStateSelected];
       
        //[self pauseLayer:self.headerIcon.layer];
        
        [self.audioStreamer pause];
       
    }else{
        
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
        
        //[self resumeLayer:self.headerIcon.layer];
        
        [self.audioStreamer start];
    }
}

- (void)pauseLayer:(CALayer*)layer{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}


//继续layer上面的动画
- (void)resumeLayer:(CALayer*)layer{
    
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

@end
