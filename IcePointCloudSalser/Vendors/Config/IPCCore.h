//
//  IPCCommon.h
//  IcePointCloud
//
//  Created by mac on 2016/11/29.
//  Copyright © 2016年 Doray. All rights reserved.
//

#ifndef IPCCore_h
#define IPCCore_h



/**
 *  GLASS CLASS
 */
typedef NS_ENUM(NSInteger, IPCTopFilterType) {
    /**
     *  NONE
     */
    IPCTopFIlterTypeNone = -1,
    /**
     *  FRAME
     */
    IPCTopFIlterTypeFrames = 0,
    /**
     *  SUN GLASS
     */
    IPCTopFilterTypeSunGlasses,
    /**
     *  CUSTOM
     */
    IPCTopFilterTypeCustomized,
    /**
     *  READING GLASS
     */
    IPCTopFilterTypeReadingGlass,
    /**
     *  LENS
     */
    IPCTopFilterTypeLens,
    /**
     *  CONTACT LENS
     */
    IPCTopFilterTypeContactLenses,
    /**
     *  ACCESSORY
     */
    IPCTopFilterTypeAccessory,
    /**
     *  OTHERS
     */
    IPCTopFilterTypeOthers,
};


typedef enum : NSUInteger {
    /**
     *  More Data
     */
    IPCFooterRefresh_HasMoreData,
    /**
     *  No More Data
     */
    IPCFooterRefresh_HasNoMoreData,
    /**
     *  None Data
     */
    IPCFooterRefresh_NoData,
    /**
     *  Error
     */
    IPCRefreshError
    
} LSRefreshDataStatus;

typedef NS_ENUM(NSInteger, IPCEditKeyboardType) {
    /**
     *  Cart
     */
    IPCEditKeyboardTypeCart,
    /**
     *  Pay
     */
    IPCEditKeyboardTypePay
};


//Frame
#define SCREEN_WIDTH                  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT                 [UIScreen mainScreen].bounds.size.height
//Color
#define COLOR_RGB_BLUE              [UIColor jk_colorWithHexString:@"#63a0d4"]
#define COLOR_RGB_RED                [UIColor jk_colorWithHexString:@"#FF0000"]
//Bugtags_Key
#define IPCBugtagsKey                   @"684c431f1975ccb3731c51cd2dff6536"

#ifdef DEBUG
#define DLog(fmt, ...)                     NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#define DeBugLog(fmt, ...)             NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define MyNSLog(FORMAT, ...)      fprintf(stderr,"[%s]:[line %d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define DLog(...)
#define DeBugLog(...)
#define MyNSLog(FORMAT, ...)
#endif


#endif /* IPCCore_h */
