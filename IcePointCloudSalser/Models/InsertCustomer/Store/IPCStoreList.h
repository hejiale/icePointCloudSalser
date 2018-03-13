//
//  IPCStoreList.h
//  IcePointCloudSalser
//
//  Created by gerry on 2018/3/13.
//  Copyright © 2018年 Doray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPCStore.h"

@interface IPCStoreList : NSObject

@property (nonatomic, strong, readwrite) NSMutableArray<IPCStore *> * storeArray;

- (instancetype)initWithResponseObject:(id)responseObject;

@end
