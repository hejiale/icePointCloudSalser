//
//  IPCPayOrderEditCustomerView.h
//  IcePointCloud
//
//  Created by gerry on 2017/11/20.
//  Copyright © 2017年 Doray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IPCSaleserInsertCustomerView : UIView

- (instancetype)initWithFrame:(CGRect)frame UpdateBlock:(void (^)(IPCCustomerMode * customer))update;

@end
