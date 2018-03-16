//
//  IPCSaleserCustomerListView.m
//  IcePointCloudSalser
//
//  Created by gerry on 2018/3/12.
//  Copyright © 2018年 Doray. All rights reserved.
//

#import "IPCSaleserCustomerListView.h"
#import "IPCCustomerListViewModel.h"
#import "IPCSaleserCustomerCollectionViewCell.h"
#import "IPCSaleserMemberCollectionViewCell.h"

static NSString * const searchCustomerPlaceHolder = @"请输入客户搜索关键词";
static NSString * const searchMemberPlaceHolder = @"请输入会员搜索密保手机号";
static NSString * const customerIdentifier = @"IPCPayOrderCustomerCollectionViewCellIdentifier";
static NSString * const memberIdentifier = @"IPCPayOrderMemberCollectionViewCellIdentifier";

@interface IPCSaleserCustomerListView()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>
{
    BOOL  chooseStatus;
    BOOL  isSelectMember;
    NSString * currentSelectCustomer;//绑定会员时选择客户的临时参数
}
@property (strong, nonatomic)  UICollectionView *customerCollectionView;
@property (strong, nonatomic)  UIView *searchTypeView;
@property (strong, nonatomic)  UITextField *searchTextField;
@property (strong, nonatomic)  UIButton *insertButton;
@property (strong, nonatomic)  UIView * textFieldRightView;
@property (nonatomic, strong) IPCRefreshAnimationHeader   *refreshHeader;
@property (nonatomic, strong) IPCRefreshAnimationFooter    *refreshFooter;
@property (nonatomic, strong) IPCCustomerListViewModel    * viewModel;
@property (nonatomic, strong) IPCDynamicImageTextButton * typeButton;
@property (nonatomic, copy) void(^DetailBlock)(IPCCustomerMode* customer, BOOL isMemberReload);
@property (nonatomic, copy) void(^IsSelectMemberBlock)(BOOL isMember);

@end

@implementation IPCSaleserCustomerListView

- (instancetype)initWithIsChooseStatus:(BOOL)isChoose Detail:(void(^)(IPCCustomerMode * customer, BOOL isMemberReload))detail SelectType:(void(^)(BOOL isSelectMemeber))isMember
{
    self = [super init];
    if (self) {
        chooseStatus = isChoose;
        self.DetailBlock = detail;
        self.IsSelectMemberBlock = isMember;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setBackgroundColor:[UIColor clearColor]];
    [self loadUI];
    
//    if (!chooseStatus) {
//        [self reloadCollectionViewUI];
//        [self.rightButtonView addSubview:self.typeButton];
//    }else{
//        self.rightButtonViewWidth.constant = 0;
//    }
    self.viewModel = [[IPCCustomerListViewModel alloc]init];
}

#pragma mark //Set UI
- (void)loadUI
{
    UIView * searchContentView = [[UIView alloc]init];
    [searchContentView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:searchContentView];
    [searchContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(0);
        make.top.equalTo(self.mas_top).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.mas_equalTo(50);
    }];
    
    [self loadCollectionView];
    
    [searchContentView addSubview:self.searchTextField];
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchContentView.mas_left).with.offset(5);
        make.top.equalTo(searchContentView.mas_top).with.offset(0);
        make.bottom.equalTo(searchContentView.mas_bottom).with.offset(0);
        make.right.equalTo(searchContentView.mas_right).with.offset(0);
    }];
    
    if (!chooseStatus) {
        [self.searchTextField setRightView:self.textFieldRightView];
        [self.searchTextField setRightViewMode:UITextFieldViewModeAlways];
    }
    
    [self.textFieldRightView addSubview:self.typeButton];
    [self.typeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldRightView.mas_top).with.offset(0);
        make.bottom.equalTo(self.textFieldRightView.mas_bottom).with.offset(0);
        make.left.equalTo(self.textFieldRightView.mas_left).with.offset(0);
        make.right.equalTo(self.textFieldRightView.mas_right).with.offset(0);
    }];
    
    [self addSubview:self.searchTypeView];
    [self.searchTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchContentView.mas_bottom).with.offset(0);
        make.right.equalTo(searchContentView.mas_right).with.offset(0);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(120);
    }];
    
    [self addSubview:self.insertButton];
    [self.insertButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
        make.width.mas_equalTo(220);
        make.height.mas_equalTo(50);
    }];
}


