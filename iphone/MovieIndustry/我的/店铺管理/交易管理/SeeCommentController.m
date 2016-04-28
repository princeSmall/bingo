//
//  OrderCommentsController.m
//  MovieIndustry
//
//  Created by baokuanxun on 16/4/19.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "SeeCommentController.h"
#import "OrderGoodsModel.h"
#import "OrderTICommentCell.h"
#import "SysTool.h"
#import "SeeModel.h"



@interface SeeCommentController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>
@property (nonatomic ,strong)UITableView *tableView;
/**
 *  打分的词典
 */
@property (nonatomic ,strong)NSMutableDictionary *scoreDict;
/**
 *  商品id数组
 */
@property (nonatomic ,strong)NSMutableArray *goods_idArray;
/**
 *  商品信息数组 OrderGoodsModel
 */
@property (nonatomic ,strong)NSMutableArray *goodsArray;

/**
 *  选去照片的cell的indexpath
 */
@property (nonatomic ,strong)NSIndexPath *indexpath;
/**
 *  选择图片的词典
 */
@property (nonatomic ,strong)NSMutableDictionary *picDict;
/**
 *  评论的图片词典
 */
@property (nonatomic ,strong)NSMutableDictionary *commentDict;

/**
 *  评论内容的词典 防止重用的
 */
@property (nonatomic ,strong)NSMutableDictionary *commentTextDict;

@end

@implementation SeeCommentController


-(NSMutableArray *)goodsArray
{
    if(!_goodsArray)
    {
        _goodsArray = [NSMutableArray array];
    }
    return _goodsArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTabBar:@"查看评价"];
    
    [self loadData];
    

    
}

/**
 *  生成tableView
 */
-(void)createTableView
{
    self.tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight-44) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderTICommentCell" bundle:nil] forCellReuseIdentifier:@"cellComment"];
    self.tableView.separatorStyle=  UITableViewCellSeparatorStyleNone;
    
    
}
/**
 *  加载数据
 */
-(void)loadData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"user_id"] = APP_DELEGATE.user_id;
    param[@"order_id"] = self.order_id;
    [HttpRequestServers requestBaseUrl:TIOrder_EvaluateList withParams:param withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        if([dict[@"code"] intValue]==0)
        {
            NSArray *commentArr = dict[@"data"];
            for(NSDictionary *commentDict in commentArr)
            {
                SeeModel *model = [[SeeModel alloc]initWithDict:commentDict];
                
                [self.goodsArray addObject:model];
            }
            
            [self createTableView];
        }
        
    } withFieldBlock:^{
        
    }];
}
#pragma mark tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goodsArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 385;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderTICommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellComment" forIndexPath:indexPath];
    OrderGoodsModel *goodsModel = self.goodsArray[indexPath.row];
    cell.goodsDesripeTField.tag = 600+indexPath.row;
    cell.goodsDesripeTField.delegate =self;
    cell.photoBtn.tag = indexPath.row +500;
    UIImage *image ;
    NSString *str ;
    for(id key in self.picDict)
    {
        if([key intValue] ==indexPath.row)
        {
            image = [self.picDict valueForKey:key];
        }
    }
    for(id key in self.commentTextDict)
    {
        if([key intValue] ==indexPath.row)
        {
            str = [self.commentTextDict valueForKey:key];
        }
    }
    __weak typeof(self) weakSelf = self;
    
    cell.starView.selectFn = ^(int score){
        [weakSelf.scoreDict setValue:[NSString stringWithFormat:@"%d",score] forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        
    };
    int cellscore= 0;
    for(id key in self.scoreDict)
    {
        if([key intValue] ==indexPath.row)
        {
            cellscore = [[self.scoreDict valueForKey:key] intValue];
            [self commentViewKeyBoradDown];
        }
    }
    
    [cell configWithModel:self.goodsArray[indexPath.row]];
    
    
    return cell;
}


- (void)commentViewKeyBoradDown
{
    [self.view endEditing:YES];
    [self.tableView endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self commentViewKeyBoradDown];
}

@end
