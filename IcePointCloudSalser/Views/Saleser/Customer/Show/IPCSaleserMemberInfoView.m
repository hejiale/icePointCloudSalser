//
//  IPCSaleserMemberInfoView.m
//  IcePointCloudSalser
//
//  Created by gerry on 2018/3/12.
//  Copyright © 2018年 Doray. All rights reserved.
//

#import "IPCSaleserMemberInfoView.h"

@interface IPCSaleserMemberInfoView()

@property (strong, nonatomic)  UILabel *balanceLabel;
@property (strong, nonatomic)  UILabel *pointLabel;
@property (strong, nonatomic)  UILabel *discountLabel;
@property (strong, nonatomic)  UILabel *encryptedPhoneLabel;
@property (strong, nonatomic)  UILabel *growthValueLabel;
@property (strong, nonatomic)  UIView *memberLevelView;
@property (strong, nonatomic)  UILabel *memberLevelLabel;

@end

@implementation IPCSaleserMemberInfoView


- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self loadUI];
    
}

#pragma mark //Load UI
- (void)loadUI
{
    UIView * pointView = [[UIView alloc]init];
    [pointView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:pointView];
    
    UIView * balanceView = [[UIView alloc]init];
    [balanceView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:balanceView];
    
    UIView * discountView = [[UIView alloc]init];
    [discountView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:discountView];
    
    [@[pointView, balanceView, discountView] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    [@[pointView, balanceView, discountView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(35);
        make.height.mas_equalTo(90);
    }];
    
    UILabel * pointTitleLable = [[UILabel alloc]init];
    [pointTitleLable setFont:[UIFont systemFontOfSize:15]];
    [pointTitleLable setTextColor:[UIColor colorWithHexString:@"#999999"]];
    [pointTitleLable setText:@"积分"];
    [pointTitleLable setTextAlignment:NSTextAlignmentCenter];
    [pointView addSubview:pointTitleLable];
    
    [pointTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pointView.mas_top).with.offset(0);
        make.centerX.equalTo(pointView.mas_centerX).with.offset(0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(40);
    }];
    
    UILabel * balanceTitleLable = [[UILabel alloc]init];
    [balanceTitleLable setFont:[UIFont systemFontOfSize:15]];
    [balanceTitleLable setTextColor:[UIColor colorWithHexString:@"#999999"]];
    [balanceTitleLable setText:@"储值"];
    [balanceTitleLable setTextAlignment:NSTextAlignmentCenter];
    [balanceView addSubview:balanceTitleLable];
    
    [balanceTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(balanceView.mas_top).with.offset(0);
        make.centerX.equalTo(balanceView.mas_centerX).with.offset(0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(40);
    }];
    
    UILabel * discountTitleLable = [[UILabel alloc]init];
    [discountTitleLable setFont:[UIFont systemFontOfSize:15]];
    [discountTitleLable setTextColor:[UIColor colorWithHexString:@"#999999"]];
    [discountTitleLable setText:@"折扣"];
    [discountTitleLable setTextAlignment:NSTextAlignmentCenter];
    [discountView addSubview:discountTitleLable];
    
    [discountTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(discountView.mas_top).with.offset(0);
        make.centerX.equalTo(discountView.mas_centerX).with.offset(0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(40);
    }];
    
    [pointView addSubview:self.pointLabel];
    [balanceView addSubview:self.balanceLabel];
    [discountView addSubview:self.discountLabel];
    
    [self.pointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pointTitleLable.mas_bottom).with.offset(0);
        make.left.equalTo(pointView.mas_left).with.offset(0);
        make.right.equalTo(pointView.mas_right).with.offset(0);
        make.bottom.equalTo(pointView.mas_bottom).with.offset(0);
    }];
    
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(balanceTitleLable.mas_bottom).with.offset(0);
        make.left.equalTo(balanceView.mas_left).with.offset(0);
        make.right.equalTo(balanceView.mas_right).with.offset(0);
        make.bottom.equalTo(balanceView.mas_bottom).with.offset(0);
    }];
    
    [self.discountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(discountTitleLable.mas_bottom).with.offset(0);
        make.left.equalTo(discountView.mas_left).with.offset(0);
        make.right.equalTo(discountView.mas_right).with.offset(0);
        make.bottom.equalTo(discountView.mas_bottom).with.offset(0);
    }];
    
    UILabel * phoneTitleLable = [[UILabel alloc]init];
    [phoneTitleLable setFont:[UIFont systemFontOfSize:15]];
    [phoneTitleLable setTextColor:[UIColor colorWithHexString:@"#999999"]];
    [phoneTitleLable setText:@"密保手机"];
    [self addSubview:phoneTitleLable];
    
    [phoneTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(20);
        make.top.equalTo(pointView.mas_bottom).with.offset(20);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    UILabel * growthTitleLable = [[UILabel alloc]init];
    [growthTitleLable setFont:[UIFont systemFontOfSize:15]];
    [growthTitleLable setTextColor:[UIColor colorWithHexString:@"#999999"]];
    [growthTitleLable setText:@"成长值"];
    [self addSubview:growthTitleLable];
    
    [growthTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(20);
        make.top.equalTo(phoneTitleLable.mas_bottom).with.offset(20);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    [self addSubview:self.encryptedPhoneLabel];
    [self addSubview:self.growthValueLabel];
    
    [self.encryptedPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneTitleLable.mas_right).with.offset(20);
        make.centerY.equalTo(phoneTitleLable.mas_centerY).with.offset(0);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(30);
    }];
    
    [self.growthValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(growthTitleLable.mas_right).with.offset(20);
        make.centerY.equalTo(growthTitleLable.mas_centerY).with.offset(0);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(30);
    }];
    
    [self addSubview:self.memberLevelView];
    [self.memberLevelView addSubview:self.memberLevelLabel];
    
    [self.memberLevelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-20);
        make.centerY.equalTo(self.encryptedPhoneLabel.mas_centerY).with.offset(0);
        make.height.mas_equalTo(26);
    }];
    
    [self.memberLevelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.memberLevelView.mas_left).with.offset(0);
        make.right.equalTo(self.memberLevelView.mas_right).with.offset(0);
        make.top.equalTo(self.memberLevelView.mas_top).with.offset(0);
        make.bottom.equalTo(self.memberLevelView.mas_bottom).with.offset(0);
    }];
    
}

