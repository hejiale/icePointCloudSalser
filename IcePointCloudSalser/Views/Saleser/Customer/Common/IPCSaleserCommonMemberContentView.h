//
//  IPCSaleserCommonMemberView.h
//  IcePointCloudSalser
//
//  Created by gerry on 2018/3/13.
//  Copyright © 2018年 Doray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IPCSaleserCommonCustomerDataSource.h"
#import "IPCSaleserCommonCustomerDelegate.h"

@interface IPCSaleserCommonMemberContentView : UIView

@property (assign, nonatomic) id<IPCSaleserCommonCustomerDataSource>dataSource;
@property (assign, nonatomic) id<IPCSaleserCommonCustomerDelegate>delegate;

- (void)loadCustomerMemberInfoView:(BOOL)isChoose;

@end
