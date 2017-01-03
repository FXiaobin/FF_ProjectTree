//
//  UIImageView+Tools.m
//  ProjectTree
//
//  Created by lovepinyao on 16/9/13.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "UIImageView+Tools.h"

@implementation UIImageView (Tools)

- (void)setImageWithURL:(NSString *)urlStr placeholder:(NSString *)placeholder{
    
    self.image = [UIImage imageNamed:placeholder];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:urlStr]];
        if (data) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = [UIImage imageWithData:data];
            });
        }else{
            NSLog(@"--- 图片网络数据读取失败 ---");
        }
        
    });
}

@end
