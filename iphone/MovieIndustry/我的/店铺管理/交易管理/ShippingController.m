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
@end

@implementation ShippingController

-(NSDictionary *)goodsDict
{
    if(!_goodsDict)
    {
        _goodsDict = [NSDictionary  dictionary];
    }
    return _goodsDict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTabBar:@"发货"];
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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self createFooterView];
    
}
/**
 *  创建footerView
 */
-(void)createFooterView
{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
    self.tableView.tableFooterView = footerView;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width-20, 50)];
    [button setTitle:@"发货" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(actionShipping) forControlEvents:UIControlEventTouchUpInside];
    
    
}
/**
 *  发货
 */
-(void)actionShipping
{
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
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
     NSArray *array = [NSArray arrayWithObjects:@"快递单号",@"快递公司",@"商品名", nil];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(8, 5, 80, 40)];
    label.text =[array objectAtIndex:indexpath.row];
    [cell.contentView addSubview:label];
    
    CGRect rect = self.view.frame;
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(90, 5,rect.size.width-100 , 40)];
    textField.borderStyle = UITextBorderStyleNone;
    textField.textAlignment = NSTextAlignmentRight;
    [cell.contentView addSubview:textField];
    if(indexpath.row==0)
    {
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    if(indexpath.row==2)
    {
        textField.userInteractionEnabled = NO;
        NSDictionary *dict =self.goodsDict[@"shop_goods"];
        NSString *name = dict[@"goods_name"];
//        for(NSDictionary *dic in array)
//        {
//            name = [name stringByAppendingFormat:@"%@,%@",name,dic[@"goods_name"]];
//        }
        
        textField.text = name;
    }
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
