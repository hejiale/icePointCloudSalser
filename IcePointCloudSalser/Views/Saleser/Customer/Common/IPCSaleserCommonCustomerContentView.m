//
//  IPCSaleserCommonCustomerView.m
//  IcePointCloudSalser
//
//  Created by gerry on 2018/3/13.
//  Copyright © 2018年 Doray. All rights reserved.
//

#import "IPCSaleserCommonCustomerView.h"

@interface IPCSaleserCommonCustomerContentView()

@property (weak, nonatomic)  IBOutlet UIButton *editButton;

@end

@implementation IPCSaleserCommonCustomerContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView * view = [UIView jk_loadInstanceFromNibWithName:@"IPCSaleserCommonCustomerContentView" owner:self];
        [view setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:view];
        
    }
    return self;
}

@end
