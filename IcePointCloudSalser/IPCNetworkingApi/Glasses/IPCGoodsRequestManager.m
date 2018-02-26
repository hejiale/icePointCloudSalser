//
//  IPCGoodsRequestManager.m
//  IcePointCloud
//
//  Created by mac on 2016/12/30.
//  Copyright © 2016年 Doray. All rights reserved.
//

#import "IPCGoodsRequestManager.h"

@implementation IPCGoodsRequestManager

+  (void)queryPriceStrategyWithSuccessBlock:(void (^)(id))success
                                 FailureBlock:(void (^)(NSError *))failure
{
    [self postRequest:nil RequestMethod:GoodsRequest_PriceStrategy CacheEnable:IPCRequestCacheEnable SuccessBlock:success FailureBlock:failure];
}

@end
