//
//  IPCSaleserCommonCustomerView.m
//  IcePointCloud
//
//  Created by gerry on 2018/2/5.
//  Copyright © 2018年 Doray. All rights reserved.
//

#import "IPCSaleserCommonCustomerView.h"
#import "IPCSaleserCommonCustomerContentView.h"
#import "IPCSaleserCommonMemberContentView.h"
#import "IPCScanCodeViewController.h"
#import "IPCSaleserUpdateCustomerView.h"
#import "IPCSaleserCustomerListView.h"
#import "IPCSaleserInsertCustomerView.h"
#import "IPCUpgradeMemberView.h"
#import "IPCSaleserUpdateCustomerView.h"
#import "IPCSaleserMemberChooseCustomerView.h"
#import "IPCCustomerListViewModel.h"

@interface IPCSaleserCommonCustomerView()
{
    BOOL isSelectMemberStatus;
}
@property (strong, nonatomic)  UIView *customInfoContentView;
@property (strong, nonatomic)  UIView *memberCardContentView;
@property (strong, nonatomic)  UIView *rightContentView;
@property (strong, nonatomic) IPCSaleserCommonCustomerContentView * customerContentView;
@property (strong, nonatomic) IPCSaleserCommonMemberContentView * memberContentView;
@property (nonatomic, strong) IPCSaleserInsertCustomerView * editCustomerView;
@property (nonatomic, strong) IPCUpgradeMemberView *  upgradeMemberView;
@property (nonatomic, strong) IPCUpgradeMemberView* customerUpgradeMemberView;
@property (nonatomic, strong) IPCSaleserUpdateCustomerView * updateCustomerView;
@property (nonatomic, strong) IPCSaleserCustomerListView * customerListView;
@property (nonatomic, strong) IPCSaleserMemberChooseCustomerView* chooseCustomerView;
@property (nonatomic, strong) IPCCustomerListViewModel    * viewModel;

@end

@implementation IPCSaleserCommonCustomerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //Init Data
        self.viewModel = [[IPCCustomerListViewModel alloc]init];
        ///获取客户类别和门店
        [[IPCCustomerManager sharedManager] queryCustomerType];
        [[IPCCustomerManager sharedManager] queryStore];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //Load UI
    [self addSubview:self.customInfoContentView];
    [self addSubview:self.memberCardContentView];
    [self addSubview:self.rightContentView];
    
    [self.customInfoContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(0);
        make.top.equalTo(self.mas_top).with.offset(5);
        make.bottom.equalTo(self.mas_centerY).with.offset(5);
        make.width.mas_equalTo(408);
    }];
    
    [self.memberCardContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(0);
        make.top.equalTo(self.customInfoContentView.mas_bottom).with.offset(5);
        make.bottom.equalTo(self.mas_bottom).with.offset(-5);
        make.width.mas_equalTo(408);
    }];
    
    [self.rightContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.customInfoContentView.mas_right).with.offset(5);
        make.top.equalTo(self.mas_top).with.offset(5);
        make.right.equalTo(self.mas_right).with.offset(-5);
        make.bottom.equalTo(self.mas_bottom).with.offset(-5);
    }];
    
    [self.customInfoContentView addSubview:self.customerContentView];
    [self.rightContentView addSubview:self.customerListView];
    [self.memberCardContentView addSubview:self.memberContentView];
    
    [self.customerContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.customInfoContentView.mas_top).with.offset(0);
        make.bottom.equalTo(self.customInfoContentView.mas_bottom).with.offset(0);
        make.left.equalTo(self.customInfoContentView.mas_left).with.offset(0);
        make.right.equalTo(self.customInfoContentView.mas_right).with.offset(0);
    }];
    
    [self.customerListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rightContentView.mas_top).with.offset(0);
        make.bottom.equalTo(self.rightContentView.mas_bottom).with.offset(0);
        make.left.equalTo(self.rightContentView.mas_left).with.offset(0);
        make.right.equalTo(self.rightContentView.mas_right).with.offset(0);
    }];
    
    [self.memberContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.memberCardContentView.mas_top).with.offset(0);
        make.bottom.equalTo(self.memberCardContentView.mas_bottom).with.offset(0);
        make.left.equalTo(self.memberCardContentView.mas_left).with.offset(0);
        make.right.equalTo(self.memberCardContentView.mas_right).with.offset(0);
    }];
}

