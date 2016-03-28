//
//  MovieCommentViewController.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/18.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieCommentViewController.h"
#import "MovieCommentFirstCell.h"
#import "MovieCommentSecondCell.h"
#import "MovieCommentThirdCell.h"
#import "OrderShopModel.h"

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
    
    if ([self.point_type isEqualToString:@""]) {
//        [PromptLabel custemAlertPromAddView:self.view text:@"你还没选择评价哦"];
    }else
    {
      if ([self.commentStr isEqualToString:@""])
        {
//            [PromptLabel custemAlertPromAddView:self.view text:@"请输入评价内容"];
        }else
        {
            if ([self.points isEqualToString:@"0"]) {
//                [PromptLabel custemAlertPromAddView:self.view text:@"请选择星级"];
            }else
            {
                
                MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                HUD.labelText = @"正在提交";
                [HUD show:YES];
                
                //分割字符串
                NSString *images = [self.imagePathArray componentsJoinedByString:@","];
                
                NSString *goodsIDS = @"";
                for (MyOrderGoodsModel *model in self.goodsModelArray) {
                    if ([goodsIDS isEqualToString:@""]) {
                        goodsIDS = model.commentID;
                    }else
                    {
                        goodsIDS = [NSString stringWithFormat:@"%@,%@",goodsIDS,model.commentID];
                    }
                }
                
                NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
                HHNSLog(@"%@",userDict);
                
                
                [HttpRequestServers requestBaseUrl:Shop_message_add withParams:userDict withRequestFinishBlock:^(id result) {
                    HHNSLog(@"%@",result);
                    NSDictionary *dict = result;
                    @try {
                        if ([dict[@"status"] isEqualToString:Status_Success]) {
                            HUD.labelText = @"评论成功";
                            [HUD hide:YES];
                            //返回
                            [self.navigationController popToRootViewControllerAnimated:YES];
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
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goodsModelArray.count+2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row <self.goodsModelArray.count) {
        MovieCommentFirstCell *firstCell = [[[NSBundle mainBundle] loadNibNamed:@"MovieCommentFirstCell" owner:self options:nil] lastObject];
        firstCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        MyOrderGoodsModel *model = self.goodsModelArray[indexPath.row];
        [firstCell config:model];
        
        return firstCell;
    }else if (indexPath.row == self.goodsModelArray.count){
        MovieCommentSecondCell *secondCell = [[[NSBundle mainBundle] loadNibNamed:@"MovieCommentSecondCell" owner:self options:nil] lastObject];
        
        [self setCommentBtnTagret:secondCell];
        
        secondCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return secondCell;
    }
    else if (indexPath.row == self.goodsModelArray.count+1){
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
    if (indexPath.row <self.goodsModelArray.count) {
        return 100;
    }else if (indexPath.row == self.goodsModelArray.count){
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
{
    if (self.selectedBtn) {
        NSLog(@"被选中按钮的 --> %zd",self.selectedBtn.tag);
        
        //判断是否已经选中评论等级,避免传照片时被刷新掉
        UIButton *chooseBtn = (UIButton *)[cell viewWithTag:self.selectedBtn.tag];
        chooseBtn.selected = YES;
    }
    
    cell.textView.delegate = self;
    cell.textView.text = self.commentStr;
    
    [cell.goodBtn1 addTarget:self action:@selector(changeGoodCommentEvalueStatue:) forControlEvents:UIControlEventTouchUpInside];
    [cell.goodBtn2 addTarget:self action:@selector(changeGoodCommentEvalueStatue:) forControlEvents:UIControlEventTouchUpInside];
    [cell.mediumBtn1 addTarget:self action:@selector(changeGoodCommentEvalueStatue:) forControlEvents:UIControlEventTouchUpInside];
    [cell.mediumBtn2 addTarget:self action:@selector(changeGoodCommentEvalueStatue:) forControlEvents:UIControlEventTouchUpInside];
    [cell.barelyBtn1 addTarget:self action:@selector(changeGoodCommentEvalueStatue:) forControlEvents:UIControlEventTouchUpInside];
    [cell.barelyBtn2 addTarget:self action:@selector(changeGoodCommentEvalueStatue:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.cameraBtn addTarget:self action:@selector(takeCommentPictureAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.imagePathArray.count == self.imageArray.count) {
        if (_imageArray.count) {
            
            @try {
                for (NSInteger i = 0;i <_imageArray.count;i++)
                {
                    UIView *pictureBgView = (UIView *)[cell viewWithTag:400+i];
                    pictureBgView.hidden = NO;
                    UIImageView *imageView = (UIImageView *)[pictureBgView viewWithTag:100];
//                    UIButton *delectBtn = (UIButton *)[pictureBgView viewWithTag:200];
//                    [delectBtn addTarget:self action:@selector(delecteCurrentChooeseImage:) forControlEvents:UIControlEventTouchUpInside];
                    imageView.image = _imageArray[i];
                }
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
            
            
        }
    }
    
}

//#pragma mark - 删除当前选中的图片
//- (void)delecteCurrentChooeseImage:(UIButton *)button
//{
//    UIView *buttonBgView = (UIView *)button.superview;
//    NSInteger index = buttonBgView.tag - 400;
//    
//    @try {
//        [self.imageArray removeObjectAtIndex:index];
//        [self.imagePathArray removeObjectAtIndex:index];
//    }
//    @catch (NSException *exception) {
//        
//    }
//    @finally {
//        
//    }
//    
//    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
//    [self.mainTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
//}


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
    [self commentViewKeyBoradDown];
    
    if (self.imageArray.count == 3) {
        [DeliveryUtility showMessage:@"亲,最多只能上传三张图片哦~" target:self];
        return;
    }
    
    UIActionSheet *sheetView = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    [sheetView showInView:self.view];
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
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"添加图片中";
    [HUD show:YES];
    
    [HttpRequestServers postImageRequest:Image_upload UIImage:postImage parameters:nil requestFinish:^(id result) {
        
        NSLog(@"上传图片成功 --> %@",result);
        
        NSDictionary *dict = (NSDictionary *)result;
        if ([dict[@"status"] isEqualToString:@"f99"]) {
            
            HUD.labelText = @"添加成功";
            NSString *imagePath = [DeliveryUtility nullString:dict[@"image_url"]];
            
            
            //上传成功之后添加
            [self.imagePathArray addObject:imagePath];
            [self.imageArray addObject:originImage];
            
            [self.mainTableView reloadData];
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
//            [self.mainTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
            
        }
        else
        {
            [DeliveryUtility showMessage:dict[@"msg"] target:self];
        }
        
        [HUD hide:YES afterDelay:0.25];
        
    } requestField:^{
        
        HUD.labelText = @"上传成功";
        [HUD hide:YES afterDelay:0.25];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
