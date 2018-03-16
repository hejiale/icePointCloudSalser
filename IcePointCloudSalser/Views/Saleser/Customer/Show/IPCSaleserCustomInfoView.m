//
//  IPCPayOrderCustomInfoView.m
//  IcePointCloud
//
//  Created by gerry on 2017/11/20.
//  Copyright © 2017年 Doray. All rights reserved.
//

#import "IPCSaleserCustomInfoView.h"

@interface IPCSaleserCustomInfoView()

@property (strong, nonatomic)  UILabel *customerNameLabel;
@property (strong, nonatomic)  UILabel *sexLabel;
@property (strong, nonatomic)  UILabel *ageLabel;
@property (strong, nonatomic)  UILabel *phoneLabel;
@property (strong, nonatomic)  UILabel *birthdayLabel;
@property (strong, nonatomic)  UILabel *totalPayLabel;
@property (strong, nonatomic)  UILabel *customerTypeLabel;

@end

@implementation IPCSaleserCustomInfoView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self loadUI];
}

#pragma mark //Set UI
- (UILabel *)customerNameLabel{
    if (!_customerNameLabel) {
        _customerNameLabel = [[UILabel alloc]init];
        [_customerNameLabel setFont:[UIFont systemFontOfSize:35 weight:UIFontWeightMedium]];
        [_customerNameLabel setTextColor:COLOR_RGB_BLUE];
        [_customerNameLabel setBackgroundColor:[UIColor clearColor]];
    }
    return _customerNameLabel;
}

