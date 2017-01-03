//
//  SGTopScrollMenu.m
//  SGTopScrollMenu
//
//  Created by Sorgle on 16/8/14.
//  Copyright © 2016年 Sorgle. All rights reserved.
//

// 欢迎来Github上下载最完整的Demo
// Github下载地址 https://github.com/Hanymore/SGTopScrollMenu.git


#import "SGTopScrollMenu.h"
#import "UIView+SGExtension.h"

#define labelFontOfSize [UIFont systemFontOfSize:17]
#define SG_screenWidth [UIScreen mainScreen].bounds.size.width

@interface SGTopScrollMenu ()
@property (nonatomic, strong) UILabel *titleLabel;
/** 选中时的label */
@property (nonatomic, strong) UILabel *selectedLabel;
/** 指示器 */
@property (nonatomic, strong) UIView *indicatorView;

@end


@implementation SGTopScrollMenu

///** label之间的间距 */
//static CGFloat const labelMargin = 15;
///** 指示器的高度 */
//static CGFloat const indicatorHeight = 3;


/** 形变的度数 */
static CGFloat const radio = 1.0;

- (NSMutableArray *)allTitleLabel {
    if (_allTitleLabel == nil) {
        _allTitleLabel = [NSMutableArray array];
    }
    return _allTitleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        //默认跟标题文字宽度一致
        self.indicatorWidthStyle = IndicatorWidthStyleTitleWidth;
    }
    return self;
}

+ (instancetype)topScrollMenuWithFrame:(CGRect)frame {
    return [[self alloc] initWithFrame:frame];
}


/**
 *  计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (void)scrollMenuViewStyleSet{
    
    self.titleMargin = self.titleMargin > 0.0 ? self.titleMargin : 15.0;
    self.titleFont = self.titleFont ? self.titleFont : [UIFont systemFontOfSize:15.0];
    self.titleNormalColor = self.titleNormalColor ? self.titleNormalColor : [UIColor blackColor];
    self.titleSelectedColor = self.titleSelectedColor ? self.titleSelectedColor : [UIColor redColor];
    
    self.indicatorWidthStyle =  (self.indicatorWidthStyle == IndicatorWidthStyleNormalWidth) ? IndicatorWidthStyleNormalWidth : self.indicatorWidthStyle;
    self.indicatorHeight = self.indicatorHeight > 0.0 ? self.indicatorHeight : 2.0;
    self.indicatorColor = self.indicatorColor ? self.indicatorColor : [UIColor redColor];
    
    if (self.menuBgColor) {
        self.backgroundColor = self.menuBgColor;
    }
}

- (void)setTitlesArr:(NSArray *)titlesArr {
    _titlesArr = titlesArr;
    
    //显示设置
    [self scrollMenuViewStyleSet];
    
    /** 创建标题Label */
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    
    CGFloat labelH = self.frame.size.height - _indicatorHeight;
    
    for (NSUInteger i = 0; i < self.titlesArr.count; i++) {
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.userInteractionEnabled = YES;
        _titleLabel.text = self.titlesArr[i];
        
        _titleLabel.textColor = self.titleNormalColor;
        // 设置高亮文字颜色
        _titleLabel.highlightedTextColor = self.titleSelectedColor;

        _titleLabel.tag = i;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.font = self.titleFont;
        
        // 计算内容的Size
        CGSize labelSize = [self sizeWithText:_titleLabel.text font:labelFontOfSize maxSize:CGSizeMake(MAXFLOAT, labelH)];
        // 计算内容的宽度
        CGFloat labelW = labelSize.width + 2 * self.titleMargin;
        
        if (_isAverage) {
            labelW = self.bounds.size.width / titlesArr.count;
        }
        
        _titleLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        // 计算每个label的X值
        labelX = labelX + labelW;
        
        // 添加到titleLabels数组
        [self.allTitleLabel addObject:_titleLabel];
        
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
        [_titleLabel addGestureRecognizer:tap];
        
        // 默认选中第0个label
        if (i == 0) {
            [self titleClick:tap];
        }

        [self addSubview:_titleLabel];
    }
    
    // 计算scrollView的宽度
    CGFloat scrollViewWidth = CGRectGetMaxX(self.subviews.lastObject.frame);
    self.contentSize = CGSizeMake(scrollViewWidth, self.frame.size.height);
    
    // 取出第一个子控件
    UILabel *firstLabel = self.subviews.firstObject;
    
    // 添加指示器
    self.indicatorView = [[UIView alloc] init];
    _indicatorView.backgroundColor = self.indicatorColor;
    _indicatorView.SG_height = self.indicatorHeight;
    _indicatorView.SG_y = self.frame.size.height - self.indicatorHeight;
    [self addSubview:_indicatorView];
    
    // 指示器的三种宽度显示样式
    if (self.indicatorWidthStyle == IndicatorWidthStyleNormalWidth) {
        self.indicatorView.SG_width = firstLabel.SG_width - 2 * self.titleMargin;
        
    }else if ((self.indicatorWidthStyle == IndicatorWidthStyleTitleWidth)) {
        NSString *firstText = firstLabel.text;
        CGFloat firstWidth = [self sizeWithText:firstText font:labelFontOfSize maxSize:CGSizeMake(MAXFLOAT, labelH)].width;
        _indicatorView.SG_width = firstWidth;
      
    }else{
        _indicatorView.SG_width = firstLabel.SG_width;
    }
    
    _indicatorView.SG_centerX = firstLabel.SG_centerX;
}

