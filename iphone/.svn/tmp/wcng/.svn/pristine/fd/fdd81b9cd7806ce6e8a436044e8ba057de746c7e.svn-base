//
//  ShippingController.m
//  MovieIndustry
//
//  Created by baokuanxun on 16/4/5.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "ShippingController.h"

@interface ShippingController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong)UITableView *tableView;

@property (nonatomic,strong)UITextField *numberTextfield;

@property (nonatomic ,strong)UITextField *wordTextfield;
@end

@implementation ShippingController

-(BusinessOrderModel *)orderModel
{
    if(!_orderModel)
    {
        _orderModel = [[BusinessOrderModel  alloc]init];;
    }
    return _orderModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTabBar:@"上传物流单号"];
    self.view.backgroundColor = [UIColor colorWithRed:0.910 green:0.918 blue:0.922 alpha:1.000];
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self ;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor =[UIColor colorWithRed:0.910 green:0.918 blue:0.922 alpha:1.000];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self createFooterView];
    
}
/**
 *  创建footerView
 */
-(void)createFooterView
{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width-20, 50)];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(actionShipping) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:button];
    [button setTitleColor:[UIColor colorWithRed:0.337 green:0.341 blue:0.345 alpha:1.000] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:0.996 green:1.000 blue:1.000 alpha:1.000];
    button.layer.cornerRadius = 8;
    self.tableView.tableFooterView = footerView;
   
    
    
}
/**
 *  发货
 */
-(void)actionShipping
{
    NSLog(@"发货呗点击");
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud show:YES];
    NSMutableDictionary *prama = [NSMutableDictionary dictionary];
    [prama setValue:_orderModel.order_id forKey:@"order_id"];
    [prama setValue:APP_DELEGATE.user_id forKey:@"user_id"];
    [prama setValue:@"1" forKey:@"status"];
    [prama setValue:self.numberTextfield.text forKey:@"express_number"];
    [prama setValue:self.wordTextfield.text forKey:@"express_company"];
    HHNSLog(@"发货传的字典%@",prama);
    [HttpRequestServers requestBaseUrl:TIShopOrder_UpdateOrderStatus withParams:prama withRequestFinishBlock:^(id result) {
        HHNSLog(@"发货请求的数据%@",result);
        NSDictionary *dict = result;
       
        if([dict[@"code"] intValue]==0)
        {
            if([self.isDetail isEqualToString:@"Yes"])
            {
                NSMutableArray *arr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
                [arr removeObjectAtIndex:arr.count-2];
                self.navigationController.viewControllers = arr;
            }
            [self.navigationController popViewControllerAnimated:YES];
             [hud hide:YES];
        }
        else
        {
            hud.labelText = @"发货失败";
            [hud hide:YES afterDelay:0.5];
        }
        
    } withFieldBlock:^{
        
    }];
                                  
}

#pragma tabelview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell ==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
   
    [self setMycell:cell indexpath:indexPath];
    return cell;
}
-(void)setMycell:(UITableViewCell *)cell indexpath:(NSIndexPath *)indexpath
{
     NSArray *array = [NSArray arrayWithObjects:@"请输入快递公司名称",@"请输入单号", nil];
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(8, 5, 160, 40)];
//    label.text =[array objectAtIndex:indexpath.row];
//    [cell.contentView addSubview:label];
//    CGRect rect = self.view.frame;
    UIView  *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50-1, kViewWidth, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:0.906 green:0.910 blue:0.918 alpha:1.000];
    [cell addSubview:lineView];
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, kViewWidth, cell.frame.size.height)];
    textField.borderStyle = UITextBorderStyleNone;
    textField.textAlignment = NSTextAlignmentLeft;
    [cell.contentView addSubview:textField];
    if(indexpath.row==1)
    {
        textField.keyboardType = UIKeyboardTypeNumberPad;
        self.numberTextfield = textField;
    }else
    {
        self.wordTextfield = textField;
    }
    textField.placeholder = [array objectAtIndex:indexpath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
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
