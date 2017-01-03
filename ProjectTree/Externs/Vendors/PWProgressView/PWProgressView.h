//
//  TestView.h
//  PWProgressView
//
//  Created by Peter Willsey on 12/17/13.
//  Copyright (c) 2013 Peter Willsey, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PWProgressView : UIView

@property (nonatomic, assign) float progress;

/*
    类似安装苹果APP的扇形加载进度， 当progress = 1.0 的时候会向四周扩散开
 
    使用的时候将其覆盖在要下载的图片上即可
 
 */

@end