#pragma mark //Set UI
- (UIView *)customInfoContentView{
    if (!_customInfoContentView) {
        _customInfoContentView = [[UIView alloc]init];
        [_customInfoContentView setBackgroundColor:[UIColor whiteColor]];
    }
    return _customInfoContentView;
}

- (UIView *)memberCardContentView{
    if (!_memberCardContentView) {
        _memberCardContentView = [[UIView alloc]init];
        [_memberCardContentView setBackgroundColor:[UIColor whiteColor]];
    }
    return _memberCardContentView;
}

- (UIView *)rightContentView{
    if (!_rightContentView) {
        _rightContentView = [[UIView alloc]init];
    }
    return _rightContentView;
}

- (IPCSaleserCommonCustomerContentView *)customerContentView{
    if (!_customerContentView) {
        _customerContentView = [[IPCSaleserCommonCustomerContentView alloc]initWithFrame:CGRectZero];
    }
    return _customerContentView;
}

- (IPCSaleserCommonMemberContentView *)memberContentView{
    if (!_memberContentView) {
        _memberContentView = [[IPCSaleserCommonMemberContentView alloc]initWithFrame:CGRectZero];
    }
    return _memberContentView;
}


- (IPCUpgradeMemberView *)customerUpgradeMemberView{
    if (!_customerUpgradeMemberView) {
        __weak typeof(self) weakSelf = self;
        _customerUpgradeMemberView = [[IPCUpgradeMemberView alloc]initWithFrame:self.memberCardContentView.bounds];
        [[_customerUpgradeMemberView rac_signalForSelector:@selector(upgradeMemberAction:)] subscribeNext:^(RACTuple * _Nullable x) {
            [weakSelf showUpgradeMemberView];
        }];
    }
    return _customerUpgradeMemberView;
}

- (IPCSaleserCustomerListView *)customerListView{
    if (!_customerListView) {
        __weak typeof(self) weakSelf = self;
        _customerListView = [[IPCSaleserCustomerListView alloc]initWithIsChooseStatus:NO
                                                                               Detail:^(IPCCustomerMode* customer, BOOL isMemberReload)
                             {
                                 if (isMemberReload) {
                                     [self.memberContentView loadCustomerMemberInfoView:YES];
                                     [weakSelf queryMemberBindCustomer];
                                 }else{
                                     [weakSelf reloadCustomerInfo];
                                 }
                             } SelectType:^(BOOL isSelectMemeber) {
                                 __strong typeof(weakSelf) strongSelf = weakSelf;
                                 isSelectMemberStatus = isSelectMemeber;
                                 if (![IPCPayOrderManager sharedManager].customerId && ![IPCPayOrderManager sharedManager].currentMemberCustomerId) {
                                     [strongSelf.customerContentView loadCustomerInfoView:nil];
                                     [strongSelf.memberContentView loadCustomerMemberInfoView:NO];
                                 }
                             }];
        [[_customerListView rac_signalForSelector:@selector(insertCustomerAction:)]subscribeNext:^(RACTuple * _Nullable x) {
            [weakSelf showEditCustomerView:NO];
        }];
    }
    return _customerListView;
}

