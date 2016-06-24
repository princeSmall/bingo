//
//  BusinessBuyingController.m
//  MovieIndustry
//
//  Created by 童乐 Patrick on 1/28/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import "BusinessBuyingController.h"
#import "BusinessCell.h"
#import "BusinessFootCell.h"
#import "BusinessHeadCell.h"

@interface BusinessBuyingController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *tableView;
@end

@implementation BusinessBuyingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTableView];
    [self setNavTabBar:@"已抢单的商家"];
}

-(void)createTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = RGBColor(230, 230, 230, 1);
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BusinessHeadCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"BusinessHeadCell" owner:self options:nil]lastObject];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    BusinessFootCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"BusinessFootCell" owner:self options:nil]lastObject];
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier =@"CellIndentifier";
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(cell==nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"BusinessCell" owner:self options:nil]lastObject];
        ///设置下划线
        NSString *oldPrice = [NSString stringWithFormat:@"￥%.2f",[[WNController nullString:cell.goodOrdlePriceLbl.text] floatValue]];
        NSUInteger length = [oldPrice length];
        
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
        [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
        cell.goodOrdlePriceLbl.attributedText = attri;
        
        
    }
    return cell;
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
