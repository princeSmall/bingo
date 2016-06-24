//
//  PublishProductController.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/17.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "PublishProductController.h"
#import "MoviePictureCollectionCell.h"
#import "ChooseCityController.h"
#import "MovieDeliveryMethodModel.h"
#import "ShopSendClickView.h"
#import "JGButtonAreaView.h"
#import "JGAreaModel.h"
#import "JGSecondCoverView.h"
#import "PublishSecondCategoryController.h"
#import "AddPictureTableViewCell.h"
#import "JGAddPictureView.h"


#define IMAGE_START_TAG 300
#define BTN_START_TAG  200
#define VIEW_START_TAG  100

#define PLACE_HOLDER  @"请输入商品简介"

@interface PublishProductController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,ChooseCityControllerDelegate>

@property (nonatomic,strong) UIView *maskView;


/** 快递方式数据 */
@property (nonatomic,strong) NSArray *deliveryArray;
@property (nonatomic,strong) UIButton *selecteBtn;

/** 商品信息 */
@property (nonatomic,strong) NSMutableDictionary *goodsDict;

/** 送货方式模型 */
@property (nonatomic,strong) MovieDeliveryMethodModel *deliveryModel;

/** 送货方式选择视图*/
@property (nonatomic,strong) UIView *deliveryView;

/** 商品图片 */
@property (nonatomic,strong) NSMutableArray *imageArray;

/** 商品图片路径 */
@property (nonatomic,strong) NSMutableArray *imagePathArray;

@property (nonatomic,assign) NSInteger imageIndex;

@property (nonatomic,assign)BOOL isOpen;
@property (weak, nonatomic) IBOutlet UITableViewCell *myOpenCell;
@property (nonatomic,strong)ShopSendClickView * sendView;
#warning 押金金额 需要穿参数
@property (weak, nonatomic) IBOutlet UITextField *yajinCount;
@property (weak, nonatomic) IBOutlet UITextField *goodsCount;
@property (weak, nonatomic) IBOutlet UISwitch *jifendikou;

@property (nonatomic,strong)JGAddPictureView * addView;
@property (nonatomic,strong) JGSecondCoverView * secView;


@property (nonatomic,strong)NSMutableArray * imgArray;
@end

@implementation PublishProductController


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isOpen == YES) {
        if (indexPath.row == 9) {
            return 176;
        }else if(indexPath.row == 10){
            return 150;
        }else if(indexPath.row == 1){
            return 125;
        }else{
            return 44;
        }
    }else{
        if (indexPath.row == 10) {
            return 150;
        }else if (indexPath.row == 1){
            return 125;
        }else{
            return 44;
        }
    }
}



- (NSMutableArray *)imagePathArray
{
    if (nil == _imagePathArray) {
        _imagePathArray = [NSMutableArray array];
        [_imagePathArray addObject:@""];
        [_imagePathArray addObject:@""];
        [_imagePathArray addObject:@""];
        [_imagePathArray addObject:@""];
        [_imagePathArray addObject:@""];
    }
    return _imagePathArray;
}

- (NSMutableArray *)imageArray
{
    if (nil == _imageArray) {
        _imageArray = [NSMutableArray new];
    }
    return _imageArray;
}

- (NSMutableDictionary *)goodsDict
{
    if (nil == _goodsDict) {
        _goodsDict = [NSMutableDictionary new];
    }
    return _goodsDict;
}

- (NSArray *)deliveryArray
{
    if (nil == _deliveryArray) {
        _deliveryArray = [NSArray new];
    }
    
    return _deliveryArray;
}

/**
 *  点击发布的时候 ，第一步先上传图片
 */
- (void)UploadFile{

//    self.addView.imageArray
    
    if ([self checkIssueProductValid]) {
        [self.imagePathArray removeAllObjects];
        if (self.addView.imageArray.count == 0) {
            /**
             *  这边提示需要选择1-5张图片
             */
        }else{
            self.imgArray = [NSMutableArray arrayWithArray:self.addView.imageArray];
            [self uploadChooseImageWith:self.imgArray[0]];
            
        }
    }
}


- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length > 30) {
        textField.text = [textField.text substringToIndex:30];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    APP_DELEGATE.ShowViewController = self;
    _imagePathArray = nil;
    self.txtGoodName.delegate = self;
    self.imgArray = [NSMutableArray array];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.800 green:0.812 blue:0.816 alpha:0.5];
    
    
    self.addView = [[JGAddPictureView alloc]initWithFrame:CGRectMake(10, 35, APP_DELEGATE.window.frame.size.width, PictureWH) AndViewController:APP_DELEGATE.ShowViewController];
    [self.myView addSubview:self.addView];
    
    
    if(self.desModel){
    [self setNavTabBar:@"修改产品信息"];
        self.txtGoodName.text = self.desModel.goods_name;
        self.txtPrice.text = self.desModel.market_price;
        self.txtKamePrice.text = self.desModel.goods_price;
        self.goodsCount.text = self.desModel.goods_number;
        self.address.text = self.desModel.spare_address;
        self.typeLbl.text = self.desModel.category_name;
       [self.goodsDict setObject:self.desModel.goods_category_id forKey:@"goods_category_id"];
        if ([self.desModel.is_deposit isEqualToString:@"1"]) {
            self.depositSwBtn.on = YES;
        }else{
        
            self.depositSwBtn.on = NO;}
        
        self.imagePathArray = [NSMutableArray arrayWithArray:self.desModel.imgs];
        
        self.yajinCount.text = self.desModel.goods_deposit;
#warning 选择类型 没有做
#warning 选择类型没有做TUPIAN
        
        switch ([self.desModel.goods_express intValue]) {
            case 0:
                self.deliveryMethod.text = @"送货上门";
                self.sendView.button1.selected = YES;
                break;
            case 1:
                self.deliveryMethod.text = @"快递";
                self.sendView.button2.selected = YES;
                break;
            case 2:
                self.deliveryMethod.text = @"自提";
                self.sendView.button3.selected = YES;
                break;
                
            default:
                break;
        }
        self.textViewDetail.text = self.desModel.goods_desc;

        for (NSString * str in self.desModel.imgs) {
            NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,str]];
            UIImage *image =[UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
            if (image) {
                [self.imageArray addObject:image];
            }
        }
        self.addView.imageArray = [NSMutableArray arrayWithArray:self.imageArray];
       [self.imageArray addObject:[UIImage imageNamed:@"addPicture"]];
        [self.addView ViewWithPictures:self.imageArray];
        
    }else
    {
        [self setNavTabBar:@"产品发布"];
        for (int i = 0; i < 5; i ++) {
            UIImage * image = [UIImage imageNamed:@"addPicture"];
            [self.imageArray addObject:image];
        }
    }
    [self initIssueProductView];
    [self addWordInputeObservers];

    self.isOpen = YES;
    
    
    ShopSendClickView * viewSend = [[ShopSendClickView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 132) AndClickBlock:^(NSString *possType) {
        self.deliveryMethod.text = possType;
    }];
    [self.myOpenCell.contentView addSubview:viewSend];
    self.sendView = viewSend;
    self.sendView.hidden = YES;
    self.isOpen = NO;
    self.depositSwBtn.on = NO;
    self.depositSwBtn.userInteractionEnabled = NO;
    [self chooseWhetherNeeddeposit:nil];
}

- (void)initIssueProductView
{
    if (!self.desModel) {
        self.textViewDetail.text = PLACE_HOLDER;
    }
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    //创建尾部视图确认按钮
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,kViewWidth, 100)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *comfirmBtn;
    
    if (!self.desModel) {
        comfirmBtn = [DeliveryUtility createBtnFrame:CGRectMake(20, 20, kViewWidth-40, 40) title:@"发布" andFont:DefaultFont target:self action:@selector(UploadFile)];
        
    }else{
       comfirmBtn = [DeliveryUtility createBtnFrame:CGRectMake(20, 20, kViewWidth-40, 40) title:@"修改" andFont:DefaultFont target:self action:@selector(UploadFile)];
    
    
    }

    [comfirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    comfirmBtn.backgroundColor=[UIColor whiteColor];
    comfirmBtn.clipsToBounds = YES;
    comfirmBtn.layer.cornerRadius = 8;
    [footerView addSubview:comfirmBtn];
    UILabel *ladelNotice = [[UILabel alloc]initWithFrame:CGRectMake(8, CGRectGetMaxY(comfirmBtn.frame), kViewWidth-16, 30)];
  ladelNotice.textColor = [UIColor colorWithRed:0.227 green:0.231 blue:0.235 alpha:1.000];
    ladelNotice.text = @"设置商品详情，请至";
    ladelNotice.font = [UIFont systemFontOfSize:16];
    ladelNotice.textAlignment = NSTextAlignmentCenter;
//    [footerView addSubview:ladelNotice];
    
    self.tableView.tableFooterView = footerView;

    //创建maskView
    self.maskView = [WNController createViewFrame:CGRectMake(0, 0, kViewWidth, kViewHeight+20)];
    self.maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeMaskViewAction)];
    [self.maskView addGestureRecognizer:tapGes];
    
    
    //注册UICollectionViewCell
    CGFloat itemW = (kViewWidth-20)/5;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize=CGSizeMake(itemW,itemW);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.collectionViewLayout = flowLayout;
    
    UINib *nib = [UINib nibWithNibName:@"MoviePictureCollectionCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"pictureCellID"];
}

