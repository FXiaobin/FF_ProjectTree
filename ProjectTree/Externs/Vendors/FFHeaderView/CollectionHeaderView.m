//
//  CollectionHeaderView.m
//  PublicDrugComment-OC
//
//  Created by lovepinyao on 16/10/8.
//  Copyright © 2016年 Shanghai Xuanyao Network Technology Co., Ltd. All rights reserved.
//

#import "CollectionHeaderView.h"
#import "Masonry.h"

//配置header
#define CollectionHeader_TitleFont      MAIN_FONT(15.0)
#define CollectionHeader_TitleColor     [UIColor blackColor]
#define CollectionHeader_BtnTitleFont   MAIN_FONT(14.0)
#define CollectionHeader_BtnTitleColor  [UIColor grayColor]
#define CollectionHeader_TopMargin      10.0
#define CollectionHeader_SepratorColor  [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0]

@interface CollectionHeaderView ()

@property (nonatomic,strong) UIImageView *headerIcon;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIButton *rightBtn;

@property (nonatomic,strong) UIImageView *seperatorLine;

@property (nonatomic,strong) UIView *bgView;

@end

@implementation CollectionHeaderView

-(instancetype)init{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(NSString *)reuseIdentifier{
    return @"CollectionHeaderView";
}

-(void)setHeaderTitle:(NSString *)headerTitle{
    self.titleLabel.text = headerTitle;
}

-(void)setHeaderTitleColor:(UIColor *)headerTitleColor{
    self.titleLabel.textColor = headerTitleColor;
}

-(void)setHeaderTitleFont:(UIFont *)headerTitleFont{
    self.titleLabel.font = headerTitleFont;
}

-(void)setHeaderBtnTitleFont:(UIFont *)headerBtnTitleFont{
    self.rightBtn.titleLabel.font = headerBtnTitleFont;
}

-(void)setHeaderBtnTitleColor:(UIColor *)headerBtnTitleColor{
    [self.rightBtn setTitleColor:headerBtnTitleColor forState:UIControlStateNormal];
}

-(void)setHeaderBtnTitle:(NSString *)headerBtnTitle{
    [self.rightBtn setTitle:headerBtnTitle forState:UIControlStateNormal];
}

-(void)setHeaderIconName:(NSString *)headerIconName{
    self.headerIcon.image = [UIImage imageNamed:headerIconName];
}

-(void)setHeaderSeperatorColor:(UIColor *)headerSeperatorColor{
    self.seperatorLine.backgroundColor = headerSeperatorColor;
}

-(void)setup{
    
    self.backgroundColor = [UIColor clearColor];
    
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bgView];
    
    self.headerIcon = [[UIImageView alloc] init];
    [self.bgView addSubview:self.headerIcon];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = CollectionHeader_TitleColor;
    self.titleLabel.font = CollectionHeader_TitleFont;
    [self.bgView addSubview:self.titleLabel];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBtn setTitleColor:CollectionHeader_BtnTitleColor forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"查看更多 >" forState:UIControlStateNormal];
    self.rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    self.rightBtn.titleLabel.font = CollectionHeader_BtnTitleFont;
    self.rightBtn.userInteractionEnabled = NO;
    [self.bgView addSubview:self.rightBtn];
    
    
    self.seperatorLine = [[UIImageView alloc] init];
    self.seperatorLine.backgroundColor = CollectionHeader_SepratorColor;
    [self.bgView addSubview:self.seperatorLine];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lookMoreTapAction:)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
    
}

- (void)lookMoreTapAction:(UITapGestureRecognizer *)sender{
    if (self.collectionViewHeaderViewTapBlock) {
        self.collectionViewHeaderViewTapBlock();
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.isHasTopMargin) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(CollectionHeader_TopMargin, 0, 0, 0));
            
        }else{
            make.edges.equalTo(self).with.insets(UIEdgeInsetsZero);
        }
    }];
    
    if (self.isHiddenLeftIcon) {
        [self.headerIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView.mas_left).offset(0.0);
            make.width.mas_equalTo(0.0);
            make.height.mas_equalTo(0.0);
            make.centerY.equalTo(self.bgView);
        }];
        
    }else{
        [self.headerIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView.mas_left).offset(10.0);
            make.width.mas_equalTo(20.0);
            make.height.mas_equalTo(20.0);
            make.centerY.equalTo(self.bgView);
        }];
    }
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerIcon.mas_right).offset(10.0);
        make.centerY.equalTo(self.bgView);
    }];
    
    if (self.isHiddenRightBtn) {
        [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bgView).offset(-15.0);
            make.centerY.equalTo(self.bgView);
            make.width.mas_equalTo(0.0);
            make.height.mas_equalTo(30.0);
        }];
        
    }else{
        [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bgView).offset(-15.0);
            make.centerY.equalTo(self.bgView);
            make.left.equalTo(self.titleLabel.mas_right).offset(15.0);
            make.height.mas_equalTo(30.0);
        }];
    }
    
    if (self.isHiddenSeperatorLine) {
        [self.seperatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView.mas_left);
            make.bottom.equalTo(self.bgView.mas_bottom);
            make.right.equalTo(self.bgView.mas_right);
            make.height.mas_equalTo(0.0);
        }];
    }else{
        [self.seperatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView);
            make.bottom.equalTo(self.bgView).offset(-1.0);;
            make.right.equalTo(self.bgView);
            make.height.mas_equalTo(1.0);
        }];
    }
}



@end
