//
//  IPCSaleserCommonMemberView.m
//  IcePointCloudSalser
//
//  Created by gerry on 2018/3/13.
//  Copyright © 2018年 Doray. All rights reserved.
//

#import "IPCSaleserCommonMemberView.h"

@interface IPCSaleserCommonMemberContentView()

@property (weak, nonatomic)  IBOutlet UIView *compulsoryVerifityView;
@property (weak, nonatomic)  IBOutlet UILabel *unCheckMemberLabel;

@end

@implementation IPCSaleserCommonMemberContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView * view = [UIView jk_loadInstanceFromNibWithName:@"IPCSaleserCommonMemberContentView" owner:self];
        [view setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:view];
        
    }
    return self;
}
@end
