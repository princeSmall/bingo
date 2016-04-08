//
//  SiteViewController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/17.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "SiteViewController.h"
#import "MoviePictureCollectionCell.h"
#import "ShopSendClickView.h"
#import "PublishSecondCategoryController.h"

#import "ChooseCityController.h"

#import "JGAddPictureView.h"


#define IMAGE_START_TAG 300
#define PLACE_HOLDER  @"场地描述"

@interface SiteViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,ChooseCityControllerDelegate>

@property (nonatomic,strong) UIImagePickerController *imagePicker;

@property (strong, nonatomic) IBOutlet UITextField *txtSiteName;//场地名称
@property (strong, nonatomic) IBOutlet UITextField *txtPhoneNum;//联系方式
@property (strong, nonatomic) IBOutlet UITextField *txtSiteArea;//面积
@property (strong, nonatomic) IBOutlet UITextField *txtPrice;//价格
@property (weak, nonatomic) IBOutlet UITextField *makPrice;//市场价

@property (weak, nonatomic) IBOutlet UITextField *goodsCount;
@property (weak, nonatomic) IBOutlet UISwitch *yajinSwitch;
@property (weak, nonatomic) IBOutlet UITextField *yajinCount;

@property (strong, nonatomic) IBOutlet UITextField *txtSpecial;//特点

@property (strong, nonatomic) IBOutlet UITextView *textViewDetail;//场地描述

/** 场地上传信息 */
@property (nonatomic,retain) NSMutableDictionary *siteDict;

/** 图片 image */
@property (nonatomic,strong) NSMutableArray *imageArray;
//积分抵扣选择
@property (weak, nonatomic) IBOutlet UISwitch *jifendikou;

/** 图片路径 imagePath */
@property (nonatomic,strong) NSMutableArray *imagePathArray;
@property (weak, nonatomic) IBOutlet UIView *myView;

@property (nonatomic,assign) NSInteger imageIndex;

@property (nonatomic,assign)BOOL isOpen;

@property (nonatomic,strong)JGAddPictureView * addView;
@property (nonatomic,strong)NSMutableArray * imgArray;

/**
 *  场地所在地
 请选择所在地
 */

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
/**
 *类型
 请选择类型
 */
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (nonatomic,strong)NSString * typeID;

@end

@implementation SiteViewController
/**
 *  产品所在地的按钮事件
 */
- (IBAction)addressBtnClick:(id)sender {
    
    ChooseCityController * choose = [[ChooseCityController alloc]init];
    choose.delegate = self;
    [self.navigationController pushViewController:choose animated:YES];
}

-(void)cityName:(NSString *)CityName andCityId:(NSString *)cityId{

    self.addressLabel.text = CityName;
}

/**
 *  类型按钮点击事件
 *
 */
- (IBAction)typeBtnClick:(id)sender {
    
    PublishSecondCategoryController * type = [[PublishSecondCategoryController alloc]init];
    type.type = @"3";
    type.backFn = ^(NSDictionary * dic){
        self.typeLabel.text = dic[@"category_name"];
        self.typeID = dic[@"category_id"];
    };
    [self.navigationController pushViewController:type animated:YES];
}

/**
 *  点击发布的时候 ，第一步先上传图片
 */
- (void)UploadFile{
    
    //    self.addView.imageArray
    
    if ([self checkPublishSiteInfoValid]) {
        [self.imagePathArray removeAllObjects];
        if (self.addView.imageArray.count == 0) {
            /**
             *  这边提示需要选择1-5张图片
             */
            [DeliveryUtility showMessage:@"请上传1-5张图片" target:self];
            
        }else{
            self.imgArray = [NSMutableArray arrayWithArray:self.addView.imageArray];
            [self uploadSiteChooseImageWith:self.imgArray[0]];
            
        }
    }
}



- (IBAction)yajinSitch:(id)sender {
    if (self.yajinSwitch.on) {
        self.yajinCount.userInteractionEnabled = YES;
        self.yajinCount.text = @"";
    }
    else{
        self.yajinCount.text = @"0";
        self.yajinCount.userInteractionEnabled = NO;
    }
}

