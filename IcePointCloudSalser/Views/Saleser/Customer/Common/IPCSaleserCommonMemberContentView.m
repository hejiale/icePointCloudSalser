//
//  IPCSaleserCommonMemberView.m
//  IcePointCloudSalser
//
//  Created by gerry on 2018/3/13.
//  Copyright © 2018年 Doray. All rights reserved.
//

#import "IPCSaleserCommonMemberContentView.h"
#import "IPCSaleserCustomerUpgradeMemberView.h"
#import "IPCSaleserMemberAlertView.h"
#import "IPCSaleserMemberInfoView.h"
#import "IPCScanCodeViewController.h"

@interface IPCSaleserCommonMemberContentView()

@property (strong, nonatomic)   UIView *memberCardContentView;
@property (strong, nonatomic)   UIView *compulsoryVerifityView;
@property (strong, nonatomic)   UILabel *unCheckMemberLabel;
@property (strong, nonatomic)   IPCSaleserMemberAlertView *memberAlertView;
@property (strong, nonatomic)   IPCSaleserMemberInfoView * memberInfoView;
@property (strong, nonatomic)   IPCSaleserCustomerUpgradeMemberView * customerUpgraderView;
@property (nonatomic, strong) IPCPortraitNavigationViewController * cameraNav;

@end

@implementation IPCSaleserCommonMemberContentView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self loadUI];
    [self loadCustomerMemberInfoView:NO];
}

#pragma mark //Set UI
- (void)loadUI
{
    UILabel * titleLabel = [[UILabel alloc]init];
    [titleLabel setText:@"会员卡"];
    [titleLabel setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightMedium]];
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(20);
        make.width.mas_equalTo(55);
        make.top.equalTo(self.mas_top).with.offset(15);
        make.height.mas_equalTo(20);
    }];
    
    UIButton * scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanButton setTitle:@"扫码验证" forState:UIControlStateNormal];
    [scanButton.titleLabel setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightMedium]];
    [scanButton setTitleColor:COLOR_RGB_BLUE forState:UIControlStateNormal];
    [scanButton addTarget:self action:@selector(validationMemberAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:scanButton];
    
    [scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(self.mas_top).with.offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    
    UIImageView * line = [[UIImageView alloc]init];
    [line setBackgroundColor:COLOR_RGB_BLUE];
    [self addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(titleLabel.mas_bottom).with.offset(10);
        make.height.mas_equalTo(1);
    }];
    
    [self addSubview:self.unCheckMemberLabel];
    [self.unCheckMemberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).with.offset(0);
        make.centerY.equalTo(titleLabel.mas_centerY).with.offset(0);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(21);
    }];
    
    [self addSubview:self.compulsoryVerifityView];
    [self.compulsoryVerifityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(scanButton.mas_left).with.offset(0);
        make.centerY.equalTo(scanButton.mas_centerY).with.offset(0);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(30);
    }];
    
    [self addSubview:self.memberCardContentView];
    [self.memberCardContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.top.equalTo(line.mas_bottom).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
    }];
}

- (UILabel *)unCheckMemberLabel
{
    if (!_unCheckMemberLabel) {
        _unCheckMemberLabel = [[UILabel alloc]init];
        [_unCheckMemberLabel setText:@"(未验证会员)"];
        [_unCheckMemberLabel setTextColor:[UIColor colorWithHexString:@"#999999"]];
        [_unCheckMemberLabel setBackgroundColor:[UIColor clearColor]];
        [_unCheckMemberLabel setFont:[UIFont systemFontOfSize:15]];
        [_unCheckMemberLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _unCheckMemberLabel;
}

- (UIView *)compulsoryVerifityView{
    if (!_compulsoryVerifityView) {
        _compulsoryVerifityView = [[UIView alloc]init];
        [_compulsoryVerifityView setBackgroundColor:[UIColor clearColor]];
        
        UIImageView * line = [[UIImageView alloc]init];
        [line setBackgroundColor:COLOR_RGB_BLUE];
        [_compulsoryVerifityView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_compulsoryVerifityView.mas_centerY).with.offset(0);
            make.right.equalTo(_compulsoryVerifityView.mas_right).with.offset(0);
            make.width.mas_equalTo(1);
            make.height.mas_equalTo(12);
        }];
        
        UIButton * verifityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [verifityButton setTitle:@"强制验证" forState:UIControlStateNormal];
        [verifityButton.titleLabel setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightMedium]];
        [verifityButton setTitleColor:COLOR_RGB_BLUE forState:UIControlStateNormal];
        [verifityButton addTarget:self action:@selector(compulsoryVerificationAction:) forControlEvents:UIControlEventTouchUpInside];
        [_compulsoryVerifityView addSubview:verifityButton];
        
        [verifityButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_compulsoryVerifityView.mas_left).with.offset(0);
            make.right.equalTo(line.mas_left).with.offset(0);
            make.top.equalTo(_compulsoryVerifityView.mas_top).with.offset(0);
            make.bottom.equalTo(_compulsoryVerifityView.mas_bottom).with.offset(0);
        }];
        
    }
    return _compulsoryVerifityView;
}

- (UIView *)memberCardContentView{
    if (!_memberCardContentView) {
        _memberCardContentView = [[UIView alloc]init];
        [_memberCardContentView setBackgroundColor:[UIColor clearColor]];
    }
    return _memberCardContentView;
}

