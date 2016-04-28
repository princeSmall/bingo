//
//  RefundApplyController.m
//  MovieIndustry
//
//  Created by baokuanxun on 16/4/7.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "RefundApplyController.h"
#import "ReturnAppayViewController.h"

@interface RefundApplyController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
/**
 *  退款理由view
 */
@property (weak, nonatomic) IBOutlet UIView *reasonView;
/**
 *  退额上限lbl
 */
@property (weak, nonatomic) IBOutlet UILabel *MaximentAmountLbl;
/**
 *  是否选择积分选择器
 */
@property (weak, nonatomic) IBOutlet UISwitch *integralSwith;
/**
 *  确认按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
/**
 *  退款理由数组
 */
@property (nonatomic ,strong)NSArray *reasonArray;
/**
 *  选择退款理由按钮
 */
@property (nonatomic ,strong)UIButton *chooseReasonBtn;
/**
 *  退款金额view
 */
@property (weak, nonatomic) IBOutlet UIView *refundNumberView;
/**
 *  金额输入框
 */
@property (nonatomic,strong) UITextField *numberTextField;
/**
 *  下拉列表
 */
@property (nonatomic,strong)UITableView *downTableView;
/**
 *  选中的第几行
 */
@property (nonatomic,assign)NSInteger selectRow;


@end
@implementation RefundApplyController

-(NSArray *)reasonArray
{
    if(!_reasonArray)
    {
        _reasonArray = @[@"与卖家协商一致",@"买家原因",@"退保证金",@"提前归还退差额",@"其他"];
    }
    return _reasonArray;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTabBar:@"申请退款"];
    self.selectRow = 1000;
    self.view.backgroundColor = [UIColor colorWithWhite:0.918 alpha:1.000];
     //添加手势
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionTouch)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    self.integralSwith.on = NO;
    self.integralSwith.userInteractionEnabled = NO;
    [self refreshView];
    
}
/**
 *  单击手势
 */
-(void)actionTouch
{
    [self.view endEditing:YES];
//    [self textFieldDidEndEditing:self.numberTextField];
}
/**
 *  更新ui
 */
-(void)refreshView
{

    //退款原因按钮
    self.reasonView.layer.borderColor = [UIColor colorWithWhite:0.749 alpha:1.000].CGColor;
    self.reasonView.layer.borderWidth = 1.0;

    UIButton *chooseReasonBtn = [[UIButton alloc]initWithFrame:self.reasonView.bounds];
    [chooseReasonBtn addTarget:self action:@selector(actionChooseReason:) forControlEvents:UIControlEventTouchUpInside];
    [chooseReasonBtn setTitle:@"请选择退款按钮" forState:UIControlStateNormal];
    [chooseReasonBtn setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
    [chooseReasonBtn setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateSelected];
    [chooseReasonBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [chooseReasonBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 460)];
    [chooseReasonBtn setImageEdgeInsets:UIEdgeInsetsMake(0,200, 0, 0)];
    chooseReasonBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.chooseReasonBtn = chooseReasonBtn;
    [self.reasonView addSubview:chooseReasonBtn];
    
    //退款金额View
    self.refundNumberView.layer.borderColor =[UIColor colorWithWhite:0.749 alpha:1.000].CGColor;
    self.refundNumberView.layer.borderWidth =1;
    CGRect frame = self.refundNumberView.bounds;
    frame.origin.x +=13;
    frame.size.width -=13;
    UITextField *refundNumberTfd = [[UITextField alloc]initWithFrame:frame];
    [self.refundNumberView addSubview:refundNumberTfd];
    refundNumberTfd.placeholder = @"请输入退款金额";
    refundNumberTfd.font =[UIFont systemFontOfSize:14];
    refundNumberTfd.keyboardType = UIKeyboardTypeNumberPad;
    self.numberTextField = refundNumberTfd;
    self.numberTextField.delegate = self;
    
    //确认按钮
    self.confirmBtn .backgroundColor = [UIColor colorWithWhite:0.976 alpha:1.000];
    self.confirmBtn.layer.cornerRadius = 8.0;
    [self.confirmBtn addTarget:self action:@selector(actionConfirm:) forControlEvents:UIControlEventTouchUpInside];
    
    self.MaximentAmountLbl.text = [NSString stringWithFormat:@"最多%@",self.goods_price];
   
}
/**
 *  选择退款原因按钮
 *
 *  @param btn 按钮对象
 */
-(void)actionChooseReason:(UIButton *)btn
{
    if(!self.downTableView)
    {
        self.downTableView  =[[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.reasonView.frame), CGRectGetMaxY(self.reasonView.frame), self.reasonView.frame.size.width, 220)];
        [self.view addSubview:self.downTableView];
        self.downTableView.dataSource =self;
        self.downTableView.delegate = self;
        self.downTableView.scrollEnabled = NO;
    }
    else
    {
        self.downTableView.hidden = !self.downTableView.hidden;
    }
}
/**
 *  确认退款
 *
 *  @param btn 退款按钮
 */
