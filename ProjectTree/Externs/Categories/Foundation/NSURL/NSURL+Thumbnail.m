//
//  NSURL+Thumbnail.m
//  PublicDrugComment-OC
//
//  Created by TaoYingjun on 15/10/24.
//  Copyright © 2015年 Shanghai Xuanyao Network Technology Co., Ltd. All rights reserved.
//

#import "NSURL+Thumbnail.h"

@implementation NSURL (Thumbnail)

+ (NSURL *)thumbnailWithUrlString:(NSString *)urlString width:(CGFloat)width height:(CGFloat)height {
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *string = [urlString stringByAppendingFormat:@"_%ldx%ld", (long)[@(width*scale) integerValue], (long)[@(height*scale) integerValue]];
    return [NSURL URLWithString:string];
}

@end
