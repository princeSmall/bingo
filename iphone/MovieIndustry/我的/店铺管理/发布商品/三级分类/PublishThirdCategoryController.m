//
//  PublishSecondCategoryController.m
//  MovieIndustry
//
//  Created by Hopkins Patrick on 3/10/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import "PublishThirdCategoryController.h"
#import "SecondCategoryCell.h"

@interface PublishThirdCategoryController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *tableView;
//分类列表
@property (nonatomic, strong)NSMutableArray *categoryArray;
//当前选中的行
@property (assign ,nonatomic) NSInteger rowTag;
@end

@implementation PublishThirdCategoryController
-(NSMutableArray *)categoryArray
{
    if(!_categoryArray)
    {
        _categoryArray = [NSMutableArray array];
    }
    return _categoryArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTabBar:self.category_name];
    
    [self createTableView];
    
    [self loadData];
}
/**
 *  创建列表
 */
-(void)createTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight-44) style:UITableViewStylePlain];
    self.tableView .dataSource = self;
    self.tableView .delegate  =self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.tableView];
}
/**
 *  加载数据
 */
-(void)loadData
{
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:APP_DELEGATE.user_id,@"user_id",self.category_id,@"category_id",@"3",@"cat_type", nil];
    __weak typeof(self)wself = self;
    [HttpRequestServers requestBaseUrl:TIPublish_Categories withParams:userDic withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        if([dict[@"code"] intValue]==0)
        {
            id data = dict[@"data"];
            if([[data class] isSubclassOfClass:[NSArray class]])
            {
                for(NSDictionary *dic in data)
                {
                    [wself.categoryArray addObject: dic];
                }
            }
            [self.tableView reloadData];
        }
        
    } withFieldBlock:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categoryArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"cellrow%ld%ld",(long)indexPath.row,(long)indexPath.section];
    SecondCategoryCell *cell ;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell ==nil)
    {
        cell= [[[NSBundle mainBundle]loadNibNamed:@"SecondCategoryCell" owner:self options:nil] lastObject];
        
    }
    cell.rightImage.hidden = YES;
    
    
    cell.categoryLbl.text = [self.categoryArray objectAtIndex:indexPath.row][@"category_name"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray  *arr =[NSMutableArray arrayWithArray: self.navigationController.viewControllers];
    [arr removeObjectAtIndex:arr.count-2];
    self.navigationController.viewControllers = arr;
    self.thirdBackFn([self.categoryArray objectAtIndex:indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)setNavTabBar:(NSString *)title
{
    UILabel *ntitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    ntitle.textAlignment = NSTextAlignmentCenter;
    ntitle.textColor = [UIColor whiteColor];
    ntitle.text = title;
    ntitle.font = [UIFont systemFontOfSize:BigBigFont];
    self.navigationItem.titleView = ntitle;
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 20, 20)];
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //添加点击事件
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    //    [self.navigationController.navigationBar addSubview:leftBtn];
    
    //设置TabBar左边的按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
}
-(void)backAction
{
   
    [self.navigationController popViewControllerAnimated:YES];

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
