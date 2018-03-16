//
//  IPCSaleserCommonCustomerDelegate.h
//  IcePointCloudSalser
//
//  Created by gerry on 2018/3/16.
//  Copyright © 2018年 Doray. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IPCSaleserCommonCustomerDelegate <NSObject>

#pragma mark //CustomerContentView
- (void)loadMemberChooseCustomerView;

- (void)showEditCustomerView;

- (void)queryVisitorCustomer;

- (void)queryCustomerOptometry;

- (void)updateCustomerInfo;

#pragma mark //MemberContentView
- (void)validationMember:(NSString *)scanCode;

- (void)upgradeMember;

@end