#pragma mark //Set UI
- (UILabel *)pointLabel{
    if (!_pointLabel) {
        _pointLabel = [[UILabel alloc]init];
        [_pointLabel setFont:[UIFont systemFontOfSize:26]];
        [_pointLabel setTextColor:[UIColor colorWithHexString:@"#333333"]];
        [_pointLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _pointLabel;
}

- (UILabel *)balanceLabel{
    if (!_balanceLabel) {
        _balanceLabel = [[UILabel alloc]init];
        [_balanceLabel setFont:[UIFont systemFontOfSize:26]];
        [_balanceLabel setTextColor:[UIColor colorWithHexString:@"#333333"]];
        [_balanceLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _balanceLabel;
}

- (UILabel *)discountLabel{
    if (!_discountLabel) {
        _discountLabel = [[UILabel alloc]init];
        [_discountLabel setFont:[UIFont systemFontOfSize:26]];
        [_discountLabel setTextColor:[UIColor colorWithHexString:@"#333333"]];
        [_discountLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _discountLabel;
}

- (UILabel *)encryptedPhoneLabel{
    if (!_encryptedPhoneLabel) {
        _encryptedPhoneLabel = [[UILabel alloc]init];
        [_encryptedPhoneLabel setFont:[UIFont systemFontOfSize:15]];
        [_encryptedPhoneLabel setTextColor:[UIColor colorWithHexString:@"#333333"]];
    }
    return _encryptedPhoneLabel;
}

- (UILabel *)growthValueLabel{
    if (!_growthValueLabel) {
        _growthValueLabel = [[UILabel alloc]init];
        [_growthValueLabel setFont:[UIFont systemFontOfSize:15]];
        [_growthValueLabel setTextColor:[UIColor colorWithHexString:@"#333333"]];
    }
    return _growthValueLabel;
}

- (UIView *)memberLevelView{
    if (!_memberLevelView) {
        _memberLevelView = [[UIView alloc]init];
        [_memberLevelView setBackgroundColor:COLOR_RGB_BLUE];
        [_memberLevelView addBorder:3 Width:0 Color:nil];
    }
    return _memberLevelView;
}

- (UILabel *)memberLevelLabel{
    if (!_memberLevelLabel) {
        _memberLevelLabel = [[UILabel alloc]init];
        [_memberLevelLabel setFont:[UIFont systemFontOfSize:15]];
        [_memberLevelLabel setTextColor:[UIColor whiteColor]];
        [_memberLevelLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _memberLevelLabel;
}

#pragma mark //Reload Events
- (void)updateMemberCardInfo:(IPCCustomerMode *)customer
{
    CGFloat width = [customer.memberLevel jk_sizeWithFont:self.memberLevelLabel.font constrainedToHeight:self.memberLevelLabel.jk_height].width;
    [self.memberLevelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width+10);
    }];
    
    [self.pointLabel setText:[NSString stringWithFormat:@"%.f", customer.integral]];
    [self.memberLevelLabel setText:customer.memberLevel];
    [self.growthValueLabel setText:customer.membergrowth];
    [self.encryptedPhoneLabel setText:customer.memberPhone];
    [self.discountLabel setText:[NSString stringWithFormat:@"%.f%%%", [customer useDiscount]]];
    [self.balanceLabel setText:[NSString stringWithFormat:@"￥%.2f", customer.balance]];
}

@end
