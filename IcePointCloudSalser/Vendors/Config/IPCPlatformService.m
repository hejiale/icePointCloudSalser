//
//  IPCPlatformService.m
//  IcePointCloud
//
//  Created by mac on 2016/12/30.
//  Copyright © 2016年 Doray. All rights reserved.
//

#import "IPCPlatformService.h"
#import "IPCCheckVersion.h"

@implementation IPCPlatformService

+ (IPCPlatformService *)instance
{
    static IPCPlatformService * service = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        service = [[self alloc] init];
    });
    return service;
}

- (void)setUp
{
    [self checkNetwork];
    [self checkVersion];
    [self enableKeyboard];
    [self setUpBugtags];
}

/**
 *  Check Version
 */
- (void)checkVersion{
    [[IPCCheckVersion shardManger] checkVersion];
}

/**
 *  Add the keyboard to track
 */
- (void)enableKeyboard{
    [IQKeyboardManager sharedManager].shouldShowTextFieldPlaceholder = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)setUpBugtags
{
    [Bugtags startWithAppKey:IPCBugtagsKey invocationEvent:BTGInvocationEventNone];
    [Bugtags setTrackingNetwork:YES];
    [Bugtags sync:YES];
    
}

/**
 *  Check Network
 */
- (void)checkNetwork
{
    [[IPCReachability manager] monitoringNetwork:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown || status == AFNetworkReachabilityStatusNotReachable) {
            [IPCCommonUI showError:kIPCErrorNetworkAlertMessage];
        }
    }];
}


@end
