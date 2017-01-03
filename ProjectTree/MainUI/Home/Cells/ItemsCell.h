//
//  ItemsCell.h
//  酷狗音乐伸展列表
//
//  Created by lovepinyao on 16/9/7.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemsCell : UITableViewCell

@property (nonatomic,copy) void (^itemsBtnActionBlock) (ItemsCell *, NSInteger);

- (void)makeItemsWithTitleArray:(NSArray *)titleArray;

+ (CGFloat)heightWithTitleArray:(NSArray *)titleArray;

@end
