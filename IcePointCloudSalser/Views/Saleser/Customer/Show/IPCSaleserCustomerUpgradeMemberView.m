//
//  IPCSaleserCustomerUpgradeMemberView.m
//  IcePointCloudSalser
//
//  Created by gerry on 2018/3/14.
//  Copyright © 2018年 Doray. All rights reserved.
//

#import "IPCSaleserCustomerUpgradeMemberView.h"

@interface IPCSaleserCustomerUpgradeMemberView()



@end

@implementation IPCSaleserCustomerUpgradeMemberView


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIButton *  upgradeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [upgradeButton setTitle:@"创建会员卡" forState:UIControlStateNormal];
    [upgradeButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [upgradeButton setTitleColor:COLOR_RGB_BLUE forState:UIControlStateNormal];
    [upgradeButton addBorder:18 Width:1 Color:COLOR_RGB_BLUE];
    [upgradeButton addTarget:self action:@selector(upgradeMemberAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:upgradeButton];
    
    [upgradeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).with.offset(0);
        make.centerX.equalTo(self.mas_centerX).with.offset(0);
        make.width.mas_equalTo(220);
        make.height.mas_equalTo(36);
    }];
    
    UILabel * titleLabel = [[UILabel alloc]init];
    [titleLabel setText:@"创建成功后与客户绑定，即升级为会员"];
    [titleLabel setFont:[UIFont systemFontOfSize:13 weight:UIFontWeightMedium]];
    [titleLabel setTextColor:[UIColor colorWithHexString:@"#999999"]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upgradeButton.mas_bottom).with.offset(20);
        make.centerX.equalTo(self.mas_centerX).with.offset(0);
        make.width.mas_equalTo(260);
        make.height.mas_equalTo(20);
        
    }];
}

- (void)upgradeMemberAction:(id)sender {
}

@end
