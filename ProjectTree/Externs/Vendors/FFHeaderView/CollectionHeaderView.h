//
//  CollectionHeaderView.h
//  PublicDrugComment-OC
//
//  Created by lovepinyao on 16/10/8.
//  Copyright © 2016年 Shanghai Xuanyao Network Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionHeaderView : UICollectionReusableView

///图片icon名称
@property (nonatomic,strong) NSString *headerIconName;

///查看更多按钮标题和文案大小设置
@property (nonatomic,strong) NSString *headerBtnTitle;
@property (nonatomic,strong) UIFont *headerBtnTitleFont;
@property (nonatomic,strong) UIColor *headerBtnTitleColor;

///标题文案和字体大小设置
@property (nonatomic,strong) NSString *headerTitle;
@property (nonatomic,strong) UIFont *headerTitleFont;
@property (nonatomic,strong) UIColor *headerTitleColor;

///分割线颜色
@property (nonatomic,strong) UIColor *headerSeperatorColor;

//是否顶部留10个像素的空白
@property (nonatomic,assign) BOOL isHasTopMargin;

///是否隐藏左边icon、查看更多按钮和分割线
@property (nonatomic,assign) BOOL isHiddenLeftIcon;
@property (nonatomic,assign) BOOL isHiddenRightBtn;
@property (nonatomic,assign) BOOL isHiddenSeperatorLine;

///头视图点击回调
@property (nonatomic,copy) void (^collectionViewHeaderViewTapBlock) ();


@end
