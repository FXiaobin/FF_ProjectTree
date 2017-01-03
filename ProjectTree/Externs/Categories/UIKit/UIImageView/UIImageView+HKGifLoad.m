//
//  UIImageView+HKGifLoad.m
//  HKGifExample
//
//  Created by huangkuan01 on 15/8/7.
//  Copyright (c) 2015年 Widehuang. All rights reserved.
//

#import "UIImageView+HKGifLoad.h"

@implementation UIImageView (HKGifLoad)

- (instancetype)initWithGifImageName:(NSString *)gifImageName{
    self = [super init];
    if (self) {
        NSArray *imgArray = [self loadGifFile:gifImageName];
        [self createGifImageWith:imgArray];
    }
    return self;
}

- (void)addGifImageWithName:(NSString *)gifImageName{
    NSArray *imgArray = [self loadGifFile:gifImageName];
    [self createGifImageWith:imgArray];
}

- (NSArray *)loadGifFile:(NSString *)gifImageName{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:gifImageName ofType:nil];
    NSData* imageData = [NSData dataWithContentsOfFile:filePath];
    
    CGImageSourceRef source = CGImageSourceCreateWithData((CFDataRef)imageData, NULL);
    size_t count = CGImageSourceGetCount(source);
    NSMutableArray* tmpArray = [NSMutableArray array];
    for (size_t i = 0; i < count; i++) {
        CGImageRef cgimage = CGImageSourceCreateImageAtIndex(source, i, NULL);
        UIImage  *image = [UIImage imageWithCGImage:cgimage
                                              scale:[UIScreen mainScreen].scale
                                        orientation:UIImageOrientationUp];
        [tmpArray addObject:image];
        CGImageRelease(cgimage);
    }
    
    if (source) {
        CFRelease(source);
    }else{
        NSLog(@"0.o,你确定传的是图片了？？？");
    }
    
    return tmpArray;
}

- (void)createGifImageWith:(NSArray *)imageArray{
    if (imageArray.count == 0)return;
    
    UIImage *image = [imageArray firstObject];
    self.image = image;
    self.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    
    if (imageArray.count == 1)return;
    
    self.animationImages = imageArray;
    self.animationDuration = imageArray.count/24;
    [self startAnimating];
}

- (void)restoreAnimating{
    CFTimeInterval pausedTime = [self.layer timeOffset];
    self.layer.speed = 1.0;
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.layer.beginTime = timeSincePause;
}

- (void)pauseAnimating{
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0.0;
    self.layer.timeOffset = pausedTime;
}

@end
