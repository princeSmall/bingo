//
//  RentGoodsChooseController.m
//  MovieIndustry
//
//  Created by 童乐 Patrick on 2/29/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import "RentGoodsChooseController.h"
#import "RentGoodsChooseCell.h"
#import "RentGoodsFootCell.h"
#import "RentGoodsHeadCell.h"

@interface RentGoodsChooseController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)RentGoodsFootCell *bottomCell;

@property (nonatomic,strong)NSMutableArray * cellArray;

@property (nonatomic,strong)NSMutableArray * buttonArray;
@end

@implementation RentGoodsChooseController

-(NSMutableArray *)buttonArray
{
    if(!_buttonArray)
    {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}
-(NSMutableArray *)cellArray
{
    if(_cellArray ==nil)
    {
        _cellArray = [NSMutableArray array ];
    }
    return _cellArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTabBar:@"商品选择"];
    [self createTableView];
    [self createBottomView];
    [self loadData];
}
/**
 *  刷新数据
 */
-(void)loadData
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  创建底部的view
 */
-(void)createBottomView
{
    
    self.bottomCell = [[[NSBundle mainBundle]loadNibNamed:@"RentGoodsFootCell" owner:self options:nil]lastObject];
    self.bottomCell.frame = CGRectMake(0, self.view.frame.size.height-120, self.view.frame.size.width, 60);
    [self.view addSubview:self.bottomCell];
    [self.bottomCell.allChooseBtn addTarget:self action:@selector(actionSelect:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomCell.payBtn addTarget:self action:@selector(actionPay) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomCell.allChooseBtn setImage:[UIImage imageNamed:@"tick_on"] forState:UIControlStateSelected];
}
/**
 *  全选
 *
 *  @param btn 按钮对象
 */
-(void)actionSelect:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if(btn.selected==YES)
    {
        for(RentGoodsChooseCell *cell in self.cellArray)
        {
            cell.chooseBtn.selected =YES;
            [self.buttonArray addObject:cell.chooseBtn];
        }
        
    }
    else
    {
        for(RentGoodsChooseCell *cell in self.cellArray)
        {
            cell.chooseBtn.selected =NO;
        }
        [self.buttonArray removeAllObjects];
    }
}
/**
 *  付款事件
 */
-(void)actionPay
{
    NSLog(@"去付款");
}
/**
 *  创建tableview
 */
-(void)createTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-120)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
   [self.tableView registerNib:[UINib nibWithNibName:@"RentGoodsChooseCell" bundle:nil] forCellReuseIdentifier:@"RentCell"];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    RentGoodsHeadCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"RentGoodsHeadCell" owner:self options:nil]lastObject];
    return cell;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *cellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
    RentGoodsChooseCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell ==nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"RentGoodsChooseCell" owner:self options:nil]lastObject];;
    }
    //判断是否被选中,防止重用时数据紊乱
    for(UIButton *button in self.buttonArray)
    {
        if(button.tag==indexPath.row)
        {
            cell.chooseBtn.selected = YES;
            break;
        }
        else
        {
            cell.chooseBtn.selected =NO;
        }
    }
    [cell.chooseBtn setImage:[UIImage imageNamed:@"tick_on"] forState:UIControlStateSelected];
    [cell.chooseBtn addTarget:self action:@selector(actionChoose:) forControlEvents:UIControlEventTouchUpInside];
    cell.contentView.backgroundColor = kViewBackColor;
    cell.chooseBtn.tag = indexPath.row;

        NSLog(@"%ld",(long)indexPath.row);
    [self.cellArray addObject:cell];
    //设置下划线
    NSString *marketPrice = [NSString stringWithFormat:@"¥%.2f",15320.0];
    NSUInteger length = marketPrice.length;
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:marketPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid|NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
    cell.marketPriceLbl.attributedText = attri;
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
/**
 *  cell上勾选事件
 *
 *  @param btn 按钮对象
 */
-(void)actionChoose:(UIButton *)btn
{
    btn.selected =!btn.selected;
    NSLog(@"%ld",(long)btn.tag);
    NSMutableArray *array  = [NSMutableArray arrayWithArray:self.buttonArray];
    if(btn.selected==YES)
    {
        [self.buttonArray addObject:btn];
    }
    else
    {
        for(UIButton *button in array)
        {
            if(button.tag ==btn.tag)
            {
                [self.buttonArray removeObject:button];
            }
        }
    }
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
