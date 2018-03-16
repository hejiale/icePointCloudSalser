//
//  IPCSaleserMemberCustomerListCell.m
//  IcePointCloudSalser
//
//  Created by gerry on 2018/3/13.
//  Copyright © 2018年 Doray. All rights reserved.
//

#import "IPCSaleserMemberCustomerListCell.h"

@implementation IPCSaleserMemberCustomerListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCustomerMode:(IPCCustomerMode *)customerMode{
    _customerMode = customerMode;
    
    if (_customerMode) {
        [self.customerNameLabel setText:_customerMode.customerName];
        [self.sexLabel setText:[IPCCommon formatGender:_customerMode.gender]];
        [self.phoneLabel setText:_customerMode.customerPhone];
    }
}

@end