- (NSMutableArray *)imagePathArray
{
    if (nil == _imagePathArray) {
        _imagePathArray = [NSMutableArray new];
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

- (NSMutableDictionary *)siteDict
{
    if (nil == _siteDict) {
        _siteDict = [NSMutableDictionary new];
    }
    return _siteDict;
}

- (void)TAP{
    [self.view endEditing:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    APP_DELEGATE.ShowViewController = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.800 green:0.812 blue:0.816 alpha:0.5];
    
    self.addView = [[JGAddPictureView alloc]initWithFrame:CGRectMake(10, 35, APP_DELEGATE.window.frame.size.width, PictureWH) AndViewController:APP_DELEGATE.ShowViewController];
    [self.myView addSubview:self.addView];
    
    UITapGestureRecognizer * TAP = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TAP)];
    [self.tableView addGestureRecognizer:TAP];
    self.imagePathArray = nil;
    if (self.desModel) {
        [self setNavTabBar:@"修改场地"];
        self.txtSiteName.text = self.desModel.goods_name;
        self.txtPrice.text = self.desModel.goods_price;
//        self.careerLab.text = self.desModel.goods_job;
        self.txtSiteArea.text = self.desModel.goods_area;
        self.txtPhoneNum.text = self.desModel.goods_mobile;
        self.goodsCount.text = self.desModel.goods_number;
        //        self.address.text = self.desModel.spare_address;
        self.txtSpecial.text = self.desModel.goods_alone;
        self.addressLabel.text = self.desModel.people_location;
        self.typeLabel.text = self.desModel.category_name;
        self.typeID = self.desModel.goods_category_id;
        self.makPrice.text = self.desModel.market_price;
//        @property (weak, nonatomic) IBOutlet UILabel *addressLabel;
//        /**
//         *类型
//         请选择类型
//         */
//        @property (weak, nonatomic) IBOutlet UILabel *typeLabel;
//        @property (nonatomic,strong)NSString * typeID;
        
        if ([self.desModel.is_deposit isEqualToString:@"1"]) {
            self.yajinSwitch.on = YES;
        }else{
            
            self.yajinSwitch.on = NO;}
        self.yajinCount.text = self.desModel.goods_deposit;
#warning 选择类型 没有做
#warning 选择类型没有做TUPIAN
        //        self.deliveryMethod.text = self.desModel.goods_express;
        
        if ([self.desModel.is_deduction isEqualToString:@"1"]) {
            self.jifendikou.on = YES;
        }else{
            self.jifendikou.on = NO;
        }
        self.textViewDetail.text = self.desModel.goods_desc;
        NSMutableArray * imgArray = [NSMutableArray array];
        for (int i= 0; i<self.desModel.imgs.count; i ++) {
            NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIBIGImage,self.desModel.imgs[i]]];
            UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
            [imgArray addObject:image];
        }
        self.addView.imageArray = [NSMutableArray arrayWithArray:imgArray];
        [imgArray addObject:[UIImage imageNamed:@"addPicture"]];
        [self.addView ViewWithPictures:imgArray];

    }else{
    [self setNavTabBar:@"发布场地"];
        for (int i = 0; i < 5; i ++) {
            UIImage * image = [UIImage imageNamed:@"addPicture"];
            [self.imageArray addObject:image];
        }
        
    }
    [self initIssueSiteView];
    [self addInputeWordNotification];
    

    
    
}
- (void)initIssueSiteView
{
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    //创建尾部视图确认按钮
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 80)];
    footerView.backgroundColor = [UIColor clearColor];
    UIButton *comfirmBtn;
    
    if (self.desModel) {
           comfirmBtn = [DeliveryUtility createBtnFrame:CGRectMake(20,20,kViewWidth-40,40) title:@"修改" andFont:DefaultFont target:self action:@selector(UploadFile)];
    }else{
    
        comfirmBtn = [DeliveryUtility createBtnFrame:CGRectMake(20,20,kViewWidth-40,40) title:@"发布" andFont:DefaultFont target:self action:@selector(UploadFile)];}
    [comfirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    comfirmBtn.backgroundColor = [UIColor whiteColor];
    comfirmBtn.clipsToBounds = YES;
    comfirmBtn.layer.cornerRadius = 8;
    [footerView addSubview:comfirmBtn];
    self.tableView.tableFooterView = footerView;
    
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

- (void)issueSiteViewKeyboardDown
{
    [self.view endEditing:YES];
    [self.tableView endEditing:YES];
}


#pragma mark - 监听文字输入
- (void)addInputeWordNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(publishSiteTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtSiteName];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(publishSiteTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtPhoneNum];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(publishSiteTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtSiteArea];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(publishSiteTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtPrice];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(publishSiteTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtSpecial];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(publishSiteTextViewEditChanged:) name:@"UITextViewTextDidChangeNotification" object:self.textViewDetail];
}

