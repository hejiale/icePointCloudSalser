//
//  IPCSaleserMemberCustomerListView.h
//  IcePointCloudSalser
//
//  Created by gerry on 2018/3/13.
//  Copyright © 2018年 Doray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IPCSaleserMemberCustomerListView : UIView

- (instancetype)initWithFrame:(CGRect)frame Select:(void(^)(IPCCustomerMode *customer))select;

- (void)reloadCustomerListView:(NSArray<IPCCustomerMode *> *)customerList;

@end
