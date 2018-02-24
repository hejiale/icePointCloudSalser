//
//  IPCSaleserUpdateCustomerView.m
//  IcePointCloud
//
//  Created by gerry on 2018/1/18.
//  Copyright © 2018年 Doray. All rights reserved.
//

#import "IPCSaleserUpdateCustomerView.h"

@interface IPCSaleserUpdateCustomerView()

@property (weak, nonatomic) IBOutlet UITextField *customerNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextFiel;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTextField;
@property (weak, nonatomic) IBOutlet UIButton *maleButton;
@property (weak, nonatomic) IBOutlet UIButton *femaleButton;
@property (weak, nonatomic) IBOutlet UITextField *customerTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *encryptedPhoneTextField;
@property (weak, nonatomic) IBOutlet UIView *editContentView;
@property (weak, nonatomic) IBOutlet UIView *membePhoneView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
@property (strong, nonatomic) IPCDetailCustomer * detailCustomer;
@property (copy, nonatomic) void(^UpdateBlock)(NSString *);

@end

@implementation IPCSaleserUpdateCustomerView

- (instancetype)initWithFrame:(CGRect)frame UpdateBlock:(void (^)(NSString *customerId))update
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.UpdateBlock = update;
        
        UIView * view = [UIView jk_loadInstanceFromNibWithName:@"IPCSaleserUpdateCustomerView" owner:self];
        [view setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:view];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.editContentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITextField class]]) {
            UITextField * textFiedld = (UITextField *)obj;
            [textFiedld addBottomLine];
        }
    }];
    [self.encryptedPhoneTextField addBottomLine];
    
    [self.birthdayTextField setRightButton:self Action:@selector(showDatePickerAction) OnView:self.editContentView];
    [self.customerTypeTextField setRightButton:self Action:@selector(selectCustomTypeAction) OnView:self.editContentView];
    
    [[IPCCustomerManager sharedManager] queryCustomerType];
    [self.customerTypeTextField setText: @"自然进店"];
}


- (void)updateCustomerInfo
{
    self.detailCustomer = [IPCPayOrderCurrentCustomer sharedManager].currentCustomer;
    
    [self.customerNameTextField setText:self.detailCustomer.customerName];
    [self.phoneTextFiel setText:self.detailCustomer.customerPhone];
    [self.ageTextField setText:self.detailCustomer.age];
    [self.birthdayTextField setText:self.detailCustomer.birthday];
    [self.customerTypeTextField setText:self.detailCustomer.customerType];
    [self.encryptedPhoneTextField setText:self.detailCustomer.memberPhone];
    
    if ([self.detailCustomer.gender isEqualToString:@"MALE"]) {
        [self.maleButton setSelected:YES];
        [self.femaleButton setSelected:NO];
    }else if ([self.detailCustomer.gender isEqualToString:@"FEMALE"]){
        [self.femaleButton setSelected:YES];
        [self.maleButton setSelected:NO];
    }
    
    if (!self.detailCustomer.memberLevel) {
        [self.membePhoneView setHidden:YES];
        self.contentHeight.constant = 500;
    }else{
        [self.membePhoneView setHidden:NO];
        self.contentHeight.constant = 550;
    }
}

#pragma mark //Request Methods
- (void)saveCustomerRequest
{
    if (self.customerNameTextField.text.length)
    {
        NSString * gender = nil;
        
        if (self.maleButton.selected) {
            gender = @"MALE";
        }else{
            gender = @"FEMALE";
        }
        
        __weak typeof(self) weakSelf = self;
        [IPCCustomerRequestManager saveCustomerInfoWithCustomName:self.customerNameTextField.text
                                                      CustomPhone:self.phoneTextFiel.text
                                                           Gender:gender
                                                         Birthday:self.birthdayTextField.text
                                                   CustomerTypeId:[[IPCCustomerManager sharedManager]  customerTypeId:self.customerTypeTextField.text]
                                                          PhotoId:@""
                                                              Age:self.ageTextField.text
                                                       CustomerId:self.detailCustomer.customerID
                                                     SuccessBlock:^(id responseValue)
         {
             __strong typeof(weakSelf) strongSelf = weakSelf;
             [weakSelf removeFromSuperview];
             
             if (strongSelf.UpdateBlock) {
                 strongSelf.UpdateBlock(responseValue[@"id"]);
             }
             [IPCCommonUI showSuccess:@"保存客户信息成功!"];
         } FailureBlock:^(NSError *error) {
             if ([error code] != NSURLErrorCancelled) {
                 [IPCCommonUI showError:@"保存客户信息失败!"];
             }
             __strong typeof(weakSelf) strongSelf = weakSelf;
             [weakSelf removeFromSuperview];
             
             if (strongSelf.UpdateBlock) {
                 strongSelf.UpdateBlock(nil);
             }
         }];
    }
}

