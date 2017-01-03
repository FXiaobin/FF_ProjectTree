//
//  UITableViewCell+Load.m
//  ProjectTree
//
//  Created by lovepinyao on 16/9/13.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "UITableViewCell+Load.h"

@implementation UITableViewCell (Load)

+ (id)loadCellWithStyle:(UITableViewCellStyle)cellStyle{
    NSString *cellIdentifier = NSStringFromClass([self class]);
    id cell = [[self alloc] initWithStyle:cellStyle reuseIdentifier:cellIdentifier];
    return cell;
}

+(id)loadXibCell{
    id cell = [[NSBundle mainBundle] loadNibNamed:[NSString stringWithUTF8String:object_getClassName(self)] owner:nil options:nil].firstObject;
    return cell;
}

+ (id)dequeueReusableCellWithTableView:(UITableView *)tableView{
    NSString *cellIdentifier = NSStringFromClass([self class]);
    return [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
}

+ (id)dequeueReusableCellWithTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = NSStringFromClass([self class]);
    return [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
}

+(void)registerXibCellForTableView:(UITableView*)tableView{
    NSString *cellIdentifier = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:cellIdentifier bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
}

+(void)registerCellForTableView:(UITableView*)tableView{
    NSString *cellIdentifier = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:cellIdentifier];
}

@end
