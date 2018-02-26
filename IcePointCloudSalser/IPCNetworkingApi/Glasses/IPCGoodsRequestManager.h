//
//  IPCGoodsRequestManager.h
//  IcePointCloud
//
//  Created by mac on 2016/12/30.
//  Copyright © 2016年 Doray. All rights reserved.
//

#import "IPCRequest.h"

@interface IPCGoodsRequestManager : IPCRequest

/**
 Query Product List Strategy
 
 @param success
 @param failure
 */
+ (void)queryPriceStrategyWithSuccessBlock:(void (^)(id responseValue))success
                              FailureBlock:(void (^)(NSError * error))failure;


@end