#pragma mark - 请求快递运送方式数据
- (void)initIssueProductDatas
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在加载";
    [HUD show:YES];
    
    [MovieHttpRequest createRequestDeliveyWayCallBack:^(id obj) {
        
        HUD.labelText = @"加载完成";
        [HUD hide:YES];
        
        self.deliveryArray = [NSArray arrayWithArray:obj];
        if (_deliveryArray.count)
        {
            [self createDeliveryMethodView];
            
            self.deliveryModel = [self.deliveryArray firstObject];
            self.deliveryMethod.text = self.deliveryModel.name;
        }
        else{
            self.deliveryMethod.text = @"暂无收货方式选项";
        }
        
    } andSCallBack:^(id obj) {
       
        [HUD hide:YES];
        [DeliveryUtility showMessage:obj target:self];
    }];
}


#pragma mark
- (void)issueProductComfimrAction:(id)sender
{
    NSLog(@"所有产品图片 --> %zd",self.imageArray.count);
  if ([self checkIssueProductValid]) {
    
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"正在发布";
        [HUD show:YES];
      self.goodsDict[@"type"] = @"0";
    [HttpRequestServers requestBaseUrl:TIPublish_Something withParams:self.goodsDict withRequestFinishBlock:^(id result) {
        NSLog(@"%@",result);
        HUD.labelText = @"发布信息成功";
    [self performSelector:@selector(publishProductGoBack) withObject:nil afterDelay:0.25];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } withFieldBlock:^{
                   HUD.labelText = @"发布信息失败";
  [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
   }
}

- (void)issueProductComfimrActionChange:(UIButton *)sender{

    if ([self checkIssueProductValid]) {
        
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"正在修改";
        [HUD show:YES];
        self.goodsDict[@"goods_id"] = self.desModel.goods_id;
        [HttpRequestServers requestBaseUrl:TIPublish_UpdateSomething withParams:self.goodsDict withRequestFinishBlock:^(id result) {
            NSLog(@"%@",result);
            HUD.labelText = @"修改信息成功";
            [self performSelector:@selector(publishProductGoBack) withObject:nil afterDelay:1.0];
            [HUD hide:YES afterDelay:1.0];
        } withFieldBlock:^{
            HUD.labelText = @"修改信息失败";
            [HUD hide:YES];
        }];
        
    }

    


}




- (void)publishProductGoBack
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"修改信息成功" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)checkIssueProductValid
{
    
    NSString *goodsName = [self.txtGoodName.text asTrim];
    NSString *originPrice = [self.txtPrice.text asTrim];
    NSString *kamePrice = [self.txtKamePrice.text asTrim];
    NSString *address = [self.address.text asTrim];
    NSMutableString *deliveryId = [NSMutableString string];
    //0:商家 1:快递  2:自提
    NSArray * arrayType = [self.deliveryMethod.text componentsSeparatedByString:@","];
    for (int i = 0; i < arrayType.count; i ++) {
        if ([arrayType[i] isEqualToString:@"送货上门"]) {
            [deliveryId appendString:@"0,"];
        }else if([arrayType[i] isEqualToString:@"快递"]){
            [deliveryId appendString:@"1,"];
        }else if([arrayType[i] isEqualToString:@"自提"]){
           [deliveryId appendString:@"2,"];
        }
    }
    NSLog(@"%@",deliveryId);
    
    
    if ([self.deliveryMethod.text isEqualToString:@"送货上门"]) {
        deliveryId = @"0";
    }else if([self.deliveryMethod.text isEqualToString:@"快递"]){
    deliveryId = @"1";
    }else if([self.deliveryMethod.text isEqualToString:@"自提"]){
    deliveryId = @"2";
    }
    
    NSString *isDeposit = [NSString stringWithFormat:@"%zd",self.depositSwBtn.on];
    
    //判断商品详情
    NSString *description = [self.textViewDetail.text asTrim];
    if ([description isEqualToString:PLACE_HOLDER] || [description isEqualToString:@""]) {
        description = @"";
    }
    
    //判断商品名称
    if (0 == goodsName.length) {
        [DeliveryUtility showMessage:@"请输入商品名称" target:self];
        return NO;
    }else if([DeliveryUtility isNotLegal:goodsName]){
        [DeliveryUtility showMessage:@"商品名不能包含特殊字符" target:self];
        return NO;
    }else if(goodsName.length >30){
        [DeliveryUtility showMessage:@"商品名字数超过30" target:self];
        return NO;
    }
    if(self.addView.imageArray.count < 1)
    {
        [DeliveryUtility showMessage:@"请上传1-5张图片" target:self];
        return NO;
    }
    if (0 == originPrice.length) {
        [DeliveryUtility showMessage:@"请输入商品价格" target:self];
        return NO;
    }
    

    //判断现价
    if (0 == kamePrice.length) {
        [DeliveryUtility showMessage:@"请输入商品咖么价" target:self];
        return NO;
    }
    
    
    if (self.goodsCount.text.length == 0) {
    [DeliveryUtility showMessage:@"请输入商品数量" target:self];
        return NO;
    }

    //判断商品描述信息
    if (0 == description.length) {
        [DeliveryUtility showMessage:@"请输入对商品的描述信息" target:self];
        return NO;
    }
    
    if ([self.deliveryMethod.text isEqualToString:@"点击选择送货方式"]) {
        [DeliveryUtility showMessage:@"请选择送货方式" target:self];
        return NO;
    }

    //判断地址
    if ([address isEqualToString:@"点击选择城市"] || 0 == address.length) {
        [DeliveryUtility showMessage:@"请点击选择地址" target:self];
        return NO;
    }
    //判断类型
    NSString *type =self.typeLbl.text;
    if(type.length==0)
    {
        [DeliveryUtility showMessage:@"请点击选择类型" target:self];
        return NO;
    }
    
    
    NSString *imagePath = [self.imagePathArray componentsJoinedByString:@","];
    
    [self.goodsDict setObject:APP_DELEGATE.user_id forKey:@"user_id"];
    [self.goodsDict setObject:goodsName forKey:@"goods_name"];
    [self.goodsDict setObject:originPrice forKey:@"market_price"];
    [self.goodsDict setObject:kamePrice forKey:@"goods_price"];
    [self.goodsDict setObject:self.goodsCount.text forKey:@"goods_number"];
    [self.goodsDict setObject:isDeposit forKey:@"is_deposit"];
    
    [self.goodsDict setObject:self.address.text forKey:@"people_location"];
    

        [self.goodsDict setObject:@"1" forKey:@"is_deduction"];
    
    
#warning 押金label的内容
    
    if (!self.yajinCount.text) {
        self.yajinCount.text = @"";
    }
    [self.goodsDict setObject:self.yajinCount.text forKey:@"goods_deposit"];
    [self.goodsDict setObject:description forKey:@"goods_desc"];
    [self.goodsDict setObject:deliveryId forKey:@"goods_express"];
    
//    [self.goodsDict setObject:self.desModel.goods_category_id forKey:@"goods_category_id"];
    [self.goodsDict setObject:imagePath forKey:@"imgs"];
    //goods_city_id
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    
    
    [self.goodsDict setObject:self.address.text forKey:@"goods_city_id"];
    [self.goodsDict setObject:self.address.text forKey:@"spare_address"];
     return YES;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self productIssueKeyboardDown];
    
    if (9 == indexPath.row) {
        self.isOpen = !self.isOpen;
        
        if (self.isOpen == NO) {
            self.sendView.hidden = YES;
        }else{
            self.sendView.hidden = NO;
        }
        
        [self.tableView reloadData];
    }
    else if (5 == indexPath.row)
    {
        ChooseCityController *chooseVC = [[ChooseCityController alloc] init];
        chooseVC.delegate = self;
        [self.navigationController pushViewController:chooseVC animated:YES];
#warning  点击选择城市列表
    }//选择类型
    else if (indexPath.row==8)
    {
        PublishSecondCategoryController *secondCategory = [[PublishSecondCategoryController alloc]init];
        secondCategory.type = @"1";
        //返回的回调
        __weak typeof(self)wself = self;
        secondCategory.backFn = ^(NSDictionary * dict){
            [wself.goodsDict setObject:dict[@"category_id"] forKey:@"goods_category_id"];  ;
            wself.typeLbl.text = dict[@"category_name"];
           wself.typeLbl.textAlignment = NSTextAlignmentRight;
            
            
        };
        [self.navigationController pushViewController:secondCategory animated:YES];
        
    }
}

#pragma mark - 回收键盘
- (void)productIssueKeyboardDown
{
    [self.view endEditing:YES];
    [self.tableView endEditing:YES];
}


#pragma mark - 是否需要押金
- (IBAction)chooseWhetherNeeddeposit:(UISwitch *)switchBtn
{
    if (switchBtn.on) {
        self.yajinCount.userInteractionEnabled = YES;
        self.yajinCount.text = @"";
    }
    else{
        self.yajinCount.text = @"0";
        self.yajinCount.userInteractionEnabled = NO;
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self takeShopImageFromCamera];
            break;
        case 1:
            [self takeShopImageFromAlbum];
            break;
        default:
            break;
    }
}

