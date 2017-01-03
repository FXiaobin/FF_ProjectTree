//
//  MusicCell.m
//  酷狗音乐伸展列表
//
//  Created by lovepinyao on 16/9/7.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "MusicCell.h"

#import "ItemsCell.h"

@implementation MusicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //self.topView.backgroundColor = CY_COLOR;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
 
    [self.tableView registerClass:[ItemsCell class] forCellReuseIdentifier:@"ItemsCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.itemsArr.count) {
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ItemsCell heightWithTitleArray:self.itemsArr];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ItemsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemsCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor blackColor];
    
    [cell makeItemsWithTitleArray:self.itemsArr];
    
    __weak typeof(self) weakSelf = self;
    cell.itemsBtnActionBlock = ^(ItemsCell *aCell, NSInteger tag){
        
        if (weakSelf.musicItemsBtnActionBlock) {
            weakSelf.musicItemsBtnActionBlock(weakSelf,tag);
        }
    };
    
    return cell;
}


- (IBAction)openBtnAction:(UIButton *)sender {
    if (self.openBtnActionBlock) {
        self.openBtnActionBlock(self,sender);
    }
}

@end
