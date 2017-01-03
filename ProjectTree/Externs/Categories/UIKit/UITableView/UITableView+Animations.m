//
//  UITableView+Animations.m
//  ProjectTree
//
//  Created by lovepinyao on 16/9/13.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "UITableView+Animations.h"

#define  APP_WIDTH   [[UIScreen mainScreen]applicationFrame].size.width

@implementation UITableView (Animations)

float oldOffset;
static float offsetX = 25;

//可见的第一个cell和最后一个cell错落
-(void)yuScrollViewDidScroll:(UITableView *)tableView animation:(BOOL)animation{
    
    NSArray *cellArry = [self visibleCells];
    UITableViewCell *cellFirst = [cellArry firstObject];
    UITableViewCell *cellLast  = [cellArry lastObject];
    
    for (UITableViewCell *cell in cellArry) {
        
        {
            CGRect frame = cell.contentView.frame;
            frame.origin.y = 0;
            cell.contentView.frame = frame;
            cell.layer.zPosition = 0;
            cell.alpha = 1;
        };
        
        {
            CGRect frame = cell.frame;
            frame.origin.x = 0;
            frame.size.width = APP_WIDTH;
            cell.frame = frame;
        };
    }
    
    
    cellFirst.layer.zPosition = -1;
    cellLast.layer.zPosition = -1;
    
    
    if(!(tableView.contentOffset.y <= 0 || tableView.contentOffset.y >= (tableView.contentSize.height-tableView.frame.size.height)))
    {
        CGPoint point = [self convertPoint:[self rectForRowAtIndexPath:[self indexPathForCell:cellFirst]].origin toView:[self superview]];
        if(animation)
        {
            double py =  fabs(point.y);
            float scale;
            
            //if (scrollView.contentOffset.y > oldOffset)
            {
                scale = (py/cellFirst.frame.size.height);
                cellFirst.alpha = 1-scale;
                
                CGRect frame = cellFirst.frame;
                frame.origin.x = offsetX*scale;
                frame.size.width = APP_WIDTH-2*(offsetX*scale);
                cellFirst.frame = frame;
            }
            
            {
                scale = ((cellFirst.frame.size.height-py)/cellFirst.frame.size.height);
                cellLast.alpha = 1-scale;
                
                CGRect frame = cellLast.frame;
                frame.origin.x = offsetX*scale;
                frame.size.width = APP_WIDTH-2*(offsetX*scale);
                cellLast.frame = frame;
            }
        }
        
        if(0 != point.y)
        {
            CGRect frame = cellFirst.contentView.frame;
            frame.origin.y = -point.y;
            cellFirst.contentView.frame = frame;
            
            frame = cellLast.contentView.frame;
            frame.origin.y = - frame.size.height - point.y;
            cellLast.contentView.frame = frame;
        }
    }
    
    oldOffset = tableView.contentOffset.y;
}

@end
