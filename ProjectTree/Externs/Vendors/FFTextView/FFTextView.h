//
//  FFTextView.h
//  CMInputView
//
//  Created by lovepinyao on 16/9/23.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFTextView : UITextView

/// 如果是评论输入框 则textview的高度会随行数而变化（默认不变）
@property (nonatomic,assign) BOOL isInputView;

/// 占位文字
@property (nonatomic, strong) NSString *placeholder;

/// 占位文字颜色
@property (nonatomic, strong) UIColor *placeholderColor;

/// 占位符字体大小
@property (nonatomic,strong) UIFont *placeholderFont;

/// textView最大行数
@property (nonatomic, assign) NSUInteger maxNumberOfLines;

/**
 *  文字高度改变block → 文字高度改变会自动调用
 *  block参数(text) → 文字内容
 *  block参数(textHeight) → 文字高度
 */
@property (nonatomic, copy) void (^textChangedBlock) (NSString *text,CGFloat textHeight);

/// 设置圆角
@property (nonatomic, assign) NSUInteger cornerRadius;



@end
