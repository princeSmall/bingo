//
//  OrderCommentsController.m
//  MovieIndustry
//
//  Created by baokuanxun on 16/4/19.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "OrderCommentsController.h"
#import "OrderGoodsModel.h"
#import "OrderTICommentCell.h"
#import "SysTool.h"



@interface OrderCommentsController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>
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
 *  订单id
 */
@property (nonatomic ,strong)NSString *order_id;

@property (nonatomic ,strong)NSString *imageName;

@property (nonatomic ,strong)UIImagePickerController *imagePicker;
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

@implementation OrderCommentsController

-(NSMutableDictionary *)commentTextDict
{
    if(!_commentTextDict)
    {
        _commentTextDict = [NSMutableDictionary dictionary];
    }
    return _commentTextDict ;
    
}
-(NSMutableDictionary *)scoreDict
{
    if(!_scoreDict)
    {
        _scoreDict = [NSMutableDictionary dictionary];
    }
    return _scoreDict;

}

-(NSMutableArray *)goods_idArray
{
    if(!_goods_idArray)
    {
        _goods_idArray = [NSMutableArray array];
    }
    return _goods_idArray;
}

-(NSMutableArray *)goodsArray
{
    if(!_goodsArray)
    {
        _goodsArray = [NSMutableArray array];
    }
    return _goodsArray;
}

-(NSMutableDictionary *)picDict
{

    if(!_picDict)
    {
        _picDict = [NSMutableDictionary dictionary];
    }
    return _picDict;
}

-(NSMutableDictionary *)commentDict
{
    if(!_commentDict)
    {
        _commentDict = [NSMutableDictionary dictionary];
    }
    return _commentDict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTabBar:@"评价"];
    [self createTableView];
    [self processData];
    
}
/**
 *  处理数据
 */
-(void)processData
{
    NSDictionary *shopDict = [NSDictionary dictionaryWithDictionary:self.orderModel.order_shops[0]];
    for(NSDictionary  *goodsDict in shopDict[@"shop_goods"])
    {
        OrderGoodsModel *goodsModel = [[OrderGoodsModel alloc]initWithDict:goodsDict];
        [self.goodsArray addObject:goodsModel];
        [self.goods_idArray addObject:goodsModel.goods_id];
    }
    
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
    [self createFooterView];
    
    
}

/**
 *  创建footerView
 */
-(void)createFooterView
{
    self.tableView.tableFooterView.frame = CGRectMake(0, 0, kViewWidth, 100);
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, 100)];
    footerView.backgroundColor = [UIColor colorWithRed:0.910 green:0.918 blue:0.922 alpha:1.000];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, kViewWidth-20, 50)];
    [footerView addSubview:button];
    [button setTitle:@"发表评价" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.layer.cornerRadius = 4;
    button.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = footerView;
    [button addTarget:self action:@selector(actionComment:) forControlEvents:UIControlEventTouchUpInside];
}
/**
 *  发表评论动作
 *
 *  @param btn 按钮对象
 */
-(void)actionComment:(UIButton *)btn
{
    if([self checkInfo]==YES)
    {
        HHNSLog( @"success");
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"user_id"] = APP_DELEGATE.user_id;
        param[@"order_id"] = self.order_id;
        param[@"goods_id"] = self.goods_idArray ;
        param[@"content"] = [self sortWithDict:self.commentTextDict];
        param[@"score"] = [self sortWithDict:self.scoreDict];
        param[@"pics"] = [self sortWithDict:self.commentDict];
        HHNSLog(@"评论：%@",param);
        
        [HttpRequestServers requestBaseUrl:TIOrder_Evaluate withParams:param withRequestFinishBlock:^(id result) {
            NSDictionary *dict =result;
            HHNSLog(@"%@",dict);
            if([dict[@"code"] intValue ]==0)
            {
                [hud hide: YES];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                hud.labelText = @"评论失败";
                [hud hide:YES afterDelay:0.5];
            }
        } withFieldBlock:^{
            
        }];
        
    }
}
/**
 *  将词典排序转成数组
 *
 *  @param dict 词典
 *
 *  @return 排序后的数组
 */
-(NSMutableArray *)sortWithDict:(NSMutableDictionary *)dict
{

    NSMutableArray *numArray = [NSMutableArray arrayWithArray:dict.allKeys];
    [numArray sortUsingComparator: ^NSComparisonResult (NSString *str1, NSString *str2) {
        NSNumber *number1 = [NSNumber numberWithInteger:str1.floatValue];
        NSNumber *number2 = [NSNumber numberWithInteger:str2.floatValue];
        return [number1 compare:number2];
    }];
    NSMutableArray *newArray = [NSMutableArray array];
    for(int i=0;i<[dict count];i++)
    {
        [newArray addObject:[dict valueForKey:[NSString stringWithFormat:@"%@",[numArray objectAtIndex:i]]]];
    }
    return newArray;

}


/**
 *  检查评论的内容是否完整
 *
 *  @return yes 是 no 否
 */