#pragma mark - 拍照获取图片
- (void)takeShopImageFromCamera
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.sourceType = sourceType;
        self.imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        self.imagePicker.allowsEditing = YES;
        
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
- (void)takeShopImageFromAlbum
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

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
       
        //如果选择的类型是图片
        if ([type isEqualToString:@"public.image"])
        {
            UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            
//            NSLog(@"已选图片 --> %zd",self.imageArray.count);
            [self uploadChooseImageWith:image];

    }
    }
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        //如果选择的类型是图片
        if ([type isEqualToString:@"public.image"])
        {
            UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
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
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    HUD.labelText = @"正在上传图片";
    [HUD show:YES];
    NSData * imageData = UIImagePNGRepresentation(postImage);
    [UserDesModel GetUploadImageDictWithData:imageData WithType:@"0" With:^(NSString *string) {
        if ([string isEqualToString:@"F"]) {
            HUD.labelText = @"添加失败";
            [HUD hide:YES afterDelay:1.5];
        }else{
            [self.imgArray removeObjectAtIndex:0];
            [self.imagePathArray addObject:string];
            if (self.imgArray.count > 0)
            {
                [self uploadChooseImageWith:self.imgArray[0]];
            }else{
                [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
                 
                if (self.desModel) {
                    [self issueProductComfimrActionChange:nil];
                }else{
                 [self issueProductComfimrAction:nil];
                }
            }
        }
    }];
}


#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([PLACE_HOLDER isEqualToString:[textView.text asTrim]])
    {
        textView.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([@"" isEqualToString:[textView.text asTrim]])
    {
        textView.text = PLACE_HOLDER;
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = _imageArray.count;
    return (5 == count)?count:count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
     MoviePictureCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pictureCellID" forIndexPath:indexPath];
    
    cell.delectBtn.tag = 600+indexPath.item;
    [cell.delectBtn addTarget:self action:@selector(delectChooseImageBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.delectBtn.hidden = YES;
    
    NSInteger imageCount = self.imageArray.count;
    
    if ((0 == imageCount && 0 == indexPath.item) || (0 != imageCount && imageCount == indexPath.item))
    {
        cell.pcImage.image = [UIImage imageNamed:@"addPicture"];
        cell.delectBtn.hidden = YES;
        
    }
    else
    {
        cell.pcImage.image = _imageArray[indexPath.item];
        [cell.pcImage sizeThatFits:cell.pcImage.frame.size];
//        cell.delectBtn.hidden = NO;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self productIssueKeyboardDown];
    
    self.imageIndex = indexPath.item;
    
    UIActionSheet *sheetView = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    [sheetView showInView:self.view];
}

- (void)delectChooseImageBtnClicked:(UIButton *)button
{
    NSInteger index = button.tag - 600;
    [self.imageArray removeObjectAtIndex:index];
    [self.imagePathArray removeObjectAtIndex:index];
    [self.collectionView reloadData];
}



#pragma mark - 创建快递方式选择视图
- (void)createDeliveryMethodView
{
    CGFloat viewH = 45.0f;
    NSInteger count = _deliveryArray.count;
    
    self.deliveryView = [[UIView alloc] initWithFrame:CGRectMake(0,screenHeight,screenWidth,viewH*(count+1))];
    
    for (int i = 0; i < count; i++) {
        
        CGRect frame = CGRectMake(0,viewH*(i+1),screenWidth, viewH);
        UIView *chooseView = [[UIView alloc] initWithFrame:frame];
        chooseView.userInteractionEnabled = YES;
        chooseView.tag = VIEW_START_TAG + i;
        chooseView.backgroundColor = [UIColor whiteColor];
        
        MovieDeliveryMethodModel *model = _deliveryArray[i];
        
        UILabel *label = [DeliveryUtility createLabelFrame:CGRectMake(10, 13, 100, 21) title:model.name textAlignment:0];
        label.font = [UIFont systemFontOfSize:15.0f];
        [chooseView addSubview:label];
        
        UIButton *button = [DeliveryUtility createBtnFrame:CGRectMake(kViewWidth-30, 7, 20, 20) image:@"tick_off" selectedImage:@"tick_on" target:self action:nil];
        button.tag = BTN_START_TAG;
        button.userInteractionEnabled = NO;
        [chooseView addSubview:button];
        
        if (0 == i) {
            button.selected = YES;
            self.selecteBtn = button;
        }
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,viewH-1, kViewWidth, 1)];
        line.backgroundColor = RGBColor(212, 212, 212, 0.47);
        [chooseView addSubview:line];
        
        UITapGestureRecognizer *chooseTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseDeliveryMethodAction:)];
        [chooseView addGestureRecognizer:chooseTap];
        
        [self.deliveryView addSubview:chooseView];
    }
    
    
    //完成按钮
    UIView *doneView = [WNController createImageViewWithFrame:CGRectMake(0,0, kViewWidth,viewH) ImageName:nil];
    doneView.backgroundColor = [UIColor whiteColor];
    
    UIButton *doneBtn = [DeliveryUtility createBtnFrame:CGRectMake(kViewWidth-60,7,60,30) title:@"完成" andFont:DefaultFont target:self action:@selector(finishChooseDeliveryWay)];
    [doneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [doneView addSubview:doneBtn];
    
    [self.deliveryView addSubview:doneView];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self.deliveryView];
}

/** 点击选择快递方式 */
- (void)chooseDeliveryMethodAction:(UITapGestureRecognizer *)ges
{
    UIView *superView = ges.view;
    UIButton *button = (UIButton *)[superView viewWithTag:BTN_START_TAG];
    
    self.selecteBtn.selected = NO;
    button.selected = YES;
    self.selecteBtn = button;
}

/** 移除遮罩 */
- (void)removeMaskViewAction
{
    [self.maskView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = self.deliveryView.frame;
        frame.origin.y += frame.size.height;
        self.deliveryView.frame = frame;
    }];
}

