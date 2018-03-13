//
//  IPCPayOrderManager.m
//  IcePointCloud
//
//  Created by mac on 2016/11/30.
//  Copyright © 2016年 Doray. All rights reserved.
//

#import "IPCPayOrderManager.h"

@implementation IPCPayOrderManager

+ (IPCPayOrderManager *)sharedManager
{
    static dispatch_once_t token;
    static IPCPayOrderManager *_client;
    dispatch_once(&token, ^{
        _client = [[self alloc] init];
    });
    return _client;
}

- (NSMutableArray<IPCPayOrderPayType *> *)payTypeArray
{
    if (!_payTypeArray) {
        _payTypeArray = [[NSMutableArray alloc]init];
    }
    return _payTypeArray;
}


-(NSMutableArray<IPCPayRecord *> *)payTypeRecordArray{
    if (!_payTypeRecordArray) {
        _payTypeRecordArray = [[NSMutableArray alloc] init];
    }
    return _payTypeRecordArray;
}

- (void)setSelectProtyOrder:(IPCCustomerOrderMode *)selectProtyOrder
{
    _selectProtyOrder = selectProtyOrder;
}

- (double)payRecordTotalPrice
{
    __block double totalPrice = 0;
    [[IPCPayOrderManager sharedManager].payTypeRecordArray enumerateObjectsUsingBlock:^(IPCPayRecord * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.payOrderType.payType isEqualToString:@"积分"]) {
            totalPrice += obj.pointPrice;
        }else{
            totalPrice += obj.payPrice;
        }
    }];
    return totalPrice;
}

- (double)remainPayPrice{
    NSString * payStr = [NSString stringWithFormat:@"%f", [IPCPayOrderManager sharedManager].payAmount];
    NSString * totalStr  = [NSString stringWithFormat:@"%f", [[IPCPayOrderManager sharedManager] payRecordTotalPrice]];
    
    if ([IPCCommon afterDouble:payStr : totalStr] <= 0) {
        return 0;
    }
    return [IPCPayOrderManager sharedManager].payAmount - [[IPCPayOrderManager sharedManager] payRecordTotalPrice];
}

- (double)calculateDiscount
{
    if ([IPCPayOrderManager sharedManager].payAmount <= 0)return 100;
    
    double discount = [IPCPayOrderManager sharedManager].payAmount/[[IPCShoppingCart sharedCart] allGlassesTotalPrePrice];
    NSString * discountStr = [NSString stringWithFormat:@"%@",[IPCCommon formatNumber:discount Location:5]];
    return [discountStr doubleValue] * 100;
}

- (void)calculatePayAmount
{
    if ([IPCPayOrderManager sharedManager].customDiscount > -1) {
        [IPCPayOrderManager sharedManager].payAmount = [[IPCShoppingCart sharedCart] allGlassesTotalPrePrice] * (double)([IPCPayOrderManager sharedManager].customDiscount/100);
        [IPCPayOrderManager sharedManager].discountAmount = [[IPCShoppingCart sharedCart] allGlassesTotalPrePrice] - [IPCPayOrderManager sharedManager].payAmount;
        [[IPCShoppingCart sharedCart] updateAllCartUnitPrice];
    }else{
        [IPCPayOrderManager sharedManager].discountAmount = [[IPCShoppingCart sharedCart] allGlassesTotalPrePrice] - [[IPCShoppingCart sharedCart] allGlassesTotalPrice];
        [IPCPayOrderManager sharedManager].discount = [[IPCPayOrderManager sharedManager] calculateDiscount];
    }
}

- (BOOL)isCanPayOrder:(BOOL)isCash
{
    if (![IPCPayOrderManager sharedManager].currentCustomerId) {
        [IPCCommonUI showError:@"请选择客户!"];
        return NO;
    }else if ([[IPCShoppingCart sharedCart] allGlassesCount] == 0){
        [IPCCommonUI showError:@"购物列表为空!"];
        return NO;
    }else if ([[IPCPayOrderManager sharedManager] payTypeRecordArray].count == 0 && isCash){
        [IPCCommonUI showError:@"收银记录为空!"];
        return NO;
    }else if ([IPCPayOrderManager sharedManager].isInsertRecord && isCash){
        [IPCCommonUI showError:@"请完成确认添加付款记录!"];
        return NO;
    }else if (![IPCPayOrderManager sharedManager].employee){
        [IPCCommonUI showError:@"请选择经办人!"];
        return NO;
    }
    return YES;
}

- (void)clearPayRecord
{
    [[IPCPayOrderManager sharedManager].payTypeRecordArray removeAllObjects];
    [IPCPayOrderManager sharedManager].customDiscount = -1;
}

- (void)queryPayType
{
    [[IPCPayOrderManager sharedManager].payTypeArray removeAllObjects];
    
    [IPCPayOrderRequestManager queryPayListTypeWithSuccessBlock:^(id responseValue)
    {
        if ([responseValue isKindOfClass:[NSArray class]]) {
            [responseValue enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                IPCPayOrderPayType * payType = [IPCPayOrderPayType mj_objectWithKeyValues:obj];
                [[IPCPayOrderManager sharedManager].payTypeArray addObject:payType];
            }];
        }
    } FailureBlock:^(NSError *error) {
        
    }];
}

- (void)resetEmployee
{
    [IPCPayOrderManager sharedManager].employee = [[IPCEmployee alloc]init];
    [IPCPayOrderManager sharedManager].employee = [IPCAppManager sharedManager].storeResult.employee;
}

