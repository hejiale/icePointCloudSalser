//
//  Glass.m
//  IcePointCloud
//
//  Created by mac on 7/19/14.
//  Copyright (c) 2014 Doray. All rights reserved.
//

#import "IPCGlasses.h"


@implementation IPCGlasses


/**
 *  Glasses type
 *
 */
- (IPCTopFilterType)filterType
{
    if (!self.glassesID && !self.glassesID.length)return IPCTopFIlterTypeNone;
    
    NSRange range = [self.glassesID rangeOfString:@"-"];
    NSString * typeName = [self.glassesID substringToIndex:range.location];
    
    if ([typeName isEqualToString:@"FRAMES"]) {
        return IPCTopFIlterTypeFrames;
    }else if ([typeName isEqualToString:@"SUNGLASSES"]){
        return IPCTopFilterTypeSunGlasses;
    }else if ([typeName isEqualToString:@"CUSTOMIZED"]){
        return IPCTopFilterTypeCustomized;
    }else if ([typeName isEqualToString:@"READING_GLASSES"]){
        return IPCTopFilterTypeReadingGlass;
    }else if ([typeName isEqualToString:@"LENS"]){
        return IPCTopFilterTypeLens;
    }else if ([typeName isEqualToString:@"CONTACT_LENSES"]){
        return IPCTopFilterTypeContactLenses;
    }else if ([typeName isEqualToString:@"ACCESSORY"]){
        return IPCTopFilterTypeAccessory;
    }
    return IPCTopFilterTypeOthers;
}

- (NSString *)glassType
{
    NSRange range = [self.glassesID rangeOfString:@"-"];
    return [self.glassesID substringToIndex:range.location];
}


- (NSString *)glassId
{
    return [self.glassesID substringFromIndex:[self.glassesID rangeOfString:@"-"].location + 1];
}


+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"glassName"           : @"name",
             @"glassesID"                  : @"id",
             @"price"                        : @"suggestPrice",
             @"productCount"        : @"count",
             @"isBatch"               : @"batch",
             };
}




@end