- (void)loadCollectionView
{
    if ([self.customerCollectionView superview]) {
        [self.customerCollectionView removeFromSuperview];
        self.customerCollectionView = nil;
    }
    
    CGFloat itemHeight = (self.jk_height-30-60)/7;
    [self addSubview:self.customerCollectionView];
    [self.customerCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(55);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        
        if (isSelectMember || chooseStatus) {
            make.bottom.equalTo(self.mas_bottom).with.offset(0);
        }else{
            make.bottom.equalTo(self.mas_bottom).with.offset(-(itemHeight+5));
        }
    }];
    
    [self reloadCollectionViewUI];
}

- (UICollectionView *)customerCollectionView{
    if (!_customerCollectionView) {
        CGFloat itemWidth = 0;
        CGFloat itemHeight = 0;
        
        if (chooseStatus) {
            itemWidth = (self.jk_width-5)/2;
            itemHeight = (self.jk_height-20-60)/5;
        }else{
            itemWidth = (self.jk_width-10)/3;
            itemHeight = (self.jk_height-30-60)/7;
        }
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(itemWidth, itemHeight);
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 5;
        
        _customerCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [_customerCollectionView setDataSource:self];
        [_customerCollectionView setDelegate:self];
        [_customerCollectionView setBackgroundColor:[UIColor clearColor]];

        _customerCollectionView.emptyAlertImage = @"exception_search";
        _customerCollectionView.emptyAlertTitle = @"未查询到客户信息!";
        _customerCollectionView.mj_header = self.refreshHeader;
        _customerCollectionView.mj_footer = self.refreshFooter;
        [_customerCollectionView registerNib:[UINib nibWithNibName:@"IPCSaleserCustomerCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:customerIdentifier];
        [_customerCollectionView registerNib:[UINib nibWithNibName:@"IPCSaleserMemberCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:memberIdentifier];
        [self.refreshHeader beginRefreshing];
    }
    return _customerCollectionView;
}

- (UIView *)textFieldRightView{
    if (!_textFieldRightView) {
        _textFieldRightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
    }
    return _textFieldRightView;
}


- (UITextField *)searchTextField{
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc]init];
        [_searchTextField setBackgroundColor:[UIColor clearColor]];
        [_searchTextField setPlaceholder:searchCustomerPlaceHolder];
        [_searchTextField setTextColor:[UIColor colorWithHexString:@"#666666"]];
        [_searchTextField setLeftImageView:@"icon_search"];
        [_searchTextField setFont:[UIFont systemFontOfSize:14]];
        [_searchTextField setDelegate:self];
    }
    return _searchTextField;
}

- (UIView *)searchTypeView{
    if (!_searchTypeView) {
        _searchTypeView = [[UIView alloc]init];
        [_searchTypeView setBackgroundColor:[UIColor clearColor]];
        [_searchTypeView setHidden:YES];
        
        UIImageView * bgImageView = [[UIImageView alloc]init];
        [bgImageView setImage:[UIImage imageNamed:@"icon_searchType"]];
        [bgImageView setBackgroundColor:[UIColor clearColor]];
        [_searchTypeView addSubview:bgImageView];
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_searchTypeView.mas_left).with.offset(0);
            make.right.equalTo(_searchTypeView.mas_right).with.offset(0);
            make.top.equalTo(_searchTypeView.mas_top).with.offset(0);
            make.bottom.equalTo(_searchTypeView.mas_bottom).with.offset(0);
        }];
        
        UIButton * customerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [customerButton setTitle:@"客户" forState:UIControlStateNormal];
        [customerButton setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [customerButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [customerButton addTarget:self action:@selector(searchWithCustomerAction:) forControlEvents:UIControlEventTouchUpInside];
        [_searchTypeView addSubview:customerButton];
        
        UIView * line = [[UIView alloc]init];
        [line setBackgroundColor:[UIColor colorWithHexString:@"#EDEDED"]];
        [_searchTypeView addSubview:line];
        
        UIButton * memberButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [memberButton setTitle:@"会员" forState:UIControlStateNormal];
        [memberButton setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [memberButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [memberButton addTarget:self action:@selector(searchWithMemberAction:) forControlEvents:UIControlEventTouchUpInside];
        [_searchTypeView addSubview:memberButton];
        
        [customerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_searchTypeView.mas_top).with.offset(10);
            make.left.equalTo(_searchTypeView.mas_left).with.offset(0);
            make.right.equalTo(_searchTypeView.mas_right).with.offset(0);
            make.height.mas_equalTo(50);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(customerButton.mas_bottom).with.offset(0);
            make.left.equalTo(_searchTypeView.mas_left).with.offset(8);
            make.right.equalTo(_searchTypeView.mas_right).with.offset(8);
            make.height.mas_equalTo(1);
        }];
        
        [memberButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom).with.offset(0);
            make.left.equalTo(_searchTypeView.mas_left).with.offset(0);
            make.right.equalTo(_searchTypeView.mas_right).with.offset(0);
            make.height.mas_equalTo(50);
        }];
        
    }
    return _searchTypeView;
}

