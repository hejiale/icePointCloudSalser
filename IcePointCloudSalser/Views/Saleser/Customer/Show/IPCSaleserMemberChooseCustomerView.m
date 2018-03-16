//
//  IPCSaleserMemberChooseCustomerView.m
//  IcePointCloudSalser
//
//  Created by gerry on 2018/3/13.
//  Copyright © 2018年 Doray. All rights reserved.
//

#import "IPCSaleserMemberChooseCustomerView.h"
#import "IPCSaleserCustomerListView.h"
#import "IPCSaleserCustomInfoView.h"

@interface IPCSaleserMemberChooseCustomerView()

@property (weak, nonatomic) IBOutlet UIView *leftContentView;
@property (weak, nonatomic) IBOutlet UIView *rightContentView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (strong, nonatomic) IPCSaleserCustomerListView * customListView;
@property (strong, nonatomic) IPCSaleserCustomInfoView * customerInfoView;
@property (strong, nonatomic) IPCCustomerMode * customer;
@property (copy, nonatomic) void(^BindSuccessBlock)(IPCCustomerMode *customer);

@end

@implementation IPCSaleserMemberChooseCustomerView

- (instancetype)initWithFrame:(CGRect)frame BindSuccess:(void(^)(IPCCustomerMode *customer))success
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView * view = [UIView jk_loadInstanceFromNibWithName:@"IPCSaleserMemberChooseCustomerView" owner:self];
        [self addSubview:view];
        
        self.BindSuccessBlock = success;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.rightContentView addSubview:self.customListView];
    [self.customListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rightContentView.mas_top).with.offset(0);
        make.bottom.equalTo(self.rightContentView.mas_bottom).with.offset(0);
        make.left.equalTo(self.rightContentView.mas_left).with.offset(0);
        make.right.equalTo(self.rightContentView.mas_right).with.offset(0);
    }];
    
    [self.cancelButton addBorder:3 Width:1 Color:COLOR_RGB_BLUE];
    [self.sureButton addBorder:3 Width:0 Color:nil];
}

#pragma mark //Set UI
- (IPCSaleserCustomerListView *)customListView{
    if (!_customListView) {
        __weak typeof(self) weakSelf = self;
        _customListView = [[IPCSaleserCustomerListView alloc]initWithIsChooseStatus:YES
                                                                     Detail:^(IPCCustomerMode *customer, BOOL isMemberReload)
                           {
                               __strong typeof(weakSelf) strongSelf = weakSelf;
                               strongSelf.customer = customer;
                               [weakSelf loadCustomerInfoView:customer];
                           } SelectType:nil];
    }
    return _customListView;
}

- (IPCSaleserCustomInfoView *)customerInfoView{
    if (!_customerInfoView) {
        _customerInfoView = [[IPCSaleserCustomInfoView alloc]initWithFrame:self.leftContentView.bounds];
    }
    return _customerInfoView;
}

#pragma mark //Request Data
- (void)bindMember
{
    __weak typeof(self) weakSelf = self;
    [IPCCustomerRequestManager bindMemberWithCustomerId:self.customer.customerID
                                       MemberCustomerId:[IPCPayOrderManager sharedManager].currentMemberCustomerId
                                           SuccessBlock:^(id responseValue)
     {
         if (self.BindSuccessBlock) {
             self.BindSuccessBlock(self.customer);
         }
         [self removeFromSuperview];
     } FailureBlock:^(NSError *error) {
         [IPCCommonUI showError:error.domain];
     }];
}

#pragma mark //Clicked Events
- (IBAction)cancelAction:(id)sender {
    [self removeFromSuperview];
}


- (IBAction)saveAction:(id)sender {
    [self bindMember];
}

- (void)loadCustomerInfoView:(IPCCustomerMode *)customer
{
    if (self.customerInfoView) {
        [self.customerInfoView removeFromSuperview];
        self.customerInfoView = nil;
    }
    [self.customerInfoView updateCustomerInfo:customer];
    [self.leftContentView addSubview:self.customerInfoView];
}

@end
