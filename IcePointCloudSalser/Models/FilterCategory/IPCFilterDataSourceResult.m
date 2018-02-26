//
//  FilterDataSourceResult.m
//  IcePointCloud
//
//  Created by mac on 16/6/30.
//  Copyright © 2016年 Doray. All rights reserved.
//

#import "IPCFilterDataSourceResult.h"

@implementation IPCFilterDataSourceResult

- (NSArray<NSString *> *)allCategoryName{
    return @[@"全部", @"镜架",@"太阳眼镜",@"定制类眼镜",@"老花眼镜",@"镜片",@"隐形眼镜",@"配件",@"护理液",@"其它"];
}


- (NSString *)payStatusCategoryName:(NSInteger)index
{
    switch (index) {
        case 0:
            return @"FRAMES";
            break;
        case 1:
            return @"SUNGLASSES";
            break;
        case 2:
            return @"CUSTOMIZED";
            break;
        case 3:
            return @"BATCH_READING_GLASSES";
            break;
        case 4:
            return @"BATCH_LENS";
            break;
        case 5:
            return @"BATCH_CONTACT_LENSES";
            break;
        case 6:
            return @"ACCESSORY";
            break;
        case 7:
            return @"SOLUTION";
            break;
        case 8:
            return @"OTHERS";
            break;
        default:
            break;
    }
    return @"";
}


@end