- (IPCSaleserMemberChooseCustomerView *)chooseCustomerView{
    if (!_chooseCustomerView) {
        __weak typeof(self) weakSelf = self;
        _chooseCustomerView = [[IPCSaleserMemberChooseCustomerView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds BindSuccess:^(IPCCustomerMode *customer)
                               {
                                   __strong typeof(weakSelf) strongSelf = weakSelf;
                                   [IPCPayOrderCurrentCustomer sharedManager].currentMemberCustomer = customer;
                                   [strongSelf.customerContentView loadCustomerInfoView:customer];
                               }];
    }
    return _chooseCustomerView;
}

#pragma mark //Load UI
- (void)loadMemberChooseCustomerView
{
    if (self.chooseCustomerView) {
        [self.chooseCustomerView removeFromSuperview];
        self.chooseCustomerView = nil;
    }
    [[UIApplication sharedApplication].keyWindow addSubview:self.chooseCustomerView];
}

#pragma mark //Request Data
- (void)validationMemberRequest:(NSString *)code
{
    __weak typeof(self) weakSelf = self;
    [self.viewModel validationMemberRequest:code Complete:^(IPCCustomerMode * customer)
     {
         if (customer) {
             __strong typeof(weakSelf) strongSelf = weakSelf;
             ///切换至会员列表状态
             isSelectMemberStatus = YES;
             [strongSelf.customerListView changeToMemberStatus];
             
             [IPCPayOrderManager sharedManager].currentCustomerId = nil;
             [IPCPayOrderCurrentCustomer sharedManager].currentCustomer = nil;
             [IPCPayOrderCurrentCustomer sharedManager].currentMemberCustomer = nil;
             [IPCPayOrderCurrentCustomer sharedManager].currentOpometry = nil;
             
             [IPCPayOrderCurrentCustomer sharedManager].currentMember = customer;
             [IPCPayOrderManager sharedManager].currentMemberCustomerId = customer.memberCustomerId;
             [IPCPayOrderManager sharedManager].customDiscount = [[IPCShoppingCart sharedCart] customDiscount];
             
             [strongSelf.memberContentView loadCustomerMemberInfoView:YES];
             [weakSelf queryMemberBindCustomer];
         }
     }];
}

- (void)queryMemberBindCustomer
{
    __weak typeof(self) weakSelf = self;
    [self.viewModel queryBindMemberCustomer:^(NSArray *customerList, NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.customerContentView loadMemberCustomerListView:customerList];
    }];
}

- (void)queryVisitorCustomer
{
    __weak typeof(self) weakSelf = self;
    [self.viewModel queryVisitorCustomer:^ {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.customerContentView loadCustomerInfoView:[IPCPayOrderCurrentCustomer sharedManager].currentMemberCustomer];
    }];
}

- (void)bindMember:(IPCCustomerMode *)customer
{
    [IPCCustomerRequestManager bindMemberWithCustomerId:customer.customerID
                                       MemberCustomerId:[IPCPayOrderManager sharedManager].currentMemberCustomerId
                                           SuccessBlock:^(id responseValue)
     {
         [IPCPayOrderCurrentCustomer sharedManager].currentMemberCustomer = [IPCCustomerMode mj_objectWithKeyValues:responseValue];
         [self.customerContentView loadCustomerInfoView:[IPCPayOrderCurrentCustomer sharedManager].currentMemberCustomer];
     } FailureBlock:^(NSError *error) {
         [IPCCommonUI showError:error.domain];
     }];
}

#pragma mark //Clicked Events
- (void)showEditCustomerView:(BOOL)isBindNewCustomer
{
    
    __weak typeof(self) weakSelf = self;
    self.editCustomerView = [[IPCSaleserInsertCustomerView alloc]initWithFrame:[IPCAppManager sharedManager].currentLevelViewController.view.bounds
                                                                   UpdateBlock:^(IPCCustomerMode * customer)
                             {
                                 __strong typeof(weakSelf) strongSelf = weakSelf;
                                 if (isSelectMemberStatus) {
                                     [weakSelf bindMember:customer];
                                 }else{
                                     [IPCPayOrderManager sharedManager].currentCustomerId = customer.customerID;
                                     [IPCPayOrderCurrentCustomer sharedManager].currentCustomer = customer;
                                     [strongSelf.customerContentView loadCustomerInfoView:customer];
                                     [strongSelf.memberContentView loadCustomerMemberInfoView:NO];
                                     [strongSelf.customerListView loadData];
                                 }
                             }];
    [[IPCAppManager sharedManager].currentLevelViewController.view addSubview:self.editCustomerView];
    [[IPCAppManager sharedManager].currentLevelViewController.view bringSubviewToFront:self.editCustomerView];
}