- (void)updateMemberPhoneRequest
{
    if (![self.encryptedPhoneTextField.text isEqualToString:self.detailCustomer.memberPhone]) {
        [IPCCustomerRequestManager updateMemberPhoneWithPhone:self.encryptedPhoneTextField.text
                                                   CustomerId:self.detailCustomer.customerID
                                                 SuccessBlock:nil
                                                 FailureBlock:^(NSError *error) {
                                                     if ([error code] != NSURLErrorCancelled) {
                                                         [IPCCommonUI showError:@"修改密保手机号失败!"];
                                                     }
                                                 }];
    }
}

#pragma mark //Clicked Events
- (IBAction)cancelAction:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)completeAction:(id)sender {
    [self saveCustomerRequest];
    if (self.detailCustomer.memberLevel) {
        [self updateMemberPhoneRequest];
    }
}

- (IBAction)selectMaleAction:(id)sender {
    [self.maleButton setSelected:YES];
    [self.femaleButton setSelected:NO];
}

- (IBAction)selectFemaleAction:(id)sender {
    [self.maleButton setSelected:NO];
    [self.femaleButton setSelected:YES];
}


- (void)showDatePickerAction
{
    IPCDatePickViewController * datePickVC = [[IPCDatePickViewController alloc]initWithNibName:@"IPCDatePickViewController" bundle:nil];
    datePickVC.delegate = self;
    [datePickVC showWithPosition:CGPointMake(self.birthdayTextField.jk_width/2, self.birthdayTextField.jk_height) Size:CGSizeMake(self.birthdayTextField.jk_width-100, 150) Owner:self.birthdayTextField];
}

- (void)selectCustomTypeAction
{
    IPCParameterTableViewController * parameterTableVC = [[IPCParameterTableViewController alloc]initWithNibName:@"IPCParameterTableViewController" bundle:nil];
    [parameterTableVC setDataSource:self];
    [parameterTableVC setDelegate:self];
    [parameterTableVC showWithPosition:CGPointMake(self.customerTypeTextField.jk_width/2, self.customerTypeTextField.jk_height) Size:CGSizeMake(200, 150) Owner:self.customerTypeTextField Direction:UIPopoverArrowDirectionUp];
}

#pragma mark //UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if([textField isEqual:self.ageTextField]){
        NSString * birthday = [NSDate jk_stringWithDate:[[NSDate date] jk_dateBySubtractingYears:[textField.text integerValue]] format:@"yyyy-01-01"];
        [self.birthdayTextField setText:birthday];
    }
}

#pragma mark //IPCDatePickViewControllerDelegate
- (void)completeChooseDate:(NSString *)date
{
    NSString *  age = [NSString stringWithFormat:@"%d",[[NSDate jk_dateWithString:date format:@"yyyy-MM-dd"] jk_distanceYearsToDate:[NSDate date]]];
    
    [self.birthdayTextField setText:date];
    [self.ageTextField setText:age];
}

#pragma mark //IPCParameterTableViewDataSource
- (nonnull NSArray *)parameterDataInTableView:(IPCParameterTableViewController *)tableView
{
    return [IPCCustomerManager sharedManager].customerTypeNameArray;
}

#pragma mark //IPCParameterTableViewDelegate
- (void)didSelectParameter:(NSString *)parameter InTableView:(IPCParameterTableViewController *)tableView
{
    [self.customerTypeTextField setText:parameter];
}

@end