-(void)actionConfirm:(UIButton *)btn
{
    [self.view endEditing:YES];
    if([self judgeItems]==NO)
    {
        return ;
    }else
    {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"退款详情" message:[NSString stringWithFormat:@"退款金额：%@      \n 退还积分：%@                      \n退款原因：%@",self.goods_price,self.jifen,[self.reasonArray objectAtIndex:self.selectRow]] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction =[UIAlertAction actionWithTitle:@"修改" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:APP_DELEGATE.user_id forKey:@"user_id"];
        [param setValue:self.order_id forKey:@"order_id"];
        [param setValue:self.goods_id forKey:@"goods_id"];
        [param setValue:[self.reasonArray objectAtIndex:self.selectRow] forKey:@"refund_reason"];
        [param setValue:self.numberTextField.text forKey:@"refund_amount"];
        
//        TIOrder_AddOrder
        
        [HttpRequestServers requestBaseUrl:TIOrder_Refund withParams:param withRequestFinishBlock:^(id result) {
            NSDictionary *dict = result;
            HHNSLog(@"%@",dict);
            if([dict[@"code"] intValue]==0)
            {
                ReturnAppayViewController *controller = [[ReturnAppayViewController alloc]init];
                [self.navigationController pushViewController:controller animated:YES];
            }
        } withFieldBlock:^{
            
        }];

        
    }];
    [controller addAction:cancelAction];
    [controller addAction:okAction];
    [self presentViewController:controller animated:YES completion:nil];

    //更改字体
    controller.view.tintColor = [UIColor colorWithRed:0.922 green:0.247 blue:0.333 alpha:1.000];
    
    }
    
}
/**
 *  判断是否填写退款原因和金额
 *
 *  @return 判断结果
 */
-(BOOL)judgeItems
{
    if(self.selectRow ==1000)
    {
        [DeliveryUtility showMessage:@"请选择退款类型" target:self];
        return NO;
    }
    else
    if(self.numberTextField.text.length==0)
    {
        [DeliveryUtility showMessage:@"请输入退款金额" target:self];
        return NO;
    }else
        if([self.numberTextField.text intValue]>[self.goods_price intValue])
        {
            [DeliveryUtility showMessage:@"请输入小于商品价格的数字" target:self];
            return NO;
        }
    else
    {
        return YES;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark tableview delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.reasonArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifeir = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifeir];
    if(cell==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifeir];
    }
    [self createUIForCell:cell indexpath:indexPath];
    return cell;
}
-(void)createUIForCell:(UITableViewCell *)cell
             indexpath:(NSIndexPath *)indexpath
{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, cell.frame.size.height)];
    [cell addSubview:label];
    label.text = [self.reasonArray objectAtIndex:indexpath.row];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorWithRed:0.463 green:0.467 blue:0.471 alpha:1.000];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.reasonView.bounds.size.width-30, 14, 14, 14)];
    [button setImage:[UIImage imageNamed:@"tick_off"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"tick_on"] forState:UIControlStateSelected];
    [cell addSubview:button];
    [button addTarget:self action:@selector(actionSelect:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = indexpath.row+100;
    
}
-(void)actionSelect:(UIButton *)btn
{
     NSInteger row = btn.tag-100;
    //第一次进入
    if(self.selectRow!=1000)
    {
        UIButton *button = (UIButton *)[self.downTableView viewWithTag:self.selectRow+100];
        button.selected = !button.selected;
    }
   
    btn.selected = !btn.selected;
    [self.chooseReasonBtn setTitle:[self.reasonArray objectAtIndex:row] forState:UIControlStateNormal];
    self.selectRow =row;
    self.downTableView.hidden=YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //第一次进入
    if(self.selectRow!=1000)
    {
        UIButton *button = (UIButton *)[self.downTableView viewWithTag:self.selectRow+100];
        button.selected = !button.selected;
    }
    //获取本行的button
    UIButton *selfBtn = (UIButton *)[self.downTableView viewWithTag:indexPath.row+100];
    selfBtn.selected = !selfBtn.selected;
    self.selectRow = indexPath.row;
    [self.chooseReasonBtn setTitle:[self.reasonArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    self.downTableView.hidden=YES;
    
    
}

#pragma  mark textfield delegate
//- (void)textFieldDidEndEditing:(UITextField *)textField;
//{
//    if([textField.text intValue]>[self.goods_price intValue])
//    {
//        [DeliveryUtility showMessage:@"请输入小于商品价格的数字" target:self];
//        
//    }
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
