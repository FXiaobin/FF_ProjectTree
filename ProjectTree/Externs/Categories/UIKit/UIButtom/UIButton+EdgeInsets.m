//
//  UIButton+EdgeInsets.m
//  ProjectTree
//
//  Created by lovepinyao on 16/9/8.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "UIButton+EdgeInsets.h"

@implementation UIButton (EdgeInsets)

-(void)setEdeInsetsWithEdeInsetsType:(UIButtomEdeInsetsType)edeInsetsType space:(CGFloat)space{
    
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    UIFont *font = self.titleLabel.font;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalWidth = imageSize.width + titleSize.width + space;
    CGFloat totalHeight = (imageSize.height + titleSize.height + space);
    
    UIEdgeInsets titleInsets = UIEdgeInsetsZero;
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;
    
    if (edeInsetsType == UIButtomEdeInsetsTypeDefault) {
        titleInsets = UIEdgeInsetsMake(0, space, 0, 0) ;
        imageInsets = UIEdgeInsetsMake(0, 0, 0, space) ;

    }else if (edeInsetsType == UIButtomEdeInsetsTypeUpDown){
         titleInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
         imageInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
        
    }else if (edeInsetsType == UIButtomEdeInsetsTypeReverse){
         titleInsets = UIEdgeInsetsMake(0, -imageSize.width, 0, totalWidth - titleSize.width);
         imageInsets = UIEdgeInsetsMake(0, totalWidth - imageSize.width, 0, -titleSize.width);
        
    }else if (edeInsetsType == UIButtomEdeInsetsTypeDownUp){
         titleInsets = UIEdgeInsetsMake(0, - imageSize.width,(totalHeight - titleSize.height), 0);
         imageInsets = UIEdgeInsetsMake((totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    }
    
    [self setTitleEdgeInsets:titleInsets];
    [self setImageEdgeInsets:imageInsets];
   
}


@end
