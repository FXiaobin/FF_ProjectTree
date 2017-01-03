//
//  UIView+Frame.m
//  ProjectTree
//
//  Created by lovepinyao on 16/8/25.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

-(CGPoint)fxb_origin{
    return self.frame.origin;
}

-(void)setFxb_origin:(CGPoint)fxb_origin{
    CGRect frame = self.frame;
    frame.origin = fxb_origin;
    self.frame = frame;
}

-(CGFloat)fxb_x{
    return self.frame.origin.x;
}

-(void)setFxb_x:(CGFloat)fxb_x{
    CGRect frame = self.frame;
    frame.origin.x = fxb_x;
    self.frame = frame;
}

-(CGFloat)fxb_y{
    return self.frame.origin.y;
}

-(void)setFxb_y:(CGFloat)fxb_y{
    CGRect frame = self.frame;
    frame.origin.x = fxb_y;
    self.frame = frame;
}

-(CGSize)fxb_size{
    return self.frame.size;
}

-(void)setFxb_size:(CGSize)fxb_size{
    CGRect frame = self.frame;
    frame.size = fxb_size;
    self.frame = frame;
}

-(CGFloat)fxb_width{
    return self.frame.size.width;
}

-(void)setFxb_width:(CGFloat)fxb_width{
    CGRect frame = self.frame;
    frame.size.width = fxb_width;
    self.frame = frame;
}

-(CGFloat)fxb_height{
    return self.frame.size.height;
}

-(void)setFxb_height:(CGFloat)fxb_height{
    CGRect frame = self.frame;
    frame.size.height = fxb_height;
    self.frame = frame;
}

-(CGFloat)fxb_centerX{
    return self.center.x;
}

-(void)setFxb_centerX:(CGFloat)fxb_centerX{
    CGPoint center = self.center;
    center.x = fxb_centerX;
    self.center = center;
}

-(CGFloat)fxb_centerY{
    return self.center.y;
}

-(void)setFxb_centerY:(CGFloat)fxb_centerY{
    CGPoint center = self.center;
    center.x = fxb_centerY;
    self.center = center;
}

@end
