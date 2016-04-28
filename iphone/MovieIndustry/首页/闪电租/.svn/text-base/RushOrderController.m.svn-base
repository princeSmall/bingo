//
//  RushOrderController.m
//  MovieIndustry
//
//  Created by Hopkins Patrick on 3/1/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import "RushOrderController.h"
#import "RushOrdersCell.h"
#import "RushOrdersFootCell.h"

@interface RushOrderController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
/**
 *  所有cell的对象
 */
@property (nonatomic,strong)NSMutableArray *cellArray;
/**
 *  选中的按钮对象
 */
@property (nonatomic,strong)NSMutableArray *buttonArray;

@end

@implementation RushOrderController
-(NSMutableArray *)cellArray
{
    if(!_cellArray)
    {
        _cellArray =[NSMutableArray array];
    }
    return _cellArray;
}
-(NSMutableArray *)buttonArray
{
    if(!_buttonArray)
    {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"抢订单"];
    [self createTableView];
    [self createBottomView];
    // Do any additional setup after loading the view.
}
/**
 *  创建tableview
 */
-(void)createTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-60) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = kViewBackColor;
    
}
/**
 *  创建底部的view
 */
-(void)createBottomView
{
    RushOrdersFootCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"RushOrdersFootCell" owner:self options:nil]lastObject];
    cell.frame = CGRectMake(0, self.view.frame.size.height-120, self.view.frame.size.width, 60);
    [self.view addSubview:cell];
    [cell.allChooseBtn addTarget:self action:@selector(actionAllChoose:) forControlEvents:UIControlEventTouchUpInside];
    [cell.allChooseBtn setImage:[UIImage imageNamed:@"tick_on"] forState:UIControlStateSelected];
    cell.rushOrdersBtn.layer.borderWidth=1.0f;
    cell.rushOrdersBtn.layer.borderColor = RGBColor(234, 234, 234, 1).CGColor;
    cell.rushOrdersBtn.layer.cornerRadius = 3.0f;

}
/**
 *  全选按钮事件
 */
-(void)actionAllChoose:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if(btn.selected==YES)
    {
        for(RushOrdersCell *cell  in self.cellArray)
        {
            cell.chooseBtn.selected = YES;
            [self.buttonArray addObject:cell.chooseBtn];
        }
    }
    else
    {
        for(RushOrdersCell *cell  in self.cellArray)
        {
            cell.chooseBtn.selected = NO;
        }
        [self.buttonArray removeAllObjects];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 3;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"RushOrdersCell";
    RushOrdersCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"RushOrdersCell" owner:self options:nil]lastObject];
        
    }
    
    for(UIButton * button in self.buttonArray)
    {
        if(button.tag == indexPath.section)
        {
            cell.chooseBtn.selected =YES;
            break;
        }
        else
        {
            cell.chooseBtn.selected =NO;
        }
    }
    [cell.chooseBtn addTarget:self action:@selector(actionChoose:) forControlEvents:UIControlEventTouchUpInside];
    [cell.chooseBtn setImage:[UIImage imageNamed:@"tick_on"] forState:UIControlStateSelected];
    cell.chooseBtn.tag = indexPath.section;
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
/**
 *  选择按钮事件
 *
 *  @param btn 按钮对象
 */
-(void)actionChoose:(UIButton *)btn
{
    btn.selected = !btn.selected;
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.buttonArray];
    if(btn.selected==YES)
    {
        [self.buttonArray addObject:btn];
    }
    else
    {
        for(UIButton * button in array)
        {
            if(button.tag == btn.tag)
            {
                [self.buttonArray removeObject:button];
                
            }
        }
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{

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
