//
//  ItemsCell.m
//  酷狗音乐伸展列表
//
//  Created by lovepinyao on 16/9/7.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "ItemsCell.h"

#define btn_tag     72465
#define Left_Margin 20.0
#define Top_Margin  10.0
#define btn_height  60.0
//宫格数
#define CountOfLine 5

#define kWidth  [UIScreen mainScreen].bounds.size.width

@implementation ItemsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)makeItemsWithTitleArray:(NSArray *)titleArray{
    //默认5宫格
    CGFloat width = (self.contentView.bounds.size.width - (CountOfLine + 1) * Left_Margin) / CountOfLine;
    [self makeItemsWithArray:titleArray count:CountOfLine space:Left_Margin itemWidth:width];
    
}

+ (CGFloat)heightWithTitleArray:(NSArray *)titleArray{
    
    CGFloat width = (kWidth - (CountOfLine + 1) * Left_Margin) / CountOfLine;
    return [self heightWithItemsWithArray:titleArray count:CountOfLine space:Top_Margin itemWidth:width];
}

+ (CGFloat)heightWithItemsWithArray:(NSArray *)titleArr count:(NSInteger)count space:(CGFloat)space itemWidth:(CGFloat)width{
    
    NSInteger row = titleArr.count % count == 0 ? titleArr.count/count : titleArr.count/count+1;
    return row * btn_height  + space*(row -1);
}

/**
 *  制作九宫格
 *
 *  @param imageArr 图片数组
 *  @param count    宫格数
 *  @param space    图片间距
 *  @param width    图片宽高
 *
 *  @return 承载所有图片的父视图的高度
 */
- (void)makeItemsWithArray:(NSArray *)titleArr count:(NSInteger)count space:(CGFloat)space itemWidth:(CGFloat)width{
    
    for (UIView *subView in self.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    for (int i = 0; i < titleArr.count; i++) {
        
        NSInteger r = i % count ; // 0 1
        NSInteger c = i / count;  // 行
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(r * (width + space) + space, c * (btn_height + Top_Margin), width, btn_height)];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        button.tag = btn_tag + i;
        button.backgroundColor = [UIColor purpleColor];
        
        [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
    }
}

- (void)btnAction:(UIButton *)sender{
    NSInteger tag = sender.tag - btn_tag;
    //NSLog(@"--- tag = %ld",(long)tag);
    if (self.itemsBtnActionBlock) {
        self.itemsBtnActionBlock(self,tag);
    }
}

@end
