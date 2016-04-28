//
//  DidBuyingController.m
//  MovieIndustry
//
//  Created by Hopkins Patrick on 1/28/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import "DidBuyingController.h"
#import "HistoryBuyingHeadCell.h"
#import "HistoryBuyingCell.h"


@interface DidBuyingController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation DidBuyingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTabBar:@"抢购成功的"];
    [self createTableView];
    
}
-(void)createTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = RGBColor(230, 230, 230, 1);
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    HistoryBuyingCell *cell ;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell ==nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HistoryBuyingCell" owner:self options:nil]lastObject];
        [self changeString:cell];
        UIView *viewLine = [[UIView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 1)];
        viewLine.backgroundColor = RGBColor(239, 239, 239, 1);
        [cell.contentView addSubview:viewLine];
    }
    return cell;
}

-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 65;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HistoryBuyingHeadCell *cell  = [[[NSBundle mainBundle]loadNibNamed:@"HistoryBuyingHeadCell" owner:self options:nil]lastObject];
    return cell;
    
}



-(void)changeString:(HistoryBuyingCell *)cell
{
    NSString *gradeLevel = [NSString stringWithFormat:@"V13"];
    NSMutableAttributedString *levelAtt = [[NSMutableAttributedString alloc] initWithString:gradeLevel];
    [levelAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15.0f] range:NSMakeRange(0,1)];
    [levelAtt addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, gradeLevel.length)];
    [cell.levelBtn setAttributedTitle:levelAtt forState:UIControlStateNormal];
    cell.portraitImageView.layer.borderWidth = 2.0;
    cell.portraitImageView.layer.borderColor = RGBColor(209, 209, 209, 1).CGColor;
    cell.portraitImageView.layer.cornerRadius = 30;
    cell.levelBtn.layer.cornerRadius = 7.0;
    
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
