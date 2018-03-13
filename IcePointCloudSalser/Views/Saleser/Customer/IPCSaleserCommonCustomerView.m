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
#import "IPCSaleserCustomInfoView.h"
#import "IPCSaleserUpdateCustomerView.h"
#import "IPCSaleserCustomerListView.h"
#import "IPCSaleserInsertCustomerView.h"
#import "IPCUpgradeMemberView.h"
#import "IPCSaleserMemberInfoView.h"
#import "IPCSaleserUpdateCustomerView.h"
#import "IPCSaleserMemberNoneCustomerView.h"
#import "IPCSaleserMemberAlertView.h"
#import "IPCSaleserCustomerAlertView.h"
#import "IPCSaleserMemberChooseCustomerView.h"
#import "IPCSaleserMemberCustomerListView.h"
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
@property (nonatomic, strong) IPCSaleserCustomInfoView * infoView;
@property (nonatomic, strong) IPCSaleserInsertCustomerView * editCustomerView;
@property (nonatomic, strong) IPCUpgradeMemberView *  upgradeMemberView;
@property (nonatomic, strong) IPCSaleserMemberInfoView * memberInfoView;
@property (nonatomic, strong) IPCSaleserCustomerAlertView*customerAlertView;
@property (nonatomic, strong) IPCSaleserMemberAlertView *memberAlertView;
@property (nonatomic, strong) IPCUpgradeMemberView* customerUpgradeMemberView;
@property (nonatomic, strong) IPCSaleserMemberNoneCustomerView * memberNoneCustomerView;
@property (nonatomic, strong) IPCSaleserUpdateCustomerView * updateCustomerView;
@property (nonatomic, strong) IPCSaleserCustomerListView * customerListView;
@property (nonatomic, strong) IPCSaleserMemberChooseCustomerView* chooseCustomerView;
@property (nonatomic, strong) IPCSaleserMemberCustomerListView * memberCustomerListView;

@property (nonatomic, strong) IPCCustomerListViewModel    * viewModel;

@end

@implementation IPCSaleserCommonCustomerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView * view = [UIView jk_loadInstanceFromNibWithName:@"IPCSaleserCommonCustomerView" owner:self];
        [view setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:view];
        
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
    [self loadCustomerInfoView:nil];
    [self.rightContentView addSubview:self.customerListView];
}

#pragma mark //Set UI
- (IPCSaleserCustomInfoView *)infoView
{
    if (!_infoView) {
        _infoView = [[IPCSaleserCustomInfoView alloc]initWithFrame:self.customInfoContentView.bounds];
    }
    return _infoView;
}

- (IPCSaleserMemberInfoView *)memberInfoView{
    if (!_memberInfoView) {
        _memberInfoView = [[IPCSaleserMemberInfoView alloc]initWithFrame:self.memberCardContentView.bounds];
    }
    return _memberInfoView;
}

