//
//  IPCSaleserMemberNoneCustomerView.m
//  IcePointCloudSalser
//
//  Created by gerry on 2018/3/12.
//  Copyright © 2018年 Doray. All rights reserved.
//

#import "IPCSaleserMemberNoneCustomerView.h"

@interface IPCSaleserMemberNoneCustomerView()

@property (weak, nonatomic) IBOutlet UIButton *createCustomerButton;
@property (weak, nonatomic) IBOutlet UIButton *createTouristsButton;
@property (weak, nonatomic) IBOutlet UIButton *bindCustomerButton;


@end

@implementation IPCSaleserMemberNoneCustomerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView * view = [UIView jk_loadInstanceFromNibWithName:@"IPCSaleserMemberNoneCustomerView" owner:self];
        [view setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:view];
        
        [self.createCustomerButton addBorder:18 Width:1 Color:COLOR_RGB_BLUE];
        [self.createTouristsButton addBorder:18 Width:1 Color:COLOR_RGB_BLUE];
        [self.bindCustomerButton addBorder:18 Width:1 Color:COLOR_RGB_BLUE];
    }
    return self;
}

#pragma mark //Clicked Events
- (IBAction)createCustomerAction:(id)sender {
}

- (IBAction)createWithVistorAction:(id)sender {
}

- (IBAction)bindCustomerAction:(id)sender {
}


@end
