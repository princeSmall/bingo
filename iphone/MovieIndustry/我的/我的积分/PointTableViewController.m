//
//  PointTableViewController.m
//  Identifier
//
//  Created by Hopkins Patrick on 1/20/16.
//  Copyright © 2016 @_@. All rights reserved.
//

#import "PointTableViewController.h"
#import "PointTableViewCell.h"
#import "IncomeDetailsController.h"
@interface PointTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,assign)int point;
@property (nonatomic,strong)UIView *topView;
@end

@implementation PointTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title = @"我的积分";
//    self.view.backgroundColor =RGBColor(234,234, 234, 1);
    [self setNavTabBar:@"我的积分"];
    //self.point =[self.allPoint intValue];
    self.point  =10000;
    [self setTopView];
    [self requestMinePointDate];
    
}
-(void)setTopView
{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 170)];
    topView.backgroundColor =RGBColor(226, 27, 40, 1);
    [self.view addSubview:topView];
    UILabel *labelLeft = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 100, 30)];
    labelLeft.text = @"当前积分";
    labelLeft.textColor = [UIColor whiteColor];
    labelLeft.textAlignment = NSTextAlignmentCenter;
    labelLeft.font = [UIFont boldSystemFontOfSize:16];
    [topView addSubview:labelLeft];
    
    UIButton *questionButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-115, 10, 115, 30)];
    [questionButton setImage:[UIImage imageNamed:@"icon_wen"] forState:UIControlStateNormal];
    [questionButton setImageEdgeInsets:UIEdgeInsetsMake(4, 4, 4, 115-26)];
    [questionButton setTitle:@"积分抵扣规则" forState:UIControlStateNormal];
    questionButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [questionButton setTitleEdgeInsets:UIEdgeInsetsMake(7, -40, 4,0)];
    [topView addSubview:questionButton];
    [questionButton addTarget:self action:@selector(actionCheckPoint:) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSString *point  = [NSString stringWithFormat:@"%d",self.point];
    int length = (int)point.length;
    
    UILabel *pointLabel =[[UILabel alloc]initWithFrame:CGRectMake(80, 45, 130+(length-5)*20, 50)];
    pointLabel.text = [NSString stringWithFormat:@"%d", self.point];
    pointLabel.font = [UIFont fontWithName:@"AppleGothic" size:35];
    pointLabel.textColor = [UIColor whiteColor];
    [topView addSubview:pointLabel];
    
    UILabel *fenLabel = [[UILabel alloc]initWithFrame:CGRectMake(pointLabel.frame.size.width+pointLabel.frame.origin.x-5, 15+pointLabel.frame.origin.y, 20, pointLabel.frame.size.height/2)];
    fenLabel.text = @"分";
    fenLabel.textColor = [UIColor whiteColor];
    [topView addSubview:fenLabel];
    
    
    UIButton *bottomLabel = [[UIButton alloc]initWithFrame:CGRectMake(0, topView.frame.size.height-30-2, self.view.frame.size.width, 30)];
    bottomLabel.backgroundColor = RGBColor(234, 234, 234, 1);
    [bottomLabel setTitle:@"收支明细" forState:UIControlStateNormal];
    [bottomLabel setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, self.view.frame.size.width-80)];
    bottomLabel.titleLabel.font = [UIFont systemFontOfSize:16];
    [bottomLabel setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [topView addSubview:bottomLabel];
    [bottomLabel addTarget:self action:@selector(actionIncomeDetail:) forControlEvents:UIControlEventTouchUpInside];
    self.topView = topView;
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, bottomLabel.frame.size.height+bottomLabel.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-100) style:UITableViewStyleGrouped];
    tableView.delegate =self;
    tableView.dataSource =self;
    [self.view addSubview:tableView];
    tableView.backgroundColor = RGBColor(234, 234, 234, 1);
}
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    [view addSubview:self.topView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    NSLog(@"%@",NSStringFromCGRect(self.topView.frame));
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellIdentifier";
    PointTableViewCell *cell ;
    cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PointTableViewCell" owner:self options:nil] firstObject];
    }
    
    cell.LeftTop.text = @"签到积分";
    UIView *bottonLine = [[UIView alloc]initWithFrame:CGRectMake(0, 80-1, 5000, 1)];
    cell.LeftBottom.text = @"2016/1/20";
    
    cell.Right.text =@"+ 10";
    bottonLine.backgroundColor = [UIColor lightGrayColor];
    [cell addSubview:bottonLine];
    // Configure the cell...
    cell.userInteractionEnabled = NO;
    return cell;
}
/**
 *  积分规则
 *
 *  @param sender 按钮对象
 */
-(void)actionCheckPoint:(UIButton *)sender
{
    
}
/**
 *  收支明细
 *
 *  @param sender 按钮对象
 */
-(void)actionIncomeDetail:(UIButton *)sender
{
    IncomeDetailsController *controller = [[IncomeDetailsController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}
/**
 *  请求积分数据
 */
-(void)requestMinePointDate
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在加载";
    [HUD show:YES];
    [MovieHttpRequest createMinePointRecordCallBack:^(id obj){
        [HUD hide:YES];
        //NSMutableArray *array = [NSMutableArray arrayWithArray:obj];
    } andSCallBack:^(id obj) {
        [HUD hide:YES];
        [DeliveryUtility showMessage:obj target:self];
    }];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