- (IPCSaleserCustomerAlertView *)customerAlertView{
    if (!_customerAlertView) {
        _customerAlertView = [[IPCSaleserCustomerAlertView alloc]initWithFrame:self.customInfoContentView.bounds];
    }
    return _customerAlertView;
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

- (IPCSaleserMemberAlertView *)memberAlertView{
    if (!_memberAlertView) {
        _memberAlertView = [[IPCSaleserMemberAlertView alloc]initWithFrame:self.memberCardContentView.bounds];
    }
    return _memberAlertView;
}

- (IPCSaleserMemberNoneCustomerView *)memberNoneCustomerView{
    if (!_memberNoneCustomerView) {
        __weak typeof(self) weakSelf = self;
        _memberNoneCustomerView = [[IPCSaleserMemberNoneCustomerView alloc]initWithFrame:self.customInfoContentView.bounds];
        [[_memberNoneCustomerView rac_signalForSelector:@selector(bindCustomerAction:)] subscribeNext:^(RACTuple * _Nullable x) {
            [weakSelf loadMemberChooseCustomerView];
        }];
        [[_memberNoneCustomerView rac_signalForSelector:@selector(createCustomerAction:)] subscribeNext:^(RACTuple * _Nullable x) {
            [weakSelf showEditCustomerView:YES];
        }];
        [[_memberNoneCustomerView rac_signalForSelector:@selector(createWithVistorAction:)] subscribeNext:^(RACTuple * _Nullable x) {
            [weakSelf queryVisitorCustomer];
        }];
    }
    return _memberNoneCustomerView;
}

- (IPCSaleserCustomerListView *)customerListView{
    if (!_customerListView) {
        __weak typeof(self) weakSelf = self;
        _customerListView = [[IPCSaleserCustomerListView alloc]initWithFrame:self.rightContentView.bounds
                                                               IsChooseStatus:NO
                                                                       Detail:^(IPCCustomerMode* customer, BOOL isMemberReload)
                             {
                                 if (isMemberReload) {
                                     [weakSelf loadCustomerMemberInfoView:YES];
                                     [weakSelf queryMemberBindCustomer];
                                 }else{
                                     [weakSelf reloadCustomerInfo];
                                 }
                             } SelectType:^(BOOL isSelectMemeber) {
                                 isSelectMemberStatus = isSelectMemeber;
                                 if (![IPCPayOrderManager sharedManager].customerId && ![IPCPayOrderManager sharedManager].currentMemberCustomerId) {
                                     [weakSelf loadCustomerInfoView:nil];
                                     [weakSelf loadCustomerMemberInfoView:NO];
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
                                   [IPCPayOrderCurrentCustomer sharedManager].currentMemberCustomer = customer;
                                   [weakSelf loadCustomerInfoView:customer];
                               }];
    }
    return _chooseCustomerView;
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

#pragma mark //Load UI
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
        if (![IPCPayOrderManager sharedManager].currentCustomerId && ![IPCPayOrderManager sharedManager].currentMemberCustomerId) {
            [self.customerAlertView updateUI:isSelectMemberStatus];
        }
    }
    [self resetCustomerData];
    
    if (!customer.isVisitor) {
        [self.viewModel queryCustomerOptometry];
    }
}

- (void)loadCustomerMemberInfoView:(BOOL)isChoose
{
    [self clearMemberInfoView];
    
    if ([IPCPayOrderManager sharedManager].currentCustomerId || [IPCPayOrderManager sharedManager].currentMemberCustomerId)
    {
        if (isChoose) {
            [self.memberInfoView updateMemberCardInfo:[IPCPayOrderCurrentCustomer sharedManager].currentMember];
            [self.memberCardContentView addSubview:self.memberInfoView];
        }else{
            if ([IPCPayOrderCurrentCustomer sharedManager].currentCustomer.memberLevel) {
                [self.memberInfoView updateMemberCardInfo:[IPCPayOrderCurrentCustomer sharedManager].currentCustomer];
                [self.memberCardContentView addSubview:self.memberInfoView];
            }else{
                [self.memberCardContentView addSubview:self.customerUpgradeMemberView];
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
        if (![IPCPayOrderManager sharedManager].currentCustomerId && ![IPCPayOrderManager sharedManager].currentMemberCustomerId) {
            [self.memberAlertView updateUI:isSelectMemberStatus];
        }
    }
}

- (void)loadMemberChooseCustomerView
{
    if (self.chooseCustomerView) {
        [self.chooseCustomerView removeFromSuperview];
        self.chooseCustomerView = nil;
    }
    [[UIApplication sharedApplication].keyWindow addSubview:self.chooseCustomerView];
}

- (void)loadMemberCustomerListView:(NSArray<IPCCustomerMode *> *)customerList
{
    [self clearCustomerInfoView];
    [self.editButton setHidden:YES];
    
    if (customerList.count) {
        if (customerList.count > 1) {
            [self clearCustomerInfoView];
            [self.memberCustomerListView reloadCustomerListView:customerList];
            [self.customInfoContentView addSubview:self.memberCustomerListView];
        }else{
            IPCCustomerMode * customer = customerList[0];
            [IPCPayOrderCurrentCustomer sharedManager].currentMemberCustomer = customer;
            [self loadCustomerInfoView:customer];
        }
    }else{
        [self.customInfoContentView addSubview:self.memberNoneCustomerView];
    }
}

#pragma mark //Clear All Views
- (void)clearCustomerInfoView
{
    [self.infoView removeFromSuperview];self.infoView = nil;
    [self.customerAlertView removeFromSuperview];self.customerAlertView = nil;
    [self.memberNoneCustomerView removeFromSuperview];self.memberNoneCustomerView = nil;
    [self.memberCustomerListView removeFromSuperview];self.memberCustomerListView = nil;
}

- (void)clearMemberInfoView
{
    [self.memberInfoView removeFromSuperview];self.memberInfoView = nil;
    [self.memberAlertView removeFromSuperview];self.memberAlertView = nil;
    [self.customerUpgradeMemberView removeFromSuperview];self.customerUpgradeMemberView = nil;
    [self.unCheckMemberLabel setHidden:YES];
    [self.compulsoryVerifityView setHidden:YES];
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
             
             [weakSelf loadCustomerMemberInfoView:YES];
             [weakSelf queryMemberBindCustomer];
         }
     }];
}

