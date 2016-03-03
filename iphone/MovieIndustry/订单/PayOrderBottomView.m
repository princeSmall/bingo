//
//  PayOrderBottomView.m
//  MovieIndustry
//
//  Created by Hopkins Patrick on 3/1/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import "PayOrderBottomView.h"
#import "PayWayCell.h"
@interface PayOrderBottomView()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray *buttonArray;
@property (nonatomic,strong)NSString * type;
@property (nonatomic,strong)EndBlock block;

@end
@implementation PayOrderBottomView

-(NSMutableArray *)buttonArray
{
    if(!_buttonArray)
    {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/**
*  创建tableView
*/

- (void)setAddressDic:(NSDictionary *)addressDic{
    _addressDic = addressDic;
    self.userNameLbl.text = addressDic[@"name"];
    self.shipAddressLbl.text = addressDic[@"address"];
    self.phoneNumberLbl.text = addressDic[@"phone"];
    self.dealPriceLbl.text = [NSString stringWithFormat:@"￥%@",addressDic[@"price"]];
}

-(void)createMyTableViewAndEndBlock:(EndBlock)block
{
    //CGRect rect =CGRectMake(0, 0, self.frame.size.width, 128);
    self.block = block;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 128) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.centerView addSubview:self.tableView];
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PayWayCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"PayWayCell" owner:self options:nil]lastObject];
    
    if(indexPath.row==0)
    {
        cell.selectBtn.tag = 7771;
    }
    else if(indexPath.row==1)
    {
        cell.payImageView.image = [UIImage imageNamed:@"银联_"];
        cell.payWayLbl.text= @"银联支付";
        cell.payBottomLbl.text = @"支持储蓄卡,无需开通网银";
        cell.selectBtn.tag = 7772;
    }
    [cell.selectBtn setImage:[UIImage imageNamed:@"checked_"] forState:UIControlStateSelected];
    [cell.selectBtn addTarget:self action:@selector(actionChoose:) forControlEvents:UIControlEventTouchUpInside];
    cell.bounds = CGRectMake(0, 0,self.centerView.frame.size.width,64);
    [self.buttonArray addObject:cell.selectBtn];
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    return cell;
}
- (IBAction)payAction:(id)sender {
    
    if ([self.type isEqualToString: @""]) {
        self.type = @"0";
    }
    
    self.block(self.type);
    
}

-(void)actionChoose:(UIButton *)btn
{
    self.type = [NSString stringWithFormat:@"%d",(int)btn.tag - 7771];
    btn.selected = !btn.selected;
    if(btn.selected==YES)
    {
        for(UIButton *button in self.buttonArray)
        {
            if(![button isEqual:btn])
            {
                button.selected =NO;
            }
        }
    }
    else
    {
        for(UIButton *button in self.buttonArray)
        {
            if(![button isEqual:btn])
            {
                if(button.selected==NO &&btn.selected==NO)
                {
                    btn.selected =YES;
                }
            }
        }
    }
}

@end
