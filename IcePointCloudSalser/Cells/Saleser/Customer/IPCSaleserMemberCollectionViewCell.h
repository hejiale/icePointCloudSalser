//
//  IPCSaleserMemberCollectionViewCell.h
//  IcePointCloudSalser
//
//  Created by gerry on 2018/3/13.
//  Copyright © 2018年 Doray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IPCSaleserMemberCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *encryptedPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *memberLevelLabel;
@property (copy, nonatomic) IPCCustomerMode * currentCustomer;

@end
