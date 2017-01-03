//
//  FifthViewController.m
//  ProjectTree
//
//  Created by lovepinyao on 16/8/17.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "FifthViewController.h"
#import "UITableView+Animations.h"
#import "UITableViewCell+Load.h"
#import "UIImageView+Tools.h"
#import "AnimationCell.h"

@interface FifthViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *images;

@end

@implementation FifthViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor brownColor];

    self.images = @[@"http://www.bz55.com/uploads1/allimg/120312/1_120312100435_8.jpg",
                    @"http://img3.iqilu.com/data/attachment/forum/201308/21/192654ai88zf6zaa60zddo.jpg",
                    @"http://h.hiphotos.baidu.com/image/h%3D200/sign=fc55a740f303918fc8d13aca613c264b/9213b07eca80653893a554b393dda144ac3482c7.jpg",
                    @"http://www.1tong.com/uploads/wallpaper/landscapes/206-2-730x456.jpg",
                    @"http://attach.bbs.miui.com/forum/201309/27/181659trqmmw5x3t4gcigt.jpg",
                    @"http://pic.58pic.com/58pic/13/71/53/93h58PICGX2_1024.jpg",
                    @"http://www.86ps.com/uploadfiles/jpg/2011-11/2011111414003220188.jpg",
                    ];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.rowHeight = 200.0;
    [AnimationCell registerXibCellForTableView:self.tableView];
    
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

   AnimationCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AnimationCell class]) forIndexPath:indexPath];
    
    //AnimationCell *cell = [AnimationCell dequeueReusableCellWithTableView:tableView forIndexPath:indexPath];
    
    NSInteger index = arc4random() % 7;
    
    [cell.icon setImageWithURL:self.images[index] placeholder:nil];
    
    cell.titleLabel.text = [NSString stringWithFormat:@"大打了款到付的 %ld 打了对方",(long)indexPath.row];
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView yuScrollViewDidScroll:self.tableView animation:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
