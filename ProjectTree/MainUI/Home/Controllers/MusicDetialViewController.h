//
//  MusicDetialViewController.h
//  ProjectTree
//
//  Created by lovepinyao on 16/8/26.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "BaseViewController.h"
#import "AudioStreamer.h"

@interface MusicDetialViewController : BaseViewController

@property (nonatomic,strong) NSDictionary *infoDic;

@property (nonatomic,strong) AudioStreamer *audioStreamer;

@end