-(BOOL)checkInfo
{
    if([self.commentDict count] != self.goodsArray.count)
    {
        
        for (int i=0;i<self.goodsArray.count;i++)
        {
            NSString *str = [self.commentDict valueForKey:[NSString stringWithFormat:@"%d",i]];
            if(str ==nil)
            {
                [self.commentDict setValue:@"" forKey:[NSString stringWithFormat:@"%d",i]];
            }
        }
    }
    
    if([self.commentTextDict count] !=self.goodsArray.count)
    {
        for (int i=0;i<self.goodsArray.count;i++)
        {
            NSString *str = [self.commentTextDict valueForKey:[NSString stringWithFormat:@"%d",i]];
            if(str ==nil)
            {
                [self.commentTextDict setValue:@"" forKey:[NSString stringWithFormat:@"%d",i]];
            }
        }

    }
    if([self.scoreDict count] !=self.goodsArray.count)
    {
        [DeliveryUtility showMessage:@"请对商品打分" target:self];
        return NO;
    }
    return YES;
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
    [cell.photoBtn addTarget:self action:@selector(takeCommentPictureAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.goodsDesripeTField.tag = 600+indexPath.row;
    cell.goodsDesripeTField.delegate =self;
    self.order_id = goodsModel.order_id;
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
    
    [cell config:goodsModel image:image text:str score:cellscore];
    
    
    return cell;
}


- (void)commentViewKeyBoradDown
{
    [self.view endEditing:YES];
    [self.tableView endEditing:YES];
}

#pragma mark - 选取评论照片
- (void)takeCommentPictureAction:(UIButton *)button
{
    NSInteger row = button.tag -500;
    self.indexpath = [NSIndexPath indexPathForRow:row inSection:0];
    [self commentViewKeyBoradDown];
    self.imageName = [self.picDict valueForKey:[NSString stringWithFormat:@"%ld",row]];
    
    if (self.imageName) {
        UIActionSheet *sheetView = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择",@"删除", nil];
        [sheetView showInView:self.view];

    }else{
        UIActionSheet *sheetView = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
        [sheetView showInView:self.view];
    }
}


#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self takeCommentImageFromCamera];
            break;
        case 1:
            [self takeCommentImageFromAlbum];
            break;
        case 2:{
            self.imageName = nil;
            
        }
        default:
            break;
    }
}

#pragma mark - 拍照获取图片
- (void)takeCommentImageFromCamera
{
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.sourceType = sourceType;
        self.imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        self.imagePicker.allowsEditing = NO;
        
        [self.imagePicker.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
        if (isiOS8) {
            
            self.modalPresentationStyle = UIModalPresentationCurrentContext;
            //            self.imagePicker.modalPresentationStyle = UIModalPresentationCurrentContext;
        }
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }
    else
    {
        [DeliveryUtility showMessage:@"该设备不支持拍照功能" target:self];
    }
}

#pragma mark - 从相册获取图片
- (void)takeCommentImageFromAlbum
{
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    self.imagePicker.allowsEditing = NO;
    
    [self.imagePicker.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
    [self presentViewController:_imagePicker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"取消相册选择");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 上传图片
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        
        //如果选择的类型是图片
        if ([type isEqualToString:@"public.image"])
        {
            UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            //上传图片
            OrderTICommentCell *cell = [self.tableView cellForRowAtIndexPath:self.indexpath];
            [self uploadChooseImageWith:image cell:cell];
        }
    }
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        //如果选择的类型是图片
        if ([type isEqualToString:@"public.image"])
        {
            UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            
            //上传图片
            OrderTICommentCell *cell = [self.tableView cellForRowAtIndexPath:self.indexpath];
            [self uploadChooseImageWith:image cell:cell];

        }
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)uploadChooseImageWith:(UIImage *)originImage
                         cell:(OrderTICommentCell *)cell
{
    NSLog(@"%f___%f",originImage.size.width,originImage.size.height);
    CGFloat i = originImage.size.width/400;
    UIImage *postImage = [DeliveryUtility imageWithImageSimple:originImage scaledToSize:CGSizeMake(originImage.size.width/i, originImage.size.height/i)];
    NSData * imageData = UIImagePNGRepresentation(postImage);
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"添加图片中";
    [HUD show:YES];
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[@"device"] = @"0";
    parameters[@"stream"] = imageData;
    parameters[@"flag"] = @"1";
    [HttpRequestServers requestBaseUrl:TICommon_Uploadify withParams:parameters withRequestFinishBlock:^(id result) {
        HUD.labelText = @"图片上传成功！";
        [HUD hide:YES];
        NSDictionary * dict = result[@"data"];
        self.imageName = dict[@"img"];
        //显示图片
        [cell.photoBtn setImage:originImage forState:UIControlStateNormal];

        //将图片对象存入词典
        [self.picDict setValue:originImage forKey:[NSString stringWithFormat:@"%ld",(long)self.indexpath.row]];
        
        //将返回的图片名存入词典
        [self.commentDict setValue:dict[@"img"] forKey:[NSString stringWithFormat:@"%ld",(long)self.indexpath.row]];
        
        
        [HUD hide:YES afterDelay:1.25];
    } withFieldBlock:^{
        HUD.labelText = @"图片上传失败！";
        [HUD hide:YES];
    }];
}


- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger row = textView.tag-600;
    [self.commentTextDict setValue:textView.text forKey:[NSString stringWithFormat:@"%ld",(long)row]];

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
