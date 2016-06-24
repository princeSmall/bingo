//
//  MovieCommentViewController.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/18.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieCommentViewController.h"
#import "MovieCommentFirstCell.h"
#import "MovieCommentSecondCell.h"
#import "MovieCommentThirdCell.h"
#import "OrderShopModel.h"
#import "PlaceholderTextView.h"


@interface MovieCommentViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>

@property (nonatomic,retain)UITableView *mainTableView;
@property (nonatomic,strong) UIImagePickerController *imagePicker;

@property (nonatomic,retain) UIButton *selectedBtn;
//选中的图片数组
@property (nonatomic,retain) NSMutableArray *imageArray;
//评论内容
@property (nonatomic,copy) NSString *commentStr;
//评分
@property (nonatomic,copy) NSString *points;
//评分类型，1/2/3 好/中/差
@property (nonatomic,copy) NSString *point_type;
//图片字符串数组
@property (nonatomic,strong) NSMutableArray *imagePathArray;

@property (nonatomic,strong)PlaceholderTextView * textView;
@property (nonatomic,strong)UIButton * buttonPhoto;

@property (nonatomic,strong)NSString * imageName;

@end

@implementation MovieCommentViewController

- (NSMutableArray *)imagePathArray
{
    if (!_imagePathArray) {
        _imagePathArray = [NSMutableArray array];
    }
    return _imagePathArray;
}

- (NSMutableArray *)imageArray
{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray new];
    }
    return _imageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.commentStr = @"";
    self.point_type = @"";
    self.points =@"0";
    self.imageArray = [NSMutableArray array];
    [self setNavTabBar:@"评价"];
    
    

    
    [self createCommentView];
}

- (void)createCommentView
{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight-44) style:UITableViewStylePlain];
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    self.mainTableView.backgroundColor = kViewBackColor;
    
    //确定按钮
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0,10, kViewWidth, 80)];
    footerView.backgroundColor=[UIColor clearColor];
    UIButton *comfirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    comfirmBtn.frame = CGRectMake(20,20,kViewWidth-40, 40);
    comfirmBtn.backgroundColor=[UIColor whiteColor];
    [comfirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [comfirmBtn setTitle:@"发表评论" forState:UIControlStateNormal];
    comfirmBtn.clipsToBounds = YES;
    comfirmBtn.layer.cornerRadius = 5;
    [comfirmBtn addTarget:self action:@selector(comfirmCommitCommentContent:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:comfirmBtn];
    
    self.mainTableView.tableFooterView = footerView;
    [self.view addSubview:self.mainTableView];
    
//    UIColor *bgColor = RGBColor(234,234, 234,1);
//    self.view.backgroundColor = bgColor;
    self.mainTableView.backgroundColor = kViewBackColor;
    
    self.mainTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

- (void)commentViewKeyBoradDown
{
    [self.view endEditing:YES];
    [self.mainTableView endEditing:YES];
}

#pragma mark - 确定提交评价
- (void)comfirmCommitCommentContent:(UIButton *)btn
{
    [self commentViewKeyBoradDown];
    NSLog(@"确定提交评价");

      if ([self.textView.text isEqualToString:@""])
        {
           [PromptLabel custemAlertPromAddView:self.view text:@"请输入评价内容"];
        }else
        {
            if ([self.points isEqualToString:@"0"]) {
                [PromptLabel custemAlertPromAddView:self.view text:@"请选择星级"];
            }else
            {
                if (!self.imageName) {
                    self.imageName = @"0000.jpg";
                }
                MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                HUD.labelText = @"正在提交";
                [HUD show:YES];
                //分割字符串
                    NSMutableArray * iamgeArray = [NSMutableArray array];
                    [iamgeArray addObject:self.imageName];
                NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
                    userDict[@"user_id"] = APP_DELEGATE.user_id;
                    userDict[@"order_id"] = self.goodsModel[@"order_id"];
                    userDict[@"content"] = self.textView.text;
                    userDict[@"pics"] = [NSString stringWithFormat:@"%@",[iamgeArray lastObject]];
                    userDict[@"goods_id"] = self.goodsModel[@"goods_id"];
                    userDict[@"score"] =self.points;
                [HttpRequestServers requestBaseUrl:TIOrder_Evaluate withParams:userDict withRequestFinishBlock:^(id result) {
                    HHNSLog(@"%@",result);
                    NSDictionary *dict = result;
                    @try {
                        if ([dict[@"code"] intValue] == 0) {
                            HUD.labelText = @"评论成功";
                            [HUD hide:YES];
                            //返回
                            [self.navigationController popViewControllerAnimated:YES];
                            
                            
                            @try {
                                
                                if (self.isList) {
                                    self.block(YES);
                                }
                            }
                            @catch (NSException *exception) {
                                
                            }
                            @finally {
                                
                            }
                            
                            
                        }else
                        {
                            HUD.labelText = dict[@"msg"];
                            [HUD hide:YES];
                        }
                        
                    }
                    @catch (NSException *exception) {
                        [HUD hide:YES];
                    }
                    @finally {
                        
                    }
                    
                    
                } withFieldBlock:^{
                    
                    HUD.labelText = kNetWork_ERROR;
                    [HUD hide:YES];
                }];
                
                
            }
        }
        
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        MovieCommentFirstCell *firstCell = [[[NSBundle mainBundle] loadNibNamed:@"MovieCommentFirstCell" owner:self options:nil] lastObject];
        firstCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [firstCell.goodImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIBIGImage,self.goodsModel[@"img_path"]]]];
        firstCell.goodName.text = self.goodsModel[@"goods_name"];
        firstCell.goodPrice.text = self.goodsModel[@"goods_price"];
        return firstCell;
    }else if (indexPath.row == 1){
        
        static NSString * cellID = @"cellID";
        
        MovieCommentSecondCell *secondCell = [[MovieCommentSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        [self setCommentBtnTagret:secondCell];
        secondCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return secondCell;
    }
    else if (indexPath.row == 2){
        MovieCommentThirdCell *thirdCell = [[[NSBundle mainBundle] loadNibNamed:@"MovieCommentThirdCell" owner:self options:nil] lastObject];
        [self setChooseStarRank:thirdCell];
        thirdCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return thirdCell;
    }
    
    
    return nil;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 100;
    }else if (indexPath.row == 1){
        return 260;
    }
    
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self commentViewKeyBoradDown];
}