/** 完成选择快递运送方式 */
- (void)finishChooseDeliveryWay
{
    [self removeMaskViewAction];
    NSInteger index = (self.selecteBtn.superview.tag - VIEW_START_TAG);
    MovieDeliveryMethodModel *model = _deliveryArray[index];
    self.deliveryMethod.text = model.name;
}

#pragma mark - 城市选择代理方法
-(void)cityName:(NSString *)CityName andCityId:(NSString *)cityId
{
    self.address.text = CityName;
    [self.goodsDict setObject:cityId forKey:@"city_id"];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.txtGoodName) {
        [self.txtGoodName resignFirstResponder];
        [self.txtPrice becomeFirstResponder];
    }
    else if (textField == self.txtPrice)
    {
        [self.txtPrice resignFirstResponder];
        [self.txtKamePrice becomeFirstResponder];
    }
    else if (textField == self.txtKamePrice)
    {
        [self.txtKamePrice resignFirstResponder];
    }
    
    return YES;
}

#pragma mark - 添加监听文本输入框输入字数
- (void)addWordInputeObservers
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(publishProductTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtGoodName];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(publishProductTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtPrice];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(publishProductTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtKamePrice];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(publishProductTextViewEditChanged:) name:@"UITextViewTextDidChangeNotification" object:self.textViewDetail];
}


- (void)publishProductTextFiledEditChanged:(NSNotification *)noti
{
    NSInteger kMaxLength = 0;
    
    UITextField *textField = (UITextField *)noti.object;
    if (textField == self.txtGoodName) {
        //特点 摄影者001
        kMaxLength = 100;
    }
    else{
        //价格
        kMaxLength = 6;
    }
    
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > kMaxLength) {
            textField.text = [toBeString substringToIndex:kMaxLength];
        }
    }
}

- (void)publishProductTextViewEditChanged:(NSNotification *)noti
{
    NSInteger kMaxLength = 150;
    
    UITextView *textView = (UITextView *)noti.object;
    
    NSString *toBeString = textView.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kMaxLength) {
                textView.text = [toBeString substringToIndex:kMaxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > kMaxLength) {
            textView.text = [toBeString substringToIndex:kMaxLength];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
