//
//  UIView+Events.m
//  ProjectTree
//
//  Created by lovepinyao on 16/8/25.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "UIView+Events.h"

@implementation UIView (Events)

-(void)addTarget:(id)target selector:(SEL)selector{
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [self addGestureRecognizer:tap];
}

@end
