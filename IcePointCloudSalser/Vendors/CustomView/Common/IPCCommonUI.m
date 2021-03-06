//
//  IPCCommonUI.m
//  IcePointCloud
//
//  Created by mac on 8/14/14.
//  Copyright (c) 2014 Doray. All rights reserved.
//

#import "IPCCommonUI.h"
#import "MBProgressHUD.h"

@implementation IPCCommonUI

#pragma mark //Warning prompt box
+ (void)show
{
    [IPCCommonUI hiden];
    
    __block NSMutableArray<UIImage *> * loadingArray = [[NSMutableArray alloc]init];
    
    for (NSInteger i = 1 ; i< 17; i++) {
        [loadingArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading_%ld",(long)i]]];
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    
    UIImageView *imaegCustomView = [[UIImageView alloc] init];
    imaegCustomView.animationImages = loadingArray;
    [imaegCustomView setAnimationRepeatCount:0];
    [imaegCustomView setAnimationDuration:loadingArray.count * 0.1];
    [imaegCustomView startAnimating];
    hud.customView = imaegCustomView;
    hud.square = NO;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor clearColor];
    hud.backgroundView.color = [UIColor clearColor];
    hud.removeFromSuperViewOnHide = YES;
}

+ (void)showInfo:(NSString *)message
{
    [IPCCommonUI hiden];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.label.font = [UIFont systemFontOfSize:13 weight:UIFontWeightThin];
    hud.removeFromSuperViewOnHide = YES;
}

+ (void)showSuccess:(NSString *)message
{
    [IPCCommonUI hiden];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.text = message;
    hud.label.font = [UIFont systemFontOfSize:13 weight:UIFontWeightThin];
    
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"hud_complete"];
    hud.customView = imageView;
    [hud hideAnimated:YES afterDelay:1.f];
    hud.removeFromSuperViewOnHide = YES;
}

+ (void)showError:(NSString *)message
{
    [IPCCommonUI hiden];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.text = message;
    hud.label.font = [UIFont systemFontOfSize:13 weight:UIFontWeightThin];
    
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"icon_back"];
    hud.customView = imageView;
    [hud hideAnimated:YES afterDelay:1.f];
    hud.removeFromSuperViewOnHide = YES;
}

+ (void)hiden{
    [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].delegate window] animated:YES];
}

+ (void)showAlert:(NSString *)alertTitle Message:(NSString *)alertMesg
{
    [[UIApplication sharedApplication].keyWindow.rootViewController showAlertWithTitle:alertTitle Message:alertMesg Process:^(IPCAlertController *alertController) {
        alertController.addCancelTitle(@"返回");
    } ActionBlock:nil];
}

+ (void)showAlert:(NSString *)title Message:(NSString *)message Owner:(id)owner Done:(void(^)())done
{
    if (owner && [owner isKindOfClass:[UIViewController class]]) {
        [owner showAlertWithTitle:title Message:message Process:^(IPCAlertController *alertController) {
            alertController.addCancelTitle(@"返回");
            alertController.addDestructiveTitle(@"确定");
        } ActionBlock:^(NSInteger buttonIndex, UIAlertAction *action, IPCAlertController *alertSelf) {
            if (buttonIndex == 1) {
                if (done) {
                    done();
                }
            }
        }];
    }
}

#pragma mark //Remove automatically associate attribute of the input box
+ (void)clearAutoCorrection:(UIView *)view
{
    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITextField class]]) {
            UITextField * subTextField = (UITextField *)obj;
            [subTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
            [subTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        }
    }];
}

+ (UIView *)nearestAncestorForView:(UIView *)aView withClass:(Class)aClass
{
    UIView *parent = aView;
    while (parent) {
        if ([parent isKindOfClass:aClass]) return parent;
        parent = parent.superview;
    }
    return nil;
}


@end
