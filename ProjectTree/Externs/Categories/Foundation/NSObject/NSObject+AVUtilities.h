//
//  NSObject+AVUtilities.h
//  ProjectTree
//
//  Created by lovepinyao on 16/9/12.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AVAsset;

@interface NSObject (AVUtilities)

+ (AVAsset *)assetByReversingAsset:(AVAsset *)asset outputURL:(NSURL *)outputURL;


/*
 作用： 把一个视频转换输出成一个具有相同的压缩，格式，和帧速率的视频文件来作为源视频。
 使用方法：
 #import "AVUtilities.h"
 
 AVAsset *originalAsset = [[AVURLAsset alloc] initWithURL:[NSURL urlWithString:@"~/video.mp4"]];
 AVAsset *reversedAsset = [AVUtilities assetByReversingAsset:originalAsset outputURL:[NSURL urlWithString:@"~/reversedvideo.mp4"]];
 */

@end
