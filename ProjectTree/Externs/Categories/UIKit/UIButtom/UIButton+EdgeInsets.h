//
//  UIButton+EdgeInsets.h
//  ProjectTree
//
//  Created by lovepinyao on 16/9/8.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIButtomEdeInsetsType) {
    
    UIButtomEdeInsetsTypeDefault,       //左图右字
    UIButtomEdeInsetsTypeUpDown,        //上图下字
    UIButtomEdeInsetsTypeReverse,       //左字右图
    UIButtomEdeInsetsTypeDownUp         //上字下图
};

@interface UIButton (EdgeInsets)

- (void)setEdeInsetsWithEdeInsetsType:(UIButtomEdeInsetsType)edeInsetsType  space:(CGFloat)space;


@end
