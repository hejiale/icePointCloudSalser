//
//  Glass.h
//  IcePointCloud
//
//  Created by mac on 7/19/14.
//  Copyright (c) 2014 Doray. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IPCGlasses : NSObject

@property (nonatomic, copy, readonly) NSString * glassName;//name
@property (nonatomic, copy, readonly) NSString * glassesID;// id
@property (nonatomic, assign, readonly) double    price;//Recommended retail price
@property (nonatomic, assign, readonly) BOOL      isBatch;//Whether the batch

- (IPCTopFilterType)filterType;
- (NSString *)glassType;
- (NSString *)glassId;

@end
