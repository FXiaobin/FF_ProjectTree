//
//  UIImageView+Tools.h
//  ProjectTree
//
//  Created by lovepinyao on 16/9/13.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Tools)

///加载网络图片（无缓存）
- (void)setImageWithURL:(NSString *)urlStr placeholder:(NSString *)placeholder;


@end
