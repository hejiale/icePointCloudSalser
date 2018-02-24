//
//  IPCShowOptometryInfoView.h
//  IcePointCloud
//
//  Created by gerry on 2017/11/27.
//  Copyright © 2017年 Doray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IPCSaleserOptometryInfoView : UIView

- (instancetype)initWithFrame:(CGRect)frame ChooseBlock:(void(^)())choose;

- (void)updateOptometryInfo;

@end
