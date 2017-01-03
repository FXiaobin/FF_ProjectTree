//
//  CommonHeaderView.m
//  PublicDrugComment-OC
//
//  Created by lovepinyao on 16/9/27.
//  Copyright © 2016年 Shanghai Xuanyao Network Technology Co., Ltd. All rights reserved.
//

#import "CommonHeaderView.h"
#import "Masonry.h"

//配置header
#define CommonHeader_TitleFont      MAIN_FONT(15.0)
#define CommonHeader_TitleColor     [UIColor blackColor]
#define CommonHeader_BtnTitleFont   MAIN_FONT(14.0)
#define CommonHeader_BtnTitleColor  [UIColor grayColor]
#define CommonHeader_TopMargin      10.0
#define CommonHeader_SepratorColor  [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0]

@interface CommonHeaderView ()

@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) UIImageView *headerIcon;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIButton *rightBtn;

@property (nonatomic,strong) UIImageView *seperatorLine;

@end

@implementation CommonHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

-(NSString *)reuseIdentifier{
    return @"CommonHeaderView";
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
    
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    
    self.headerIcon = [[UIImageView alloc] init];
    [self.bgView addSubview:self.headerIcon];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = CommonHeader_TitleColor;
    self.titleLabel.font = CommonHeader_TitleFont;
    [self.bgView addSubview:self.titleLabel];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBtn setTitleColor:CommonHeader_BtnTitleColor forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"查看更多 >" forState:UIControlStateNormal];
    self.rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    self.rightBtn.titleLabel.font = CommonHeader_BtnTitleFont;
    self.rightBtn.userInteractionEnabled = NO;
    [self.bgView addSubview:self.rightBtn];
    
    
    self.seperatorLine = [[UIImageView alloc] init];
    self.seperatorLine.backgroundColor = CommonHeader_SepratorColor;
    [self.bgView addSubview:self.seperatorLine];
  
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lookMoreTapAction:)];
    self.contentView.userInteractionEnabled = YES;
    [self.contentView addGestureRecognizer:tap];
    
}

- (void)lookMoreTapAction:(UITapGestureRecognizer *)sender{
    if (self.commonHeaderViewTapBlock) {
        self.commonHeaderViewTapBlock();
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.isHasTopMargin) {
            make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(CommonHeader_TopMargin, 0, 0, 0));
            
        }else{
            make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsZero);
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
