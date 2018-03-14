//
//  IPCPayOrderCustomerCollectionViewCell.h
//  IcePointCloud
//
//  Created by gerry on 2017/11/20.
//  Copyright © 2017年 Doray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IPCSaleserCustomerCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *customerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *customerLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *customerPhoneLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameWidth;

@property (copy, nonatomic) IPCCustomerMode * currentCustomer;

@end
