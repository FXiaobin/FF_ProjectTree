//
//  FFEmptyView.m
//  FFEmptyView
//
//  Created by lovepinyao on 16/9/1.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "FFEmptyView.h"

#define TopMargin       15.0
#define IconWidth       200.0
#define IconHeight      100.0
#define ReloadBtnWidth  150.0
#define ReloadBtnHeight 30.0
#define TipLabelHeight  30.0
#define TipLabelMargin  50.0

@interface FFEmptyView ()

@property (nonatomic,assign) CGFloat tipLabelHeight;

@end

@implementation FFEmptyView

-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

-(void)showInView:(UIView *)showView tipText:(NSString *)tipText iconName:(NSString *)iconName reloadBtnTitle:(NSString *)btnTitle{
    
    self.frame = showView.bounds;
    self.backgroundColor = [UIColor whiteColor];
    [showView addSubview:self];
    
    self.emptyIcon = [[UIImageView alloc] init];
    self.emptyIcon.image = [UIImage imageNamed:iconName];
    self.emptyIcon.clipsToBounds = YES;
    self.emptyIcon.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.emptyIcon];

    self.tipLabel = [[UILabel alloc] init];
    self.tipLabel.text = tipText;
    self.tipLabel.numberOfLines = 0;
    self.tipLabel.font = [UIFont systemFontOfSize:14.0];
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.tipLabel];
    
    CGSize tipLabelSize = [self.tipLabel sizeThatFits:CGSizeMake( CGRectGetWidth(self.frame) - 2*TipLabelMargin, 100.0)];
    if (tipLabelSize.height < TipLabelHeight) {
        self.tipLabelHeight = TipLabelHeight;
    }else{
        self.tipLabelHeight = tipLabelSize.height;
    }
    
    if (btnTitle && btnTitle.length) {
        self.reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.reloadBtn setTitle:btnTitle forState:UIControlStateNormal];
        self.reloadBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        self.reloadBtn.clipsToBounds = YES;
        self.reloadBtn.layer.cornerRadius = ReloadBtnHeight/2.0;
        self.reloadBtn.layer.borderColor = [UIColor blackColor].CGColor;
        self.reloadBtn.layer.borderWidth = 0.5;
        [self.reloadBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.reloadBtn addTarget:self action:@selector(reloadBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.reloadBtn];
    }
    
    CGSize iconSize = CGSizeMake(IconWidth, IconHeight);
    [self updateFrameWithIconSize:iconSize];
    
}

- (void)updateFrameWithIconSize:(CGSize)iconSize{
    
    CGFloat topSpace = (iconSize.height/2.0 + self.tipLabelHeight + TopMargin + 2 * TopMargin) / 2.0;
    self.emptyIcon.frame = CGRectMake((CGRectGetWidth(self.frame) - iconSize.width)/2.0, (CGRectGetHeight(self.frame) - iconSize.height)/2.0 - topSpace, iconSize.width, iconSize.height);
    self.tipLabel.frame = CGRectMake(TipLabelMargin, CGRectGetMaxY(self.emptyIcon.frame) + TopMargin, CGRectGetWidth(self.frame) - 2*TipLabelMargin, self.tipLabelHeight);
    self.reloadBtn.frame = CGRectMake(CGRectGetMidX(self.frame) - ReloadBtnWidth/2.0, CGRectGetMaxY(self.tipLabel.frame) + TopMargin, ReloadBtnWidth, ReloadBtnHeight);
}

- (void)updateReloadBtnSize:(CGSize)btnSize{
    
    self.reloadBtn.frame = CGRectMake(CGRectGetMidX(self.frame) - btnSize.width/2.0, CGRectGetMaxY(self.tipLabel.frame) + TopMargin, btnSize.width, btnSize.height);
    self.reloadBtn.layer.cornerRadius = btnSize.height / 2.0;
}

- (void)reloadBtnAction:(UIButton *)sender{
    if (self.reloadBtnBlock) {
        self.reloadBtnBlock(self,sender);
    }
}

- (void)removeEmptyView{
    
    for (UIView *subView in self.subviews) {
        for (UIView *ssub in subView.subviews) {
            [ssub removeFromSuperview];
        }
        [subView removeFromSuperview];
    }
    [self removeFromSuperview];
}


@end
