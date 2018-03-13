//
//  IPCSaleserMemberChooseCustomerView.h
//  IcePointCloudSalser
//
//  Created by gerry on 2018/3/13.
//  Copyright © 2018年 Doray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IPCSaleserMemberChooseCustomerView : UIView

- (instancetype)initWithFrame:(CGRect)frame BindSuccess:(void(^)(IPCCustomerMode *customer))success;

@end