//监听UITextField
- (void)publishSiteTextFiledEditChanged:(NSNotification *)noti
{
    NSInteger kMaxLength = 0;
    
    UITextField *textField = (UITextField *)noti.object;
    if (textField == self.txtSpecial) {
        //特点
        kMaxLength = 30;
    }
    else if (textField == self.txtSiteName)
    {
        //场地名称
        kMaxLength = 20;
    }
    else if (textField == self.txtPhoneNum){
        //手机号
        kMaxLength = 11;
    }
    else {
        //面积,价格
        kMaxLength = 10;
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

//监听UITextView
- (void)publishSiteTextViewEditChanged:(NSNotification *)noti
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


- (void)issueSiteChangeAction:(UIButton *)sender{

    if ([self checkPublishSiteInfoValid]) {
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
        HUD.labelText = @"正在修改";
        [HUD show:YES];
        self.siteDict[@"type"] = @"2";
        self.siteDict[@"goods_id"] = self.desModel.goods_id;
        [HttpRequestServers requestBaseUrl:TIPublish_UpdatePlace withParams:self.siteDict withRequestFinishBlock:^(id result) {
            if ([result[@"code"] intValue] == 0) {
                HUD.labelText = @"修改成功";
                [HUD hide:YES];
                  [[NSNotificationCenter defaultCenter]postNotificationName:@"商品修改" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
              
            }
            HUD.labelText = @"修改失败";
            [HUD hide:YES];
        } withFieldBlock:^{
            HUD.labelText = @"修改失败";
            [HUD hide:YES];
        }];
        
    }
}


#pragma mark - 确定发布场地
- (void)issueSiteComfimrAction:(id)sender
{
    
    if ([self checkPublishSiteInfoValid]) {
        
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
        HUD.labelText = @"正在发布";
        [HUD show:YES];
        
       self.siteDict[@"type"] = @"2";
                [MovieHttpRequest createPublishMineSiteWith:self.siteDict CallBack:^(id obj) {
            
            HUD.labelText = @"发布成功";
            [HUD hide:YES];
            
            [self performSelector:@selector(goBack) withObject:self afterDelay:0.25];
            
        } andSCallBack:^(id obj) {
            
            [HUD hide:YES];
            [DeliveryUtility showMessage:obj target:self];
        }];
    }
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)checkPublishSiteInfoValid
{
    NSString *siteName = [self.txtSiteName.text asTrim];
    NSString *phoneNum = [self.txtPhoneNum.text asTrim];
    NSString *area = [self.txtSiteArea.text asTrim];
    NSString *price = [self.txtPrice.text asTrim];
    NSString *feature = [self.txtSpecial.text asTrim];
    NSString *description = [self.textViewDetail.text asTrim];
    
    //判断场地名称
    if ([siteName isEqualToString:@""]) {
        [DeliveryUtility showMessage:@"请填写场地名称" target:self];
        return NO;
    }
    else if ([DeliveryUtility isNotLegal:siteName]){
        [DeliveryUtility showMessage:@"场地名称不可包含非法字符" target:self];
        return NO;
    }
    
    //判断联系方式
    if ([phoneNum isEqualToString:@""]) {
        [DeliveryUtility showMessage:@"请填写联系方式" target:self];
        return NO;
    }
    else if (![DeliveryUtility isPureInt:phoneNum])
    {
        [DeliveryUtility showMessage:@"请填写正确的手机号码" target:self];
        return NO;
    }
    else if ([DeliveryUtility isNotLegal:phoneNum]){
        [DeliveryUtility showMessage:@"联系方式不可包含非法字符" target:self];
        return NO;
    }
    
    //判断面积大小
    if ([area isEqualToString:@""]) {
        [DeliveryUtility showMessage:@"请填写面积大小" target:self];
        return NO;
    }
//    else if ([DeliveryUtility isNotLegal:area]){
//        [DeliveryUtility showMessage:@"面积大小不可包含非法字符" target:self];
//        return NO;
//    }
    
    
    //判断价格
    
    if ([self.makPrice.text isEqual:@""]) {
        [DeliveryUtility showMessage:@"请填写市场价" target:self];
        return NO;
    }
    
    
    if ([price isEqualToString:@""]) {
        [DeliveryUtility showMessage:@"请填写咔么价格" target:self];
        return NO;
    }
    //判断押金
    if ([self.yajinCount.text isEqualToString:@""]) {
        [DeliveryUtility showMessage:@"请填写押金" target:self];
        return NO;
    }
    //判断类型
    NSString *type = self.typeLabel.text;
    if([type isEqual:@"请选择类型"])
    {
        [DeliveryUtility showMessage:@"请点击选择类型" target:self];
        return NO;
    }
    
    if ([self.addressLabel.text isEqualToString:@"请选择所在地"]) {
        [DeliveryUtility showMessage:@"请选择所在地" target:self];
        return NO;
    }
    
    //判断特点
    if ([feature isEqualToString:@""]) {
        [DeliveryUtility showMessage:@"请填写场地特点" target:self];
        return NO;
    }
    
    //描述信息
   if (description.length && [DeliveryUtility isNotLegal:description])
   {
        [DeliveryUtility showMessage:@"场地描述不可包含非法字符" target:self];
        return NO;
    }
    else if (description.length < 5 || description.length > 150)
    {
        [DeliveryUtility showMessage:@"描述信息应为5~150字之间" target:self];
        return NO;
    }
    NSString *imagePath = [self.imagePathArray componentsJoinedByString:@","];
    
    //图片id
    [self.siteDict setObject:APP_DELEGATE.user_id forKey:@"user_id"];
    [self.siteDict setObject:siteName forKey:@"goods_name"];
    [self.siteDict setObject:phoneNum forKey:@"goods_mobile"];
    [self.siteDict setObject:area forKey:@"goods_area"];
    [self.siteDict setObject:price forKey:@"goods_price"];
    [self.siteDict setObject:self.makPrice.text forKey:@"market_price"];
    [self.siteDict setObject:feature forKey:@"goods_alone"];
    [self.siteDict setObject:imagePath forKey:@"imgs"]; //图片(逗号拼接)
    if (self.jifendikou.on) {
        [self.siteDict setObject:@"1" forKey:@"is_deduction"];
    }else{
    [self.siteDict setObject:@"0" forKey:@"is_deduction"];
    }
    [self.siteDict setObject:self.addressLabel.text forKey:@"people_location"];
    
    //场地描述信息
    if ([description isEqualToString:@""] || [description isEqualToString:PLACE_HOLDER]) {
        [self.siteDict setObject:@"暂无详细描述信息" forKey:@"goods_desc"];
    }else{
        [self.siteDict setObject:description forKey:@"goods_desc"];
    }
    NSString * isYaJin;
    if (self.yajinSwitch.on) {
        isYaJin = @"1";
    }else{
    isYaJin = @"0";
    }
    [self.siteDict setObject:isYaJin forKey:@"is_deposit"];
    [self.siteDict setObject:self.goodsCount.text forKey:@"goods_number"];
    [self.siteDict setObject:self.yajinCount.text forKey:@"goods_deposit"];
    [self.siteDict setObject:self.typeID forKey:@"goods_category_id"];
    
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
    //判断相册访问权限
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    self.imagePicker.allowsEditing = YES;
    
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
            
            [self uploadSiteChooseImageWith:image];
            
            if (self.imageArray.count >= (_imageIndex+1))
            {
                [self.imageArray replaceObjectAtIndex:_imageIndex withObject:image];
            }else{
                [self.imageArray addObject:image];
            }
            
            [self.collectionView reloadData];
        
        }
    }
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        //如果选择的类型是图片
        if ([type isEqualToString:@"public.image"])
        {
            UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            
              [self uploadSiteChooseImageWith:image];
            if (self.imageArray.count >= (_imageIndex+1))
            {
                [self.imageArray replaceObjectAtIndex:_imageIndex withObject:image];
            }else{
                [self.imageArray addObject:image];
            }
            
            [self.collectionView reloadData];
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)uploadSiteChooseImageWith:(UIImage *)originImage
{
    NSLog(@"%f___%f",originImage.size.width,originImage.size.height);
    CGFloat i = originImage.size.width/400;
    UIImage * postImage = [DeliveryUtility imageWithImageSimple:originImage scaledToSize:CGSizeMake(originImage.size.width/i, originImage.size.height/i)];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在上传图片";
    [HUD show:YES];
    NSData * imageData = UIImagePNGRepresentation(postImage);
    [UserDesModel GetUploadImageDictWithData:imageData WithType:@"0" With:^(NSString *string) {
        if ([string isEqualToString:@"F"]) {
            HUD.labelText = @"上传失败";
            [HUD hide:YES];
        }else{
            [self.imgArray removeObjectAtIndex:0];
            [self.imagePathArray addObject:string];
            if (self.imgArray.count > 0)
            {
                [self uploadSiteChooseImageWith:self.imgArray[0]];
            }else{
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                
                if (self.desModel) {
                    
                    [self issueSiteChangeAction:nil];
                }else{
                [self issueSiteComfimrAction:nil];
                }
        }
        }
    }];
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
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self issueSiteViewKeyboardDown];
    
    self.imageIndex = indexPath.item;
    
    UIActionSheet *sheetView = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    [sheetView showInView:self.view];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==8)
    {
    
        PublishSecondCategoryController *secondCategory = [[PublishSecondCategoryController alloc]init];
        secondCategory.type = @"3";
        //返回的回调
        __weak typeof(self)wself = self;
        secondCategory.backFn = ^(NSDictionary * dict){
            [wself.siteDict setObject:dict[@"category_id"] forKey:@"goods_category_id"];  ;
            UITableViewCell *cell = [wself.tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryNone;
            wself.typeLbl .frame=CGRectMake(kViewWidth-100, 0, 80, cell.frame.size.height);
            wself.typeLbl.textColor = [UIColor blackColor];
            wself.typeLbl.text = dict[@"category_name"];
            wself.typeLbl.textAlignment = NSTextAlignmentRight;
        };
        [self.navigationController pushViewController:secondCategory animated:YES];
        NSLog(@"选择类型");
    }
}
- (void)delectChooseImageBtnClicked:(UIButton *)button
{
    NSInteger index = button.tag - 600;
    [self.imageArray removeObjectAtIndex:index];
    [self.collectionView reloadData];
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.txtSiteName) {
        [self.txtSiteName resignFirstResponder];
        [self.txtPhoneNum becomeFirstResponder];
    }
    else if (textField == self.txtPhoneNum){
        [self.txtPhoneNum resignFirstResponder];
        [self.txtSiteArea becomeFirstResponder];
    }
    else if (textField == self.txtSiteArea){
        [self.txtSiteArea resignFirstResponder];
        [self.txtPrice becomeFirstResponder];
    }
    else if (textField == self.txtPrice)
    {
        [self.txtPrice resignFirstResponder];
        [self.txtSpecial becomeFirstResponder];
    }
    else if (textField == self.txtSpecial)
    {
        [self.txtSpecial resignFirstResponder];
        [self.view endEditing:YES];
        [self.tableView endEditing:YES];
    }
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
