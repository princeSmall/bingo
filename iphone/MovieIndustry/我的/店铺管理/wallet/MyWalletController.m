//
//  MyWalletController.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/17.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MyWalletController.h"
#import "MovieWalletFirstCell.h"
#import "MovieDrawMoneyViewController.h"
#import "MovieBankCardViewController.h"
#import "IncomeDetailsController.h"

@interface MyWalletController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)UITableView *mainTableView;

@end

@implementation MyWalletController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavTabBar:@"钱包"];
    [self createMineWalletViews];
}

- (void)createMineWalletViews
{
    //创建列表
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight-44) style:UITableViewStyleGrouped];
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    
    [self.view addSubview:self.mainTableView];
    
    self.mainTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.mainTableView.showsVerticalScrollIndicator = NO;
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section==0) ? 1 : 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        MovieWalletFirstCell *fisrtCell = [[[NSBundle mainBundle] loadNibNamed:@"MovieWalletFirstCell" owner:self options:nil] lastObject];
        fisrtCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.balance) {
            fisrtCell.money.text = [NSString stringWithFormat:@"￥%.2f",[self.balance floatValue]];
        }
        [fisrtCell.drawMoneyBtn addTarget:self action:@selector(drawMineMoneyAction:) forControlEvents:UIControlEventTouchUpInside];
        
        return fisrtCell;
    }
    else if (1 == indexPath.section){
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        NSArray *array = @[@[@"绑定银行卡",@"收支明细"],@[@"未绑定",@""]];
        cell.textLabel.text = array[0][indexPath.row];
        cell.detailTextLabel.text = array[1][indexPath.row];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0f];
        
        return cell;
    }
    
    
    return nil;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (0 == indexPath.section)?100:45;
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (1 == indexPath.section && 0 == indexPath.row) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MoviePersonal" bundle:nil];
        MovieBankCardViewController *bankCardVC = [storyboard instantiateViewControllerWithIdentifier:@"bangdingCard"];
        [self.navigationController pushViewController:bankCardVC animated:YES];
    }
    else if (1 == indexPath.section && 1 == indexPath.row) {
        
        IncomeDetailsController *incomeDetailVC = [[IncomeDetailsController alloc] init];
        [self.navigationController pushViewController:incomeDetailVC animated:YES];
    }
}


#pragma mark - 提现
- (void)drawMineMoneyAction:(id)sender
{
    MovieDrawMoneyViewController *drawMoneyVC = [[MovieDrawMoneyViewController alloc] init];
    [self.navigationController pushViewController:drawMoneyVC animated:YES];
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