- (void)resetCustomerDiscount
{
    if ([IPCPayOrderCurrentCustomer sharedManager].currentCustomer.discount) {
        if (([IPCAppManager sharedManager].companyCofig.isCheckMember && [IPCPayOrderCurrentCustomer sharedManager].currentCustomer.memberLevel) || [IPCPayOrderManager sharedManager].isValiateMember)
        {
            [IPCPayOrderManager sharedManager].isValiateMember = YES;
            [IPCPayOrderManager sharedManager].customDiscount = [IPCPayOrderCurrentCustomer sharedManager].currentCustomer.discount * 10;
        }else{
            [IPCPayOrderManager sharedManager].customDiscount = 100;
            [IPCPayOrderManager sharedManager].isValiateMember = NO;
        }
    }else{
        [IPCPayOrderManager sharedManager].customDiscount = 100;
        [IPCPayOrderManager sharedManager].isValiateMember = NO;
    }
}


- (BOOL)extraDiscount
{
    double payDiscount = 0;
    BOOL   isExtraDiscount = NO;
    
    if ([IPCPayOrderManager sharedManager].customDiscount > -1) {
        payDiscount = (double)[IPCPayOrderManager sharedManager].customDiscount/100;
    }else{
        payDiscount = (double)[IPCPayOrderManager sharedManager].discount/100;
    }
    double employeeDiscount = (double)[IPCPayOrderManager sharedManager].employee.discount/100;
    double customerDiscount = (double)[[IPCShoppingCart sharedCart] customDiscount]/100;
    
    if (payDiscount < MIN(employeeDiscount > 0 ? employeeDiscount : 1, customerDiscount > 0 ? customerDiscount : 1) && [IPCAppManager sharedManager].companyCofig.autoAuditedSalesOrder)
    {
        isExtraDiscount = YES;
    }
    return isExtraDiscount;
}

- (NSString *)customerId
{
    if ([IPCPayOrderManager sharedManager].currentCustomerId) {
        return [IPCPayOrderCurrentCustomer sharedManager].currentCustomer.customerID;
    }else if ([IPCPayOrderManager sharedManager].currentMemberCustomerId){
        return [IPCPayOrderCurrentCustomer sharedManager].currentMemberCustomer.customerID;
    }
    return nil;
}

- (IPCCustomerMode *)currentCustomer
{
    IPCCustomerMode * customer = nil;
    
    if ([IPCPayOrderManager sharedManager].currentCustomerId) {
        customer = [IPCPayOrderCurrentCustomer sharedManager].currentCustomer;
    }else if ([IPCPayOrderManager sharedManager].currentMemberCustomerId){
        customer = [IPCPayOrderCurrentCustomer sharedManager].currentMemberCustomer;
    }
    return customer;
}

- (IPCCustomerMode *)currentMemberCard
{
    IPCCustomerMode * customer = nil;
    
    if ([IPCPayOrderManager sharedManager].currentCustomerId) {
        customer = [IPCPayOrderCurrentCustomer sharedManager].currentCustomer;
    }else if ([IPCPayOrderManager sharedManager].currentMemberCustomerId){
        customer = [IPCPayOrderCurrentCustomer sharedManager].currentMember;
    }
    return customer;
}

- (void)resetData
{
    [IPCPayOrderManager sharedManager].remark = nil;
    [[IPCPayOrderManager sharedManager] clearPayRecord];
    [IPCPayOrderManager sharedManager].currentCustomerId = nil;
//    [IPCPayOrderManager sharedManager].currentOptometryId = nil;
    [IPCPayOrderManager sharedManager].payAmount = 0;
    [IPCPayOrderManager sharedManager].discount = 0;
    [IPCPayOrderManager sharedManager].discountAmount = 0;
    [[IPCPayOrderManager sharedManager] resetEmployee];
    [IPCPayOrderManager sharedManager].isInsertRecord = NO;
    [IPCPayOrderManager sharedManager].selectProtyOrder = nil;
    [IPCPayOrderManager sharedManager].selectedOrder = nil;
    [[IPCPayOrderCurrentCustomer sharedManager] clearData];
    [[IPCShoppingCart sharedCart] clear];
}

- (void)getProtyOrder:(IPCCustomerOrderDetail *)orderInfo
{
    [[IPCPayOrderManager sharedManager] resetData];
    self.selectedOrder = orderInfo;
    
    ///重新加入购物车
    [orderInfo.products enumerateObjectsUsingBlock:^(IPCSaleserProduct * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.batchAdd ) {
            if (obj.prodType == IPCTopFilterTypeLens) {
                [[IPCShoppingCart sharedCart] addLensWithGlasses:obj Sph:obj.sph Cyl:obj.cyl Count:obj.productCount];
            }else if (obj.prodType == IPCTopFilterTypeContactLenses){
                [[IPCShoppingCart sharedCart] addContactLensWithGlasses:obj Sph:obj.sph Cyl:obj.cyl Count:obj.productCount];
            } else{
                [[IPCShoppingCart sharedCart] addReadingLensWithGlasses:obj ReadingDegree:obj.batchDegree Count:obj.productCount];
            }
        }else{
            [[IPCShoppingCart sharedCart] plusGlass:obj];
        }
    }];
    
    [IPCPayOrderManager sharedManager].currentCustomerId = orderInfo.orderInfo.customerId;
//    [IPCPayOrderManager sharedManager].currentOptometryId = orderInfo.orderInfo.optometryId;
    [IPCPayOrderManager sharedManager].employee = orderInfo.employee;
}

@end
