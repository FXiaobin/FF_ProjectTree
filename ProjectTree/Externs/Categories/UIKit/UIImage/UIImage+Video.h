//
//  UIImage+Video.h
//  ProjectTree
//
//  Created by lovepinyao on 16/9/12.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Video)
#pragma mark --- 获取视频截图
+ (UIImage *)imageWithVideo:(NSURL *)videoURL;

@end
