//
//  HomeViewController.m
//  ProjectTree
//
//  Created by lovepinyao on 16/8/17.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "HomeViewController.h"
#import "FXBNetManager.h"


#import "AudioStreamer.h"
#import <AVFoundation/AVFoundation.h>

#import "MusicDetialViewController.h"

#import "MusicCell.h"
#import "ItemsCell.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>{

}

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *resultArr;

@property (nonatomic,assign) BOOL isOpen;
@property (nonatomic,strong) NSIndexPath *currentIndexPath;

@property (nonatomic,strong) AudioStreamer *audioStreamer;

@property (nonatomic,assign) NSInteger curPage;
@property (nonatomic,assign) BOOL isRefreshing;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    
    
    // 让后台可以处理多媒体的事件 后台播放设置 plist中也要设置
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64 ) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MusicCell" bundle:nil] forCellReuseIdentifier:@"MusicCell"];
    
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.isRefreshing = YES;
        weakSelf.curPage = 0;
        [weakSelf musicListRequest];
    }];
    self.tableView.mj_header = header;
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.isRefreshing = NO;
        weakSelf.curPage++;
        [weakSelf musicListRequest];
    }];
    self.tableView.mj_footer = footer;
  
    [self musicListRequest];
}

- (void)musicListRequest{
    
    //FXBNetManager *manager = [FXBNetManager manager];
    
    //__weak typeof(self) weakSelf = self;
    WEAKSELF(weakSelf);
    [FXBNetManager POST:@"http://mobile.ximalaya.com/mobile/others/ca/album/track/5541/true/1/136" parameters:@{@"page" : @(_curPage)} success:^(id responseObject, NSError *error) {
        [SVProgressHUD dismiss];
        
        //DDLog(@"-- res = %@",responseObject);
        DDLogDebug(@"-- res = %@",responseObject);
        
        weakSelf.resultArr =  responseObject[@"tracks"][@"list"];
        [weakSelf.tableView reloadData];
        
        weakSelf.isRefreshing = NO;
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
    } failure:^(id responseObject, NSError *error) {
        DDLog(@" error = %@", error);
    }];
}
                                         

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.resultArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isOpen && _currentIndexPath == indexPath) {
        
        return [ItemsCell heightWithTitleArray: @[@"试听" ,@"下载", @"购买",@"分享",@"k歌",@"MV",@"点赞"]] + 44.0;
    }
    return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = self.resultArr[indexPath.row];
    
    MusicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicCell" forIndexPath:indexPath];
    
    cell.titleLabel.text = dic[@"title"];
    cell.subTitleLabel.text = dic[@"nickname"];
    [cell.singerHeader sd_setImageWithURL:[NSURL URLWithString:dic[@"coverMiddle"]] placeholderImage:nil];
    
    cell.itemsArr = @[@"试听" ,@"下载", @"购买",@"分享",@"k歌",@"MV",@"点赞"];
    
    __weak typeof(self) weakSelf = self;
    cell.openBtnActionBlock = ^(MusicCell *aCell, UIButton *sender){
        if (_currentIndexPath == indexPath) {
            _isOpen = !_isOpen;
        }else{
            _isOpen = YES;
        }
        _currentIndexPath = indexPath;
        
        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    };
    
    cell.musicItemsBtnActionBlock = ^(MusicCell *aCell, NSInteger tag){
        NSLog(@"--- tag = %ld",(long)tag);
        switch (tag) {
            case 0:{
                
            }break;
            case 1:{
                
            }break;
            case 2:{
                
            }break;
            case 3:{
                
            }break;
            case 4:{
                
            }break;
                
            default:
                break;
        }
    };
  
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.audioStreamer) {
        [self.audioStreamer stop];
        self.audioStreamer = nil;
    }
    
    NSDictionary *dic = self.resultArr[indexPath.row];
    NSString *url = dic[@"playUrl64"];
    //NSString *url = dic[@"playPathAacv224"];
   
    AudioStreamer *aduioStreamer = [[AudioStreamer alloc] initWithURL:[NSURL URLWithString:url]];
    [aduioStreamer start];
    self.audioStreamer = aduioStreamer;
   
    MusicDetialViewController *musicDitailVC = [[MusicDetialViewController alloc] init];
    musicDitailVC.audioStreamer = aduioStreamer;
    musicDitailVC.infoDic = dic;
    musicDitailVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:musicDitailVC animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //[cell rotationTransform3DForCell];
    
    [cell scaleAnimationForCell];
    
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
