//
//  PayOrderController.m
//  MovieIndustry
//
//  Created by Hopkins Patrick on 3/1/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import "PayOrderController.h"
#import "PayOrderBottomView.h"
#import "PayOrderHeadCell.h"
#import "CartGood.h"

@interface PayOrderController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)PayOrderBottomView * bottomView;

@end

@implementation PayOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"支付订单"];
    //创建地址
    [self createTableView];
    [self createAddress];
    [self loadData];
    // Do any additional setup after loading the view.
}
/**
 *  加载数据
 */
- (void)createAddress{

    self.bottomView.addressDic = self.addressDic;

}

-(void)loadData
{
    

}
/**
 *  创建tableview视图
 */
-(void)createTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds  style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    

    PayOrderBottomView *bottomView = [[[NSBundle mainBundle]loadNibNamed:@"PayOrderBottomView" owner:self options:nil]lastObject];
    self.bottomView = bottomView;
    [bottomView  createMyTableViewAndEndBlock:^(NSString *type) {
        if ([type isEqualToString:@"0"]) {
            //支付宝
            NSLog(@"支付宝");
        }
        if ([type isEqualToString:@"1"]){
            //银联
            NSLog(@"银联");
        }
    }];
    CGSize size =CGSizeMake(self.view.frame.size.width, 103*3+400+100);
    bottomView.tableView.frame = CGRectMake(0, 0,  self.view.frame.size.width, 128);
    self.tableView.contentSize = size;
    bottomView.payBtn.layer.cornerRadius = 5.0f;
    [bottomView.payBtn addTarget:self action:@selector(actionPay) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = bottomView;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.view setNeedsDisplay];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.model) {
        return 1;
    }else{
        return self.goodsInfoArray.count;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 103;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"PayHeadCell";
    PayOrderHeadCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PayOrderHeadCell" owner:self options:nil]lastObject];
    }
    if (self.model) {
        [cell.goodsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIBIGImage,self.model.imgs[0]]]];
        cell.goodsNameLbl.text = self.model.goods_name;
        cell.goodsPriceLbl.text = [NSString stringWithFormat:@"￥%@",self.model.goods_price];
        cell.goodsNumebrLbl.text = [NSString stringWithFormat:@"X%@",self.goodsCount];
        
        if (!self.model.goods_deposit) {
            self.model.goods_deposit = @"0";
        }
        
        cell.yajinLabel.text = [NSString stringWithFormat:@"￥%@",self.model.goods_deposit];
    }else{
        CartGood * good = self.goodsInfoArray[indexPath.row];
        [cell.goodsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIBIGImage,good.img_path]]];
        cell.goodsNameLbl.text = good.goods_name;
        cell.goodsPriceLbl.text = [NSString stringWithFormat:@"￥%@",good.goods_price];
        cell.goodsNumebrLbl.text = [NSString stringWithFormat:@"X%@",good.goods_number];
        cell.yajinLabel.text = [NSString stringWithFormat:@"￥%@",good.goods_deposit];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)actionPay
{
    NSLog(@"支付订单支付");
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