#pragma mark -- ui
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
//    self.commentStr = [NSString stringWithFormat:@"%@%@",text.te]
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.commentStr = textView.text;
}


#pragma mark - 给cell添加点击事件
- (void)setCommentBtnTagret:(MovieCommentSecondCell *)cell
{   self.textView = cell.textView;
    self.buttonPhoto = cell.cameraBtn;
    [cell.cameraBtn addTarget:self action:@selector(takeCommentPictureAction:) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark -- 好评/中评/差评
- (void)changeGoodCommentEvalueStatue:(UIButton *)btn
{
    [self commentViewKeyBoradDown];
    
    UIButton *chooseBtn;
    if (btn.tag == 100 || btn.tag == 101) {
        chooseBtn = (UIButton *)[btn.superview viewWithTag:100];
        self.point_type = @"1";
    }else if (btn.tag == 200 || btn.tag == 201){
        chooseBtn = (UIButton *)[btn.superview viewWithTag:200];
        self.point_type = @"2";
    }else if (btn.tag == 300 || btn.tag == 301){
        chooseBtn = (UIButton *)[btn.superview viewWithTag:300];
        self.point_type = @"3";
    }
    
    self.selectedBtn.selected = NO;
    chooseBtn.selected = YES;
    self.selectedBtn = chooseBtn;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.mainTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
}


#pragma mark - 选择星星等级事件
- (void)setChooseStarRank:(MovieCommentThirdCell *)cell
{
    [cell.star1 addTarget:self action:@selector(changeStarRankSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.star2 addTarget:self action:@selector(changeStarRankSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.star3 addTarget:self action:@selector(changeStarRankSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.star4 addTarget:self action:@selector(changeStarRankSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.star5 addTarget:self action:@selector(changeStarRankSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)changeStarRankSelectedAction:(UIButton *)btn
{
    [self commentViewKeyBoradDown];
    
    btn.selected = !btn.selected;
    
    MovieCommentThirdCell *cell = (MovieCommentThirdCell *)btn.superview;
    NSInteger index = btn.tag;
    
    if (btn.selected) {
        
        for (UIView *subViews in cell.subviews) {
            
            BOOL isButton = [subViews isKindOfClass:[UIButton class]];
            if (isButton)
            {
                UIButton *starBtn = (UIButton *)subViews;
                if (subViews.tag <= index) {
                    
                    starBtn.selected = YES;
//                    self.starRating = [NSString stringWithFormat:@"%zd",(index+1)-100];
                    
                }else{
                    starBtn.selected = NO;
                }
            }
        }
    }
    else
    {
        for (UIView *subViews in cell.subviews) {
            
            BOOL isButton = [subViews isKindOfClass:[UIButton class]];
            if (isButton)
            {
                UIButton *starBtn = (UIButton *)subViews;
                if (subViews.tag >= index) {
                    
                    starBtn.selected = NO;
//                    self.starRating = [NSString stringWithFormat:@"%zd",(index-100)];
                    
                }else{
                    starBtn.selected = YES;
                }
            }
        }
    }
    
    
    //计算星星的数目
    NSInteger starCout = 0;
    for (UIView *subViews in cell.subviews) {
        
        BOOL isButton = [subViews isKindOfClass:[UIButton class]];
        if (isButton)
        {
            UIButton *starBtn = (UIButton *)subViews;
            if ([starBtn isSelected]) {
                starCout = starCout+1;
            }
        }
    }
    
    //星星字符串
    self.points = [NSString stringWithFormat:@"%ld",starCout];
    
}


#pragma mark - 选取评论照片
- (void)takeCommentPictureAction:(UIButton *)button
{
    
    
//    [self commentViewKeyBoradDown];
//    
//    
//    if (self.imageName) {
//        UIActionSheet *sheetView = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择",@"删除", nil];
//        [sheetView showInView:self.view];
//        
//        
//        
//        
//    }else{
//    UIActionSheet *sheetView = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
//    [sheetView showInView:self.view];
//    }
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
            [self.buttonPhoto setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [self.buttonPhoto setImage:[UIImage imageNamed:@"evaluation_camera"] forState:UIControlStateNormal];
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
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        
        //如果选择的类型是图片
        if ([type isEqualToString:@"public.image"])
        {
            UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            //上传图片
            [self uploadChooseImageWith:image];
        }
    }
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        //如果选择的类型是图片
        if ([type isEqualToString:@"public.image"])
        {
            UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            
            //上传图片
            [self uploadChooseImageWith:image];
        }
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)uploadChooseImageWith:(UIImage *)originImage
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
        [self.buttonPhoto setBackgroundImage:originImage forState:UIControlStateNormal];
        [self.buttonPhoto setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [HUD hide:YES afterDelay:1.25];
    } withFieldBlock:^{
        HUD.labelText = @"图片上传失败！";
        [HUD hide:YES];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