#pragma mark - - - Label的点击事件
- (void)titleClick:(UITapGestureRecognizer *)tap {
    // 0.获取选中的label
    UILabel *selLabel = (UILabel *)tap.view;
    
    // 1.标题颜色变成红色,设置高亮状态下的颜色， 以及指示器位置
    [self selectLabel:selLabel];
    
    // 2.让选中的标题居中
    [self setupTitleCenter:selLabel];
    
    NSInteger index = selLabel.tag;
    if ([self.topScrollMenuDelegate respondsToSelector:@selector(SGTopScrollMenu:didSelectTitleAtIndex:selectedTitle:)]) {
        [self.topScrollMenuDelegate SGTopScrollMenu:self didSelectTitleAtIndex:index selectedTitle:selLabel.text];
    }
}

/** 选中label标题颜色变成红色以及指示器位置 */
- (void)selectLabel:(UILabel *)label {
    // 取消高亮
    _selectedLabel.highlighted = NO;
    // 取消形变
    _selectedLabel.transform = CGAffineTransformIdentity;
    // 颜色恢复
    _selectedLabel.textColor = self.titleNormalColor;
    // 字体恢复
    _selectedLabel.font = self.titleFont;
    
    // 高亮
    label.highlighted = YES;
    // 形变
    label.transform = CGAffineTransformMakeScale(radio, radio);
    
    if (self.isTitleBig) {
        CGFloat selectedFont = self.titleFont.pointSize + 3.0;
        label.font = [UIFont systemFontOfSize:selectedFont weight:1.1];
    }
    
    _selectedLabel = label;
    
    // 改变指示器位置 （三种样式）
    [UIView animateWithDuration:0.20 animations:^{
        
        if (self.indicatorWidthStyle == IndicatorWidthStyleNormalWidth) {
            self.indicatorView.SG_width = label.SG_width - 2 * self.titleMargin;
            
        }else if (self.indicatorWidthStyle == IndicatorWidthStyleTitleWidth) {
            NSString *laeblText = label.text;
            CGFloat labelH = self.frame.size.height - _indicatorHeight;
            CGFloat labelW = [self sizeWithText:laeblText font:labelFontOfSize maxSize:CGSizeMake(MAXFLOAT, labelH)].width;
            _indicatorView.SG_width = labelW;
           
        }else{
            self.indicatorView.SG_width = label.SG_width;
        }
        
        self.indicatorView.SG_centerX = label.SG_centerX;
    }];
}

/** 设置选中的标题居中 */
- (void)setupTitleCenter:(UILabel *)centerLabel {
    // 计算偏移量
    CGFloat offsetX = centerLabel.center.x - SG_screenWidth * 0.5;
    
    if (offsetX < 0){
        offsetX = 0;
    }
    
    // 获取最大滚动范围
    CGFloat maxOffsetX = self.contentSize.width - SG_screenWidth;
    
    if (offsetX > maxOffsetX){
        offsetX = maxOffsetX;
    }
    
    // 滚动标题滚动条
    [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}



@end


