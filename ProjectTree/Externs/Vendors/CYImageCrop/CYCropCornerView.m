//
//  CYCropCornerView.m
//  CYImageCrop
//
//  Created by Cyrus on 16/6/9.
//  Copyright © 2016年 Cyrus. All rights reserved.
//

#import "CYCropCornerView.h"

/*四个角的颜色*/
#define CORNER_COLOR    [UIColor orangeColor]

static const CGFloat kCornerWidth = 4.0;
static const CGFloat kCornerLength = 20.0;

@implementation CYCropCornerView

- (instancetype)initWithPosition:(CYCropCornerPosition)position {
    self = [super initWithFrame:CGRectMake(0, 0, kCornerLength, kCornerLength)];
    if (!self) { return nil; }
    
    CALayer *rectLayer = [CALayer layer];
    rectLayer.backgroundColor = CORNER_COLOR.CGColor;
    [self.layer addSublayer:rectLayer];
    
    CALayer *squareLayer = [CALayer layer];
    squareLayer.backgroundColor = CORNER_COLOR.CGColor;
    [self.layer addSublayer:squareLayer];
    
    switch (position) {
        case CYCropCornerPositionLeftTop:
            rectLayer.frame = CGRectMake(0, 0, kCornerWidth, kCornerLength);
            squareLayer.frame = CGRectMake(kCornerWidth, 0, kCornerLength-kCornerWidth, kCornerWidth);
            break;
        case CYCropCornerPositionRightTop:
            rectLayer.frame = CGRectMake(kCornerLength-kCornerWidth, 0, kCornerWidth, kCornerLength);
            squareLayer.frame = CGRectMake(0, 0, kCornerLength-kCornerWidth, kCornerWidth);
            break;
        case CYCropCornerPositionLeftBottom:
            rectLayer.frame = CGRectMake(0, 0, kCornerWidth, kCornerLength);
            squareLayer.frame = CGRectMake(kCornerWidth, kCornerLength-kCornerWidth, kCornerLength-kCornerWidth, kCornerWidth);
            break;
        case CYCropCornerPositionRightBottom:
            rectLayer.frame = CGRectMake(kCornerLength-kCornerWidth, 0, kCornerWidth, kCornerLength);
            squareLayer.frame = CGRectMake(0, kCornerLength-kCornerWidth, kCornerLength-kCornerWidth, kCornerWidth);
            break;
    }
    
    return self;
}

@end
