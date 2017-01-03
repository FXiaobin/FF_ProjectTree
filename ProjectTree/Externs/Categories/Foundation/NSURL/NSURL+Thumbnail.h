//
//  NSURL+Thumbnail.h
//  PublicDrugComment-OC
//
//  Created by TaoYingjun on 15/10/24.
//  Copyright © 2015年 Shanghai Xuanyao Network Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Thumbnail)
+ (NSURL *)thumbnailWithUrlString:(NSString *)urlString
                            width:(CGFloat)width
                           height:(CGFloat)height;
@end