- (UIButton *)insertButton{
    if (!_insertButton) {
        _insertButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_insertButton setBackgroundColor:COLOR_RGB_BLUE];
        [_insertButton setTitle:@"新增客户" forState:UIControlStateNormal];
        [_insertButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_insertButton addTarget:self action:@selector(insertCustomerAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _insertButton;
}

- (IPCRefreshAnimationHeader *)refreshHeader{
    if (!_refreshHeader){
        _refreshHeader = [IPCRefreshAnimationHeader headerWithRefreshingTarget:self refreshingAction:@selector(beginRefresh)];
    }
    return _refreshHeader;
}

- (IPCRefreshAnimationFooter *)refreshFooter{
    if (!_refreshFooter)
        _refreshFooter = [IPCRefreshAnimationFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    return _refreshFooter;
}

- (IPCDynamicImageTextButton *)typeButton{
    if (!_typeButton) {
        _typeButton = [[IPCDynamicImageTextButton alloc]initWithFrame:self.textFieldRightView.bounds];
        [_typeButton setImage:[UIImage imageNamed:@"icon_down_arrow"] forState:UIControlStateNormal];
        [_typeButton setTitleColor:COLOR_RGB_BLUE];
        [_typeButton setTitle:@"客户"];
        [_typeButton setFont:[UIFont systemFontOfSize:15 weight:UIFontWeightThin]];
        [_typeButton setButtonAlignment:IPCCustomButtonAlignmentLeft];
        [_typeButton addTarget:self action:@selector(selectSearchTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _typeButton;
}

#pragma mark //Refresh Methods
- (void)beginRefresh
{
    //Stop Footer Refresh Method
    if (self.refreshFooter.isRefreshing) {
        [self.refreshFooter endRefreshing];
    }
    [self.refreshFooter resetDataStatus];
    
    [self.viewModel resetData];
    if (isSelectMember) {
        [self loadMemberList];
    }else{
        [self loadCustomerList];
    }
}

- (void)loadMore
{
    self.viewModel.currentPage++;
    if (isSelectMember) {
        [self loadMemberList];
    }else{
        [self loadCustomerList];
    }
}

#pragma mark //Request Data
- (void)loadCustomerList
{
    __weak typeof(self) weakSelf = self;
    [self.viewModel queryCustomerListWithIsChooseStatus:chooseStatus Complete:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.viewModel.status == IPCFooterRefresh_HasNoMoreData) {
            [strongSelf.refreshFooter noticeNoDataStatus];
        }else if (strongSelf.viewModel.status == IPCRefreshError){
            if ([error code] != NSURLErrorCancelled) {
                [IPCCommonUI showError:@"查询客户失败,请稍后重试!"];
            }
        }
        [weakSelf reload];
    }];
}

- (void)loadMemberList
{
    __weak typeof(self) weakSelf = self;
    [self.viewModel queryMemberList:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.viewModel.status == IPCFooterRefresh_HasNoMoreData) {
            [strongSelf.refreshFooter noticeNoDataStatus];
        }else if (strongSelf.viewModel.status == IPCRefreshError){
            if ([error code] != NSURLErrorCancelled) {
                [IPCCommonUI showError:@"查询会员失败,请稍后重试!"];
            }
        }
        [weakSelf reload];
    }];
}

#pragma mark //Reload CollectionView
- (void)refreshData
{
    [self.refreshHeader beginRefreshing];
}

- (void)reload
{
    self.customerCollectionView.isBeginLoad = NO;
    [self.customerCollectionView reloadData];
    [self stopRefresh];
}

- (void)stopRefresh
{
    if (self.refreshHeader.isRefreshing) {
        [self.refreshHeader endRefreshing];
    }
    if (self.refreshFooter.isRefreshing) {
        [self.refreshFooter endRefreshing];
    }
}

#pragma mark //Clicked Events
- (void)searchWithCustomerAction:(id)sender
{
    [self.searchTypeView setHidden:YES];
    
    if (self.IsSelectMemberBlock) {
        self.IsSelectMemberBlock(NO);
    }
    [self changeToCustomerStatus];
}


- (void)searchWithMemberAction:(id)sender
{
    [self.searchTypeView setHidden:YES];
    
    if (self.IsSelectMemberBlock) {
        self.IsSelectMemberBlock(YES);
    }
    [self changeToMemberStatus];
}


- (void)insertCustomerAction:(id)sender {
    
}

- (void)reloadCollectionViewUI
{
    if (isSelectMember || chooseStatus) {
        [self.insertButton setHidden:YES];
    }else{
        [self.insertButton setHidden:NO];
    }
}

- (void)selectSearchTypeAction:(id)sender{
    if (self.searchTypeView.isHidden) {
        [self.searchTypeView setHidden:NO];
    }else{
        [self.searchTypeView setHidden:YES];
    }
}

- (void)changeToCustomerStatus
{
    isSelectMember = NO;
    [self.typeButton setTitle:@"客户"];
    [self.searchTextField setPlaceholder:searchCustomerPlaceHolder];
    [self loadCollectionView];
}

- (void)changeToMemberStatus
{
    isSelectMember = YES;
    [self.typeButton setTitle:@"会员"];
    [self.searchTextField setPlaceholder:searchMemberPlaceHolder];
    [self loadCollectionView];
}

#pragma mark //UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.viewModel.customerArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (isSelectMember) {
        IPCSaleserMemberCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:memberIdentifier forIndexPath:indexPath];

        if (self.viewModel && self.viewModel.customerArray.count) {
            IPCCustomerMode * customer = self.viewModel.customerArray[indexPath.row];
            cell.currentCustomer = customer;
        }
        return cell;
    }else{
        IPCSaleserCustomerCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:customerIdentifier forIndexPath:indexPath];
        
        if (self.viewModel && self.viewModel.customerArray.count) {
            IPCCustomerMode * customer = self.viewModel.customerArray[indexPath.row];
            if (chooseStatus) {
                cell.selectCustomerId = currentSelectCustomer;
            }else{
                cell.selectCustomerId = [IPCPayOrderManager sharedManager].currentCustomerId;
            }
            cell.currentCustomer = customer;
        }
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    //Prereload Data
    if (self.viewModel.status == IPCFooterRefresh_HasMoreData) {
        if (!self.refreshFooter.isRefreshing) {
            if (indexPath.row == self.viewModel.customerArray.count -10) {
                [self.refreshFooter beginRefreshing];
            }
        }
    }
}