- (UILabel *)sexLabel{
    if (!_sexLabel) {
        _sexLabel = [[UILabel alloc]init];
        [_sexLabel setFont:[UIFont systemFontOfSize:15]];
        [_sexLabel setBackgroundColor:[UIColor clearColor]];
        [_sexLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _sexLabel;
}

- (UILabel *)ageLabel{
    if (!_ageLabel) {
        _ageLabel = [[UILabel alloc]init];
        [_ageLabel setFont:[UIFont systemFontOfSize:15]];
        [_ageLabel setBackgroundColor:[UIColor clearColor]];
        [_ageLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _ageLabel;
}

- (UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        [_phoneLabel setFont:[UIFont systemFontOfSize:15]];
        [_phoneLabel setBackgroundColor:[UIColor clearColor]];
        [_phoneLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _phoneLabel;
}


- (UILabel *)customerTypeLabel{
    if (!_customerTypeLabel) {
        _customerTypeLabel = [[UILabel alloc]init];
        [_customerTypeLabel setFont:[UIFont systemFontOfSize:15]];
        [_customerTypeLabel setBackgroundColor:[UIColor clearColor]];
        [_customerTypeLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _customerTypeLabel;
}

- (UILabel *)birthdayLabel{
    if (!_birthdayLabel) {
        _birthdayLabel = [[UILabel alloc]init];
        [_birthdayLabel setFont:[UIFont systemFontOfSize:15]];
        [_birthdayLabel setBackgroundColor:[UIColor clearColor]];
        [_birthdayLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _birthdayLabel;
}

- (UILabel *)totalPayLabel{
    if (!_totalPayLabel) {
        _totalPayLabel = [[UILabel alloc]init];
        [_totalPayLabel setFont:[UIFont systemFontOfSize:15]];
        [_totalPayLabel setBackgroundColor:[UIColor clearColor]];
        [_totalPayLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _totalPayLabel;
}

- (void)loadUI
{
    [self addSubview:self.customerNameLabel];
    [self addSubview:self.sexLabel];
    [self addSubview:self.ageLabel];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.customerTypeLabel];
    [self addSubview:self.birthdayLabel];
    [self addSubview:self.totalPayLabel];
    
    UIView * line1 = [[UIView alloc]init];
    [line1 setBackgroundColor:[UIColor colorWithHexString:@"#999999"]];
    [self addSubview:line1];
    
    UIView * line2 = [[UIView alloc]init];
    [line2 setBackgroundColor:[UIColor colorWithHexString:@"#999999"]];
    [self addSubview:line2];
    
    [self.customerNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(20);
        make.top.equalTo(self.mas_top).with.offset(30);
        make.height.mas_equalTo(40);
    }];
    
    [self.sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.customerNameLabel.mas_right).with.offset(5);
        make.bottom.equalTo(self.customerNameLabel.mas_bottom).with.offset(0);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(21);
    }];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sexLabel.mas_right).with.offset(0);
        make.centerY.equalTo(self.sexLabel.mas_centerY).with.offset(0);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(12);
    }];
    
    [self.ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line1.mas_right).with.offset(0);
        make.bottom.equalTo(self.sexLabel.mas_bottom).with.offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(21);
    }];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ageLabel.mas_right).with.offset(0);
        make.centerY.equalTo(self.ageLabel.mas_centerY).with.offset(0);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(12);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line2.mas_right).with.offset(0);
        make.bottom.equalTo(self.ageLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(21);
    }];
    
    [self.customerTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneLabel.mas_bottom).with.offset(40);
        make.right.equalTo(self.mas_right).with.offset(-20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    [self.birthdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.customerTypeLabel.mas_bottom).with.offset(30);
        make.right.equalTo(self.mas_right).with.offset(-20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    [self.totalPayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.birthdayLabel.mas_bottom).with.offset(30);
        make.right.equalTo(self.mas_right).with.offset(-20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    UILabel * customerTypeTitleLabel = [[UILabel alloc]init];
    [customerTypeTitleLabel setText:@"客户类型"];
    [customerTypeTitleLabel setTextColor:[UIColor colorWithHexString:@"#999999"]];
    [customerTypeTitleLabel setFont:[UIFont systemFontOfSize:15]];
    [self addSubview:customerTypeTitleLabel];
    
    UILabel * birthdayTitleLabel = [[UILabel alloc]init];
    [birthdayTitleLabel setText:@"出生日期"];
    [birthdayTitleLabel setTextColor:[UIColor colorWithHexString:@"#999999"]];
    [birthdayTitleLabel setFont:[UIFont systemFontOfSize:15]];
    [self addSubview:birthdayTitleLabel];
    
    UILabel * totalPayTitleLabel = [[UILabel alloc]init];
    [totalPayTitleLabel setText:@"累计消费"];
    [totalPayTitleLabel setTextColor:[UIColor colorWithHexString:@"#999999"]];
    [totalPayTitleLabel setFont:[UIFont systemFontOfSize:15]];
    [self addSubview:totalPayTitleLabel];
    
    [customerTypeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.customerNameLabel.mas_bottom).with.offset(40);
        make.left.equalTo(self.mas_left).with.offset(20);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(20);
    }];
    
    [birthdayTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(customerTypeTitleLabel.mas_bottom).with.offset(30);
        make.left.equalTo(self.mas_left).with.offset(20);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(20);
    }];
    
    [totalPayTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(birthdayTitleLabel.mas_bottom).with.offset(30);
        make.left.equalTo(self.mas_left).with.offset(20);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(20);
    }];
}



- (void)updateCustomerInfo:(IPCCustomerMode *)customer
{
    if (customer) {
        [self.customerNameLabel setText:customer.customerName];
        [self.ageLabel setText:customer.age ? [NSString stringWithFormat:@"%@岁",customer.age] : @"0岁"];
        [self.phoneLabel setText:customer.customerPhone];
        [self.sexLabel setText:[IPCCommon formatGender:customer.gender]];
        [self.birthdayLabel setText:customer.birthday];
        [self.totalPayLabel setText:[NSString stringWithFormat:@"￥%.2f", customer.consumptionAmount]];
        [self.customerTypeLabel setText:customer.customerType];
        
        CGFloat width = [customer.customerName jk_sizeWithFont:self.customerNameLabel.font constrainedToHeight:self.customerNameLabel.jk_height].width;
        [self.customerNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(MIN(160, MAX(width, 70)));
        }];
        
        width = [customer.customerPhone jk_sizeWithFont:self.phoneLabel.font constrainedToHeight:self.phoneLabel.jk_height].width;
        [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width+10);
        }];
    }
}

@end