- (void)queryMemberBindCustomer
{
    __weak typeof(self) weakSelf = self;
    [self.viewModel queryBindMemberCustomer:^(NSArray *customerList, NSError *error) {
        [weakSelf loadMemberCustomerListView:customerList];
    }];
}

- (void)queryVisitorCustomer
{
    __weak typeof(self) weakSelf = self;
    [self.viewModel queryVisitorCustomer:^ {
        [weakSelf clearCustomerInfoView];
        [weakSelf loadCustomerInfoView:[IPCPayOrderCurrentCustomer sharedManager].currentMemberCustomer];
    }];
}

- (void)bindMember:(IPCCustomerMode *)customer
{
    __weak typeof(self) weakSelf = self;
    [IPCCustomerRequestManager bindMemberWithCustomerId:customer.customerID
                                       MemberCustomerId:[IPCPayOrderManager sharedManager].currentMemberCustomerId
                                           SuccessBlock:^(id responseValue)
     {
         [IPCPayOrderCurrentCustomer sharedManager].currentMemberCustomer = [IPCCustomerMode mj_objectWithKeyValues:responseValue];
         [weakSelf clearCustomerInfoView];
         [weakSelf loadCustomerInfoView:[IPCPayOrderCurrentCustomer sharedManager].currentMemberCustomer];
     } FailureBlock:^(NSError *error) {
         [IPCCommonUI showError:error.domain];
     }];
}

#pragma mark //Clicked Events
- (IBAction)validationMemberAction:(id)sender
{
    __weak typeof(self) weakSelf = self;
    IPCScanCodeViewController *scanVc = [[IPCScanCodeViewController alloc] initWithFinish:^(NSString *result, NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
//        [strongSelf.cameraNav dismissViewControllerAnimated:YES completion:nil];
//        [weakSelf validationMemberRequest:result];
    }];
//    self.cameraNav = [[IPCPortraitNavigationViewController alloc]initWithRootViewController:scanVc];
//    [self presentViewController:self.cameraNav  animated:YES completion:nil];
}

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
                                     [weakSelf loadCustomerInfoView:customer];
                                     [weakSelf loadCustomerMemberInfoView:NO];
                                     [strongSelf.customerListView loadData];
                                 }
                             }];
    [[IPCAppManager sharedManager].currentLevelViewController.view addSubview:self.editCustomerView];
    [[IPCAppManager sharedManager].currentLevelViewController.view bringSubviewToFront:self.editCustomerView];
}

- (IBAction)updateCustomerAction:(id)sender
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
                                   [weakSelf loadCustomerInfoView:customer];
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
                                  [weakSelf loadCustomerInfoView:customer];
                                  [weakSelf loadCustomerMemberInfoView:NO];
                                  [strongSelf.customerListView loadData];
                              }];
    [[IPCAppManager sharedManager].currentLevelViewController.view addSubview:self.upgradeMemberView];
    [[IPCAppManager sharedManager].currentLevelViewController.view bringSubviewToFront:self.upgradeMemberView];
}

///强制验证通过
- (IBAction)compulsoryVerificationAction:(id)sender {
    [IPCPayOrderManager sharedManager].isValiateMember = YES;
    [IPCPayOrderManager sharedManager].memberCheckType = @"COMPEL";
    [IPCPayOrderManager sharedManager].customDiscount = [[IPCShoppingCart sharedCart] customDiscount];
    [self loadCustomerMemberInfoView:isSelectMemberStatus];
}

- (void)reloadCustomerInfo
{
    [self loadCustomerInfoView:[IPCPayOrderCurrentCustomer sharedManager].currentCustomer];
    [self loadCustomerMemberInfoView:NO];
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
    [self loadCustomerInfoView:nil];
    [self loadCustomerMemberInfoView:NO];
    [self.customerListView changeToCustomerStatus];
    [self.editButton setHidden:YES];
    [IPCPayOrderManager sharedManager].isValiateMember = NO;
}


@end