#pragma mark //UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.viewModel.customerArray.count) {
        IPCCustomerMode * customer = self.viewModel.customerArray[indexPath.row];
        [IPCPayOrderManager sharedManager].isValiateMember = NO;
        [IPCPayOrderManager sharedManager].memberCheckType = @"NULL";
        [IPCPayOrderCurrentCustomer sharedManager].currentOpometry = nil;
        
        if (isSelectMember) {
            if ([customer.memberCustomerId isEqualToString:[IPCPayOrderManager sharedManager].currentMemberCustomerId])return;
            
            if (customer) {
                [IPCPayOrderManager sharedManager].currentCustomerId = nil;
                [IPCPayOrderCurrentCustomer sharedManager].currentCustomer = nil;
                [IPCPayOrderCurrentCustomer sharedManager].currentMemberCustomer = nil;
                
                [IPCPayOrderCurrentCustomer sharedManager].currentMember = customer;
                [IPCPayOrderManager sharedManager].currentMemberCustomerId = customer.memberCustomerId;
                [IPCPayOrderManager sharedManager].customDiscount = [[IPCShoppingCart sharedCart] customDiscount];
            }
        }else{
            if (!chooseStatus) {
                if ([customer.customerID isEqualToString:[IPCPayOrderManager sharedManager].currentCustomerId])return;
            }
            
            if (customer) {
                if (!chooseStatus) {
                    [IPCPayOrderCurrentCustomer sharedManager].currentMember = nil;
                    [IPCPayOrderCurrentCustomer sharedManager].currentMemberCustomer = nil;
                    [IPCPayOrderManager sharedManager].currentMemberCustomerId = nil;
                    
                    [IPCPayOrderManager sharedManager].currentCustomerId = customer.customerID;
                    [IPCPayOrderCurrentCustomer sharedManager].currentCustomer = customer;
                    [IPCPayOrderManager sharedManager].customDiscount = [[IPCShoppingCart sharedCart] customDiscount];
                }else{
                    currentSelectCustomer = customer.customerID;
                }
            }
        }
        
        if (self.DetailBlock) {
            self.DetailBlock(customer, isSelectMember);
        }
        [collectionView reloadData];
    }
}


#pragma mark //UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.viewModel.searchWord = [textField.text jk_trimmingWhitespace];
    [self.refreshHeader beginRefreshing];
}


@end
