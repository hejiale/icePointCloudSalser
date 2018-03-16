//
//  IPCSaleserMemberCustomerListCell.h
//  IcePointCloudSalser
//
//  Created by gerry on 2018/3/13.
//  Copyright © 2018年 Doray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IPCSaleserMemberCustomerListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *customerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (copy, nonatomic) IPCCustomerMode * customerMode;

@end
