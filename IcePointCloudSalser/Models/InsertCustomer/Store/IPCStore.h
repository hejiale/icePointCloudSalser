//
//  IPCStore.h
//  IcePointCloudSalser
//
//  Created by gerry on 2018/3/13.
//  Copyright © 2018年 Doray. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IPCStore : NSObject

@property (nonatomic, copy) NSString *  storeId;
@property (nonatomic, copy) NSString *  storeName;
@property (nonatomic, copy) NSString *  storePhone;
@property (nonatomic, copy) NSString *  storeRole;
@property (nonatomic, copy) NSString *  storeStatus;
@property (nonatomic, copy) NSString *  storeAddress;
@property (nonatomic, copy) NSString *  repositoryName;
@property (nonatomic, copy) NSString *  repositoryId;

@end
