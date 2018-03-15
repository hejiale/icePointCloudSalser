//
//  IPCSaleserCommonCustomerView.m
//  IcePointCloudSalser
//
//  Created by gerry on 2018/3/13.
//  Copyright © 2018年 Doray. All rights reserved.
//

#import "IPCSaleserCommonCustomerContentView.h"
#import "IPCSaleserCustomInfoView.h"
#import "IPCSaleserCustomerAlertView.h"
#import "IPCSaleserMemberNoneCustomerView.h"
#import "IPCSaleserMemberCustomerListView.h"

@interface IPCSaleserCommonCustomerContentView()

@property (strong, nonatomic)   UIButton *editButton;
@property (strong, nonatomic)   UIView *customInfoContentView;
@property (nonatomic, strong) IPCSaleserCustomerAlertView*customerAlertView;
@property (nonatomic, strong) IPCSaleserCustomInfoView * infoView;
@property (nonatomic, strong) IPCSaleserMemberNoneCustomerView * memberNoneCustomerView;
@property (nonatomic, strong) IPCSaleserMemberCustomerListView * memberCustomerListView;

@end

@implementation IPCSaleserCommonCustomerContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    [self loadUI];
     [self loadCustomerInfoView:nil];
}

#pragma mark //Set UI
- (void)loadUI
{
    UILabel * titleLabel = [[UILabel alloc]init];
    [titleLabel setText:@"客户信息"];
    [titleLabel setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightMedium]];
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(20);
        make.width.mas_equalTo(70);
        make.top.equalTo(self.mas_top).with.offset(15);
        make.height.mas_equalTo(20);
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
    
    [self addSubview:self.editButton];
    [self addSubview:self.customInfoContentView];
    
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(self.mas_top).with.offset(10);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(33);
    }];
    
    [self.customInfoContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.top.equalTo(line.mas_bottom).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
    }];
}

- (UIButton *)editButton
{
    if (!_editButton) {
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_editButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [_editButton setTitleColor:COLOR_RGB_BLUE forState:UIControlStateNormal];
        [_editButton addTarget:self action:@selector(updateCustomerAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editButton;
}

- (UIView *)customInfoContentView{
    if (!_customInfoContentView) {
        _customInfoContentView = [[UIView alloc]init];
    }
    return _customInfoContentView;
}


- (IPCSaleserCustomInfoView *)infoView
{
    if (!_infoView) {
        _infoView = [[IPCSaleserCustomInfoView alloc]initWithFrame:self.customInfoContentView.bounds];
    }
    return _infoView;
}


- (IPCSaleserCustomerAlertView *)customerAlertView{
    if (!_customerAlertView) {
        _customerAlertView = [[IPCSaleserCustomerAlertView alloc]init];
    }
    return _customerAlertView;
}

- (IPCSaleserMemberNoneCustomerView *)memberNoneCustomerView{
    if (!_memberNoneCustomerView) {
        __weak typeof(self) weakSelf = self;
        _memberNoneCustomerView = [[IPCSaleserMemberNoneCustomerView alloc]init];
        [[_memberNoneCustomerView rac_signalForSelector:@selector(bindCustomerAction:)] subscribeNext:^(RACTuple * _Nullable x) {
//            [weakSelf loadMemberChooseCustomerView];
        }];
        [[_memberNoneCustomerView rac_signalForSelector:@selector(createCustomerAction:)] subscribeNext:^(RACTuple * _Nullable x) {
//            [weakSelf showEditCustomerView:YES];
        }];
        [[_memberNoneCustomerView rac_signalForSelector:@selector(createWithVistorAction:)] subscribeNext:^(RACTuple * _Nullable x) {
//            [weakSelf queryVisitorCustomer];
        }];
    }
    return _memberNoneCustomerView;
}

- (IPCSaleserMemberCustomerListView *)memberCustomerListView{
    if (!_memberCustomerListView) {
        __weak typeof(self) weakSelf = self;
        _memberCustomerListView = [[IPCSaleserMemberCustomerListView alloc]initWithFrame:self.customInfoContentView.bounds Select:^(IPCCustomerMode *customer)
                                   {
                                       __strong typeof(weakSelf) strongSelf = weakSelf;
                                       [IPCPayOrderCurrentCustomer sharedManager].currentMemberCustomer = customer;
                                       [weakSelf loadCustomerInfoView:customer];
                                   }];
    }
    return _memberCustomerListView;
}

#pragma mark //Load Events
- (void)loadCustomerInfoView:(IPCCustomerMode *)customer
{
    [self clearCustomerInfoView];
    
    if (customer) {
        [self.editButton setHidden:NO];
        [self.infoView updateCustomerInfo: customer];
        [self.customInfoContentView addSubview:self.infoView];
    }else{
        [self.editButton setHidden:YES];
        [self.customInfoContentView addSubview:self.customerAlertView];
        [self.customerAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.customInfoContentView.mas_left).with.offset(0);
            make.right.equalTo(self.customInfoContentView.mas_right).with.offset(0);
            make.top.equalTo(self.customInfoContentView.mas_top).with.offset(0);
            make.bottom.equalTo(self.customInfoContentView.mas_bottom).with.offset(0);
        }];
        
        if (![IPCPayOrderManager sharedManager].currentCustomerId && ![IPCPayOrderManager sharedManager].currentMemberCustomerId) {
//            [self.customerAlertView updateUI:isSelectMemberStatus];
        }
    }
//    [self resetCustomerData];
    
    if (!customer.isVisitor) {
//        [self.viewModel queryCustomerOptometry];
    }
}

- (void)loadMemberCustomerListView:(NSArray<IPCCustomerMode *> *)customerList
{
        [self clearCustomerInfoView];
        [self.editButton setHidden:YES];
    
        if (customerList.count) {
            if (customerList.count > 1) {
                [self.memberCustomerListView reloadCustomerListView:customerList];
                [self.customInfoContentView addSubview:self.memberCustomerListView];
                [self.memberCustomerListView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.customInfoContentView.mas_left).with.offset(0);
                    make.right.equalTo(self.customInfoContentView.mas_right).with.offset(0);
                    make.top.equalTo(self.customInfoContentView.mas_top).with.offset(0);
                    make.bottom.equalTo(self.customInfoContentView.mas_bottom).with.offset(0);
                }];
            }else{
                IPCCustomerMode * customer = customerList[0];
                [IPCPayOrderCurrentCustomer sharedManager].currentMemberCustomer = customer;
                [self loadCustomerInfoView:customer];
            }
        }else{
            [self.customInfoContentView addSubview:self.memberNoneCustomerView];
            [self.memberNoneCustomerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.customInfoContentView.mas_left).with.offset(0);
                make.right.equalTo(self.customInfoContentView.mas_right).with.offset(0);
                make.top.equalTo(self.customInfoContentView.mas_top).with.offset(0);
                make.bottom.equalTo(self.customInfoContentView.mas_bottom).with.offset(0);
            }];
        }
}

- (void)clearCustomerInfoView
{
    [self.infoView removeFromSuperview];self.infoView = nil;
    [self.customerAlertView removeFromSuperview];self.customerAlertView = nil;
    [self.memberNoneCustomerView removeFromSuperview];self.memberNoneCustomerView = nil;
    [self.memberCustomerListView removeFromSuperview];self.memberCustomerListView = nil;
}

@end
