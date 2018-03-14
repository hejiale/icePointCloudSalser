//
//  IPCSaleserCustomerListView.h
//  IcePointCloudSalser
//
//  Created by gerry on 2018/3/12.
//  Copyright © 2018年 Doray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IPCSaleserCustomerListView : UIView

- (instancetype)initWithIsChooseStatus:(BOOL)isChoose
                                Detail:(void(^)(IPCCustomerMode * customer, BOOL isMemberReload))detail
                            SelectType:(void(^)(BOOL isSelectMemeber))isMember;

- (void)reload;

- (void)loadData;

- (void)changeToCustomerStatus;

- (void)changeToMemberStatus;

@end