- (IPCSaleserMemberAlertView *)memberAlertView{
    if (!_memberAlertView) {
        _memberAlertView = [[IPCSaleserMemberAlertView alloc]init];
    }
    return _memberAlertView;
}

- (IPCSaleserMemberInfoView *)memberInfoView{
    if (!_memberInfoView) {
        _memberInfoView = [[IPCSaleserMemberInfoView alloc]init];
    }
    return _memberInfoView;
}

- (IPCSaleserCustomerUpgradeMemberView *)customerUpgraderView{
    if (!_customerUpgraderView) {
        _customerUpgraderView = [[IPCSaleserCustomerUpgradeMemberView alloc]init];
        [[_customerUpgraderView rac_signalForSelector:@selector(upgradeMemberAction:)] subscribeNext:^(RACTuple * _Nullable x) {
            if ([self.delegate respondsToSelector:@selector(upgradeMember)]) {
                [self.delegate upgradeMember];
            }
        }];
    }
    return _customerUpgraderView;
}

#pragma mark //Clicked Events
- (void)validationMemberAction:(id)sender
{
    IPCScanCodeViewController *scanVc = [[IPCScanCodeViewController alloc] initWithFinish:^(NSString *result, NSError *error)
    {
        [self.cameraNav dismissViewControllerAnimated:YES completion:nil];
        
        if ([self.delegate respondsToSelector:@selector(validationMember:)]) {
            [self.delegate validationMember:result];
        }
    }];
    self.cameraNav = [[IPCPortraitNavigationViewController alloc]initWithRootViewController:scanVc];
    [[IPCAppManager sharedManager].currentLevelViewController presentViewController:self.cameraNav  animated:YES completion:nil];
}

///强制验证通过
- (void)compulsoryVerificationAction:(id)sender
{
    [IPCPayOrderManager sharedManager].isValiateMember = YES;
    [IPCPayOrderManager sharedManager].memberCheckType = @"COMPEL";
    [IPCPayOrderManager sharedManager].customDiscount = [[IPCShoppingCart sharedCart] customDiscount];
    [self loadCustomerMemberInfoView:[self.dataSource isSelectMemberStatus]];
}


#pragma mark //Load Events
- (void)loadCustomerMemberInfoView:(BOOL)isChoose
{
    [self clearMemberInfoView];
    
    if ([IPCPayOrderManager sharedManager].currentCustomerId || [IPCPayOrderManager sharedManager].currentMemberCustomerId)
    {
        if (isChoose) {
            [self.memberInfoView updateMemberCardInfo:[IPCPayOrderCurrentCustomer sharedManager].currentMember];
            [self loadMemberInfoView];
        }else{
            if ([IPCPayOrderCurrentCustomer sharedManager].currentCustomer.memberLevel) {
                [self.memberInfoView updateMemberCardInfo:[IPCPayOrderCurrentCustomer sharedManager].currentCustomer];
                [self loadMemberInfoView];
            }else{
                [self.memberCardContentView addSubview:self.customerUpgraderView];
                [self.customerUpgraderView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.memberCardContentView.mas_left).with.offset(0);
                    make.right.equalTo(self.memberCardContentView.mas_right).with.offset(0);
                    make.top.equalTo(self.memberCardContentView.mas_top).with.offset(0);
                    make.bottom.equalTo(self.memberCardContentView.mas_bottom).with.offset(0);
                }];
            }
        }
        if (([IPCPayOrderCurrentCustomer sharedManager].currentCustomer.memberLevel || [IPCPayOrderCurrentCustomer sharedManager].currentMember) && ![IPCAppManager sharedManager].companyCofig.isCheckMember)
        {
            if (![IPCPayOrderManager sharedManager].isValiateMember){
                if ([IPCAppManager sharedManager].authList.forceVerifyMember) {
                    [self.unCheckMemberLabel setHidden:NO];
                    [self.compulsoryVerifityView setHidden:NO];
                }else{
                    [self.unCheckMemberLabel setHidden:NO];
                }
            }
        }
    }else{
        [self.memberCardContentView addSubview:self.memberAlertView];
        [self.memberAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.memberCardContentView.mas_left).with.offset(0);
            make.right.equalTo(self.memberCardContentView.mas_right).with.offset(0);
            make.top.equalTo(self.memberCardContentView.mas_top).with.offset(0);
            make.bottom.equalTo(self.memberCardContentView.mas_bottom).with.offset(0);
        }];
        
        if (![IPCPayOrderManager sharedManager].currentCustomerId && ![IPCPayOrderManager sharedManager].currentMemberCustomerId) {
            [self.memberAlertView updateUI:[self.dataSource isSelectMemberStatus]];
        }
    }
}

- (void)loadMemberInfoView{
    [self.memberCardContentView addSubview:self.memberInfoView];
    [self.memberInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.memberCardContentView.mas_left).with.offset(0);
        make.right.equalTo(self.memberCardContentView.mas_right).with.offset(0);
        make.top.equalTo(self.memberCardContentView.mas_top).with.offset(0);
        make.bottom.equalTo(self.memberCardContentView.mas_bottom).with.offset(0);
    }];
}

- (void)clearMemberInfoView
{
    [self.memberInfoView removeFromSuperview];self.memberInfoView = nil;
    [self.memberAlertView removeFromSuperview];self.memberAlertView = nil;
    [self.customerUpgraderView removeFromSuperview];self.customerUpgraderView = nil;
    [self.unCheckMemberLabel setHidden:YES];
    [self.compulsoryVerifityView setHidden:YES];
}


@end
