//
//  CustomerOrderListObject.m
//  IcePointCloud
//
//  Created by mac on 16/7/21.
//  Copyright © 2016年 Doray. All rights reserved.
//

#import "IPCCustomerOrderList.h"

@implementation IPCCustomerOrderList

- (instancetype)initWithResponseValue:(id)responseValue{
    self = [super init];
    if (self)
    {
        [self.list removeAllObjects];
        
        if ([responseValue isKindOfClass:[NSDictionary class]]) {
            if ([responseValue[@"resultList"] isKindOfClass:[NSArray class]]) {
                [responseValue[@"resultList"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    IPCCustomerOrderMode * order = [IPCCustomerOrderMode mj_objectWithKeyValues:obj];
                    [self.list addObject:order];
                }];
            }
            self.totalCount = [responseValue[@"rowCount"]integerValue];
        }
    }
    return self;
}

- (NSMutableArray<IPCCustomerOrderMode *> *)list{
    if (!_list) {
        _list = [[NSMutableArray alloc]init];
    }
    return _list;
}

@end

@implementation IPCCustomerOrderMode

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"orderCode"  :  @"orderNumber",
             @"orderDate"        :  @"orderTime",
             @"orderPrice"       :   @"totalPrice"};
}

@end
