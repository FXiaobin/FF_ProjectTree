//
//  UITableViewCell+Load.h
//  ProjectTree
//
//  Created by lovepinyao on 16/9/13.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Load)

//加载cell
+ (id)loadCellWithStyle:(UITableViewCellStyle)cellStyle;

+ (id)loadXibCell;

//加载重用的cell
+ (id)dequeueReusableCellWithTableView:(UITableView *)tableView;

+ (id)dequeueReusableCellWithTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath;

//注册cell
+(void)registerCellForTableView:(UITableView*)tableView;

+(void)registerXibCellForTableView:(UITableView*)tableView;

@end
