//
//  IPCSaleserMemberAlertView.m
//  IcePointCloudSalser
//
//  Created by gerry on 2018/3/12.
//  Copyright © 2018年 Doray. All rights reserved.
//

#import "IPCSaleserMemberAlertView.h"

@interface IPCSaleserMemberAlertView()



@end

@implementation IPCSaleserMemberAlertView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIImageView * alertImageView = [[UIImageView alloc]init];
    [alertImageView setImage:[UIImage imageNamed:@"icon_alert_member"]];
    [alertImageView setBackgroundColor:[UIColor clearColor]];
    alertImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:alertImageView];
    
    [alertImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(0);
        make.centerY.equalTo(self.mas_centerY).with.offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    
    UILabel * label = [[UILabel alloc]init];
    [label setText:@"请选择会员"];
    [label setTextColor:COLOR_RGB_BLUE];
    [label setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightMedium]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(0);
        make.top.equalTo(alertImageView.mas_bottom).with.offset(10);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(20);
    }];
}

- (void)updateUI:(BOOL)isHiden
{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setHidden:!isHiden];
    }];
}

@end