- (void)updateCustomer
{
    __weak typeof(self) weakSelf = self;
    self.updateCustomerView = [[IPCSaleserUpdateCustomerView alloc]initWithFrame:[IPCAppManager sharedManager].currentLevelViewController.view.bounds
                                                                  DetailCustomer:isSelectMemberStatus ? [IPCPayOrderCurrentCustomer sharedManager].currentMemberCustomer : [IPCPayOrderCurrentCustomer sharedManager].currentCustomer
                                                                     UpdateBlock:^(IPCCustomerMode * customer)
                               {
                                   __strong typeof(weakSelf) strongSelf = weakSelf;
                                   if (isSelectMemberStatus) {
                                       [IPCPayOrderCurrentCustomer sharedManager].currentMemberCustomer = customer;
                                   }else{
                                       [IPCPayOrderCurrentCustomer sharedManager].currentCustomer = customer;
                                   }
                                   [strongSelf.customerContentView loadCustomerInfoView:customer];
                                   [strongSelf.customerListView loadData];
                               }];
    [[IPCAppManager sharedManager].currentLevelViewController.view addSubview:self.updateCustomerView];
    [[IPCAppManager sharedManager].currentLevelViewController.view bringSubviewToFront:self.updateCustomerView];
}


- (void)showUpgradeMemberView
{
    __weak typeof(self) weakSelf = self;
    self.upgradeMemberView = [[IPCUpgradeMemberView alloc]initWithFrame:[IPCAppManager sharedManager].currentLevelViewController.view.bounds
                                                               Customer:[IPCPayOrderCurrentCustomer sharedManager].currentCustomer
                                                            UpdateBlock:^(IPCCustomerMode *customer)
                              {
                                  __strong typeof(weakSelf) strongSelf = weakSelf;
                                  [IPCPayOrderManager sharedManager].currentCustomerId = customer.customerID;
                                  [IPCPayOrderCurrentCustomer sharedManager].currentCustomer = customer;
                                  [strongSelf.customerContentView loadCustomerInfoView:customer];
                                  [strongSelf.memberContentView loadCustomerMemberInfoView:NO];
                                  [strongSelf.customerListView loadData];
                              }];
    [[IPCAppManager sharedManager].currentLevelViewController.view addSubview:self.upgradeMemberView];
    [[IPCAppManager sharedManager].currentLevelViewController.view bringSubviewToFront:self.upgradeMemberView];
}

///强制验证通过
- (void)compulsoryVerificationMember
{
    [IPCPayOrderManager sharedManager].isValiateMember = YES;
    [IPCPayOrderManager sharedManager].memberCheckType = @"COMPEL";
    [IPCPayOrderManager sharedManager].customDiscount = [[IPCShoppingCart sharedCart] customDiscount];
    [self.memberContentView loadCustomerMemberInfoView:isSelectMemberStatus];
}

- (void)reloadCustomerInfo
{
    [self.customerContentView loadCustomerInfoView:[IPCPayOrderCurrentCustomer sharedManager].currentCustomer];
    [self.memberContentView loadCustomerMemberInfoView:NO];
}

- (void)resetCustomerData
{
    [[IPCPayOrderManager sharedManager] clearPayRecord];
    [[IPCPayOrderManager sharedManager] resetCustomerDiscount];
    [[IPCPayOrderManager sharedManager] calculatePayAmount];
}

- (void)resetCustomerView
{
    isSelectMemberStatus = NO;
    [self.customerContentView loadCustomerInfoView:nil];
    [self.memberContentView loadCustomerMemberInfoView:NO];
    [self.customerListView changeToCustomerStatus];
    [IPCPayOrderManager sharedManager].isValiateMember = NO;
}


@end
