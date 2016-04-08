//
//  MovieRefundMoneyViewController.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/19.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieRefundMoneyViewController.h"
#import "MovieRefundMainTypeCell.h"
#import "MovieChooseRefundTypeCell.h"
#import "MoviceTextFiledCell.h"
#import "ReturnAppayViewController.h"

@interface MovieRefundMoneyViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)UITableView *mainTableView;

/** 是否展开退款类型 */
@property (nonatomic,assign) BOOL isRefundType;

/** 是否展开退款原因 */
@property (nonatomic,assign) BOOL isRefundReason;

@property (nonatomic,retain) NSArray *typeArray;
@property (nonatomic,retain) NSArray *reasonArray;

/** 退款类型 */
@property (nonatomic,assign) NSInteger refundType;

/** 退款原因 */
@property (nonatomic,assign) NSInteger refundReasone;


@property (nonatomic,retain) UITextField *txtAccount;
@property (nonatomic,retain) UITextField *txtMoney;


@end

@implementation MovieRefundMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavTabBar:@"申请退款"];
    [self initViewDatas];
    [self createApplyRefundView];
}

- (void)initViewDatas
{
    _isRefundType = NO;  //默认退款原因和退款类型不展开
    _isRefundReason = NO;
    
    _refundType = 1; //默认支付宝
    _refundReasone = 1; //默认与卖家协商一致
    
    self.typeArray = @[@"支付宝",@"微信",@"钱包",@"其他"];
    self.reasonArray = @[@"与卖家协商一致",@"买家原因",@"退保证金",@"提前归还退差额",@"其他"];
}


#pragma mark - 创建表视图和确认按钮
- (void)createApplyRefundView
{
    //创建列表
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight-44) style:UITableViewStyleGrouped];
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    
//    UIColor *bgColor = RGBColor(234, 234, 234, 234);
//    self.view.backgroundColor = bgColor;
    self.mainTableView.backgroundColor = kViewBackColor;
    [self.view addSubview:self.mainTableView];
    
    self.mainTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.mainTableView.showsVerticalScrollIndicator = NO;
    
    //创建尾部视图确认按钮
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 80)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *comfirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    comfirmBtn.frame = CGRectMake(20, 20, kViewWidth-40, 40);
    [comfirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    comfirmBtn.backgroundColor = [UIColor whiteColor];
    [comfirmBtn setTitle:@"确 认" forState:UIControlStateNormal];
    comfirmBtn.clipsToBounds = YES;
    comfirmBtn.layer.cornerRadius = 8;
    [comfirmBtn addTarget:self action:@selector(comfirmCommitRefundApply:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:comfirmBtn];
    
    self.mainTableView.tableFooterView = footerView;
}


- (void)keyBoardDown
{
    [self.view endEditing:YES];
    [self.mainTableView endEditing:YES];
}
/**
 *  确认按钮
 *
 *  @param button 按钮对象
 */
- (void)comfirmCommitRefundApply:(UIButton *)button
{
    NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
    [userDict setValue:self.order_id forKey:@"order_id"];
    [userDict setValue:self.goods_id forKey:@"goods_id"];
    [userDict setValue:APP_DELEGATE.user_id forKey:@"user_id"];
    [userDict setValue:self.txtMoney forKey:@"refund_amount"];
    [userDict setValue:[self.reasonArray objectAtIndex:self.refundReasone] forKey:@"refund_reason"];
    
    [HttpRequestServers requestBaseUrl:TIOrder_Refund withParams:userDict withRequestFinishBlock:^(id result) {
        
        
    } withFieldBlock:^{
        
    }];
    
    ReturnAppayViewController *controller = [[ReturnAppayViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section ) {
        return _isRefundType ? 5 : 1;
    }else if (1 == section){
        return 2;
    }else if (2 == section){
        return _isRefundReason ? 6 : 1;
    }
    
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (0 == indexPath.row) {
            
            //退款类型标题
            MovieRefundMainTypeCell *titleCell = [[[NSBundle mainBundle] loadNibNamed:@"MovieRefundMainTypeCell" owner:self options:nil] lastObject];
            titleCell.chooseTitle.text = @"退款类型";
            titleCell.chooseDetail.text = _typeArray[_refundType-1];
            return titleCell;
            
        }
        else if (0 != indexPath.row && _isRefundType)
        {
            //退款类型选项
            MovieChooseRefundTypeCell *typeCell = [[[NSBundle mainBundle] loadNibNamed:@"MovieChooseRefundTypeCell" owner:self options:nil] lastObject];
            typeCell.chooseBtn.selected = (indexPath.row == _refundType) ? YES : NO;
            typeCell.title.text = _typeArray[indexPath.row-1];
            return typeCell;
        }
    }
    else if (1 == indexPath.section){
        
        if (0 == indexPath.row) {
            
            //退款账号
            MoviceTextFiledCell *accoutCell = [[[NSBundle mainBundle] loadNibNamed:@"MoviceTextFiledCell" owner:self options:nil] lastObject];
            accoutCell.textField.placeholder = @"请输入退款账号";
            accoutCell.textField.keyboardType = UIKeyboardTypeNumberPad;
            self.txtAccount = accoutCell.textField;
            return accoutCell;
            
        }else if (1 == indexPath.row){
            
            //退款金额
            MoviceTextFiledCell *moneyCell = [[[NSBundle mainBundle] loadNibNamed:@"MoviceTextFiledCell" owner:self options:nil] lastObject];
            moneyCell.textField.placeholder = @"请输入退款金额(不超过340元)";
            moneyCell.textField.keyboardType = UIKeyboardTypeDecimalPad;
            self.txtMoney = moneyCell.textField;
            return moneyCell;
        }
    }
    else if (2 == indexPath.section){
        
        if (0 == indexPath.row) {
            
            //退款原因标题
            MovieRefundMainTypeCell *titleCell = [[[NSBundle mainBundle] loadNibNamed:@"MovieRefundMainTypeCell" owner:self options:nil] lastObject];
            titleCell.chooseTitle.text = @"退款原因";
            titleCell.chooseDetail.text = _reasonArray[_refundReasone-1];
            return titleCell;
            
        }
        else if (0 != indexPath.row && _isRefundReason)
        {
            //退款原因选项
            MovieChooseRefundTypeCell *reasonCell = [[[NSBundle mainBundle] loadNibNamed:@"MovieChooseRefundTypeCell" owner:self options:nil] lastObject];
            reasonCell.title.text = _reasonArray[indexPath.row-1];
            reasonCell.chooseBtn.selected = (indexPath.row == _refundReasone) ? YES : NO;
            return reasonCell;
        }
    }
    
    return nil;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }if ([cell respondsToSelector:@selector(setLayoutMargins:)]){
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }if ([tableView respondsToSelector:@selector(setLayoutMargins:)]){
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self keyBoardDown];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (0 == indexPath.section) {
        
        if (0 == indexPath.row) {
            //点击退款类型
            _isRefundType = !_isRefundType;
            
        }
        else{
            //点击退款类型选项
            _refundType = indexPath.row;
        }
        
        [self.mainTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    }
    else if (2 == indexPath.section){
        if (0 == indexPath.row) {
            
            _isRefundReason = !_isRefundReason;
        }
        else{
            _refundReasone = indexPath.row;
        }
        
        [self.mainTableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
    }
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ((0==indexPath.section && 0!=indexPath.row) || (2==indexPath.section && 0!=indexPath.row)) {
        MovieChooseRefundTypeCell *cell = (MovieChooseRefundTypeCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.chooseBtn.selected = NO;
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
