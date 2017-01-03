//
//  MusicCell.h
//  酷狗音乐伸展列表
//
//  Created by lovepinyao on 16/9/7.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *singerHeader;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (nonatomic,copy) void (^openBtnActionBlock) (MusicCell *, UIButton *);
- (IBAction)openBtnAction:(UIButton *)sender;


@property (nonatomic,copy) void (^musicItemsBtnActionBlock) (MusicCell *, NSInteger);

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSArray *itemsArr;







@end
