//
//  StoreSettingController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/17.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "StoreSettingController.h"
#import "MovieStoreSetingViewModel.h"
#import "MerchantCertificationViewController.h"
#import "JGButtonAreaView.h"
#import "ShopMainModel.h"


@interface StoreSettingController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic,strong) UIImagePickerController *imagePicker;
@property (weak, nonatomic) IBOutlet UIButton *btnType1;
@property (weak, nonatomic) IBOutlet UIButton *btnType2;
@property (weak, nonatomic) IBOutlet UIButton *btnType3;

@property (strong, nonatomic) IBOutlet UIImageView *shopCoverImage;
@property (strong, nonatomic) IBOutlet UIImageView *shopLogoImage;
@property (weak, nonatomic) IBOutlet UIView *myCellView;
@property (weak, nonatomic) IBOutlet UITextField *desAddress;

@property (strong, nonatomic) IBOutlet UITextField *txtShopName;
@property (strong, nonatomic) IBOutlet UITextField *txtBossName;
@property (strong, nonatomic) IBOutlet UITextField *txtPhoneNum;

@property (strong, nonatomic) IBOutlet UITextField *txtAddress;
@property (strong, nonatomic) IBOutlet UITextField *txtTransportation;

@property (strong, nonatomic) IBOutlet UITextView *textViewDetail;

@property (strong, nonatomic) IBOutlet UILabel *verfiyLab;


@property (nonatomic,strong) ShopMainModel *storeModel;


@property (nonatomic,retain) NSMutableDictionary *storeDict;

/** 1:上传logo  2:上传封面 */
@property (nonatomic,assign) BOOL isLogo;
@property (nonatomic,strong) NSString * imageName;
@property (nonatomic,strong)JGButtonAreaView * buttonView;

@end

@implementation StoreSettingController


- (IBAction)BtnTypeClick:(UIButton*)sender {
    
    sender.selected = !sender.selected;

}

- (void)BtnTypeClick1WithArray:(NSArray *)array{

    if ([array[0] isEqualToString:@"1"]) {
        self.btnType1.selected = YES;
    }
    if ([array[1] isEqualToString:@"1"]) {
        self.btnType2.selected = YES;
    }
    if ([array[2] isEqualToString:@"1"]) {
        self.btnType3.selected = YES;
    }
    
    

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(storeSettingTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtShopName];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(storeSettingTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtBossName];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(storeSettingTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtPhoneNum];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(storeSettingTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtAddress];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(storeSettingTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtTransportation];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(storeSettingTextViewEditChanged:) name:@"UITextViewTextDidChangeNotification" object:self.textViewDetail];
}

- (NSMutableDictionary *)storeDict
{
    if (nil == _storeDict) {
        _storeDict = [NSMutableDictionary new];
    }
    return _storeDict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavTabBar:@"店铺设置"];
    [self initSettingStoreView];
    [self requetMineStoreInfomation];
//    
    self.btnType3.layer.masksToBounds = YES;
    self.btnType2.layer.masksToBounds = YES;
    self.btnType1.layer.masksToBounds = YES;
    self.btnType3.backgroundColor = [UIColor clearColor];
#warning 传过来参数 判定 到底是 1 2 3的选中状态
//    self.btnType3.selected = YES;
    
    JGButtonAreaView * buttonView = [[JGButtonAreaView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 43)WithController:self];
    [self.myCellView addSubview:buttonView];
    self.buttonView = buttonView;
}

- (void)initSettingStoreView
{
    self.tableView.separatorColor = RGBColor(213, 213, 213, 0.5);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    //创建尾部视图确认按钮
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 80)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *comfirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    comfirmBtn.frame = CGRectMake(20, 20, kViewWidth-40, 40);
    [comfirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    comfirmBtn.backgroundColor = [UIColor whiteColor];
    [comfirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    comfirmBtn.clipsToBounds = YES;
    comfirmBtn.layer.cornerRadius = 8;
    [comfirmBtn addTarget:self action:@selector(comfirmSettingStoreAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:comfirmBtn];
    
    self.tableView.tableFooterView = footerView;
}

- (void)setStoreGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 确定设置店铺
- (void)comfirmSettingStoreAction:(id)sender
{
    NSLog(@"确定设置店铺");
    if ([self checkSettingInfomationValid]) {
        
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"正在设置";
        [HUD show:YES];
        
        [MovieHttpRequest createSettingMineStoreInfomation:self.storeDict CallBack:^(id obj) {
            HUD.labelText = @"设置成功";
            [HUD hide:YES];
            [self.navigationController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"我的店铺修改" object:nil];
            
        } andSCallBack:^(id obj) {
            
            [HUD hide:YES];
            [DeliveryUtility showMessage:obj target:self];
        }];
    }
}

/*
 *  确认并提交店铺设置
 *   user_id用户id brief店铺介绍 address店铺地址 tel电话 contact联系人 is_type是否认证:1是0否 图像修改见 开通店铺_店铺logo接口  xpoint经度 ypoint纬度
 */
- (BOOL)checkSettingInfomationValid
{
    NSString *storeName = [self.txtShopName.text asTrim]; //店铺名称
    NSString *bossName = [self.txtBossName.text asTrim];  //掌柜名
    NSString *phoneNum = [self.txtPhoneNum.text asTrim];  //电话号码
    NSString *address = [self.txtAddress.text asTrim];    //地址
//    NSString *traffic = [self.txtTransportation.text asTrim];  //交通工具
    NSString *brify = [self.textViewDetail.text asTrim];       //店铺简介
    
    //判断店铺名称
    if (0 == storeName.length) {
        [DeliveryUtility showMessage:@"请输入店铺名称" target:self];
        return NO;
    }
    else if ([DeliveryUtility isNotLegal:storeName])
    {
        [DeliveryUtility showMessage:@"店铺名称不可包含非法字符" target:self];
        return NO;
    }
    
    //判断掌柜名称
    if(0 == bossName.length)
    {
        [DeliveryUtility showMessage:@"请输入掌柜名称" target:self];
        return NO;
    }
    else if ([DeliveryUtility isNotLegal:bossName])
    {
        [DeliveryUtility showMessage:@"掌柜名不可包含非法字符" target:self];
        return NO;
    }

    //判断电话号码
    if(0 == phoneNum.length)
    {
        [DeliveryUtility showMessage:@"请输入联系电话" target:self];
        return NO;
    }
    else if (phoneNum.length != 11 || ![DeliveryUtility isPureInt:phoneNum])
    {
        [DeliveryUtility showMessage:@"联系电话格式不正确" target:self];
        return NO;
    }
    else if ([DeliveryUtility isNotLegal:bossName])
    {
        [DeliveryUtility showMessage:@"联系电话不可包含非法字符" target:self];
        return NO;
    }
    
//    if(!self.btnType1.selected==YES||self.btnType2.selected==YES||self.btnType3.selected==YES){
//         [DeliveryUtility showMessage:@"请选择店铺类别！" target:self];
//        return NO;
//    }
    
    //判断地址
    
    NSString * proID;
    NSString * citID;
    NSString * areID;
    if (![self.storeModel.spare_address isEqualToString:[self.buttonView getAddress]]) {
        if (![self.buttonView isAllAddress]) {
            [DeliveryUtility showMessage:@"请确保地址的完整性" target:self];
            return NO;
        }else{
            proID = [self.buttonView getProID];
            citID = [self.buttonView getCitID];
            areID = [self.buttonView getAreID];
        }
    }else{
        proID = self.storeModel.province_id;
        citID = self.storeModel.city_id;
        areID = self.storeModel.district_id;
    }

    
    //判断周边交通
//    if (0 == traffic.length) {
//        [DeliveryUtility showMessage:@"请输入您的交通工具" target:self];
//        return NO;
//    }
//    else if ([DeliveryUtility isNotLegal:traffic]){
//        [DeliveryUtility showMessage:@"周边交通不可包含非法字符" target:self];
//        return NO;
//    }
    
    //判断店铺简介
    if (0 == brify.length) {
        [DeliveryUtility showMessage:@"请输入您的店铺简介" target:self];
        return NO;
    }
//    else if ([DeliveryUtility isNotLegal:brify]){
//        [DeliveryUtility showMessage:@"店铺简介不可包含非法字符" target:self];
//        return NO;
//    }
    
    [self.storeDict setObject:storeName forKey:@"shop_name"];
    [self.storeDict setObject:bossName forKey:@"shop_contact_person"];
    [self.storeDict setObject:phoneNum forKey:@"shop_tel"];
    self.storeDict[@"user_id"] = self.storeModel.user_id;
    self.storeDict[@"shop_id"] = self.storeModel.shop_id;
    self.storeDict[@"shop_logo"] = self.imageName;
    self.storeDict[@"shop_desc"] = self.textViewDetail.text;
    self.storeDict[@"province_id"] = proID;
    self.storeDict[@"city_id"] = citID;
    self.storeDict[@"district_id"] = areID;
    self.storeDict[@"shop_addr_detail"] = self.desAddress.text;
    NSMutableString * category = [NSMutableString string];
    if (self.btnType1.selected) {
        [category appendString:@"13"];
    }else{
    [category appendString:@"03"];
    }
    if (self.btnType2.selected) {
         [category appendString:@"13"];
    }else{
        [category appendString:@"03"];
    }
    if (self.btnType3.selected) {
        [category appendString:@"13"];
    }else{
        [category appendString:@"03"];
    }
    
    if ([category isEqualToString:@"030303"]) {
        [DeliveryUtility showMessage:@"请选择店铺类别" target:self];
        return NO;
    }
    
    self.storeDict[@"category_id"] = category;
    self.storeDict[@"spare_address"] = [self.buttonView getAddress];

    return YES;
}



#pragma mark - 请求我的店铺数据,并刷新界面
- (void)requetMineStoreInfomation
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在加载";
    [HUD show:YES];
    
    [MovieHttpRequest createSetingStoreViewDataCallBack:^(id obj) {
        
        HUD.labelText = @"加载完成";
        [HUD hide:YES];
        
        self.storeModel = (ShopMainModel *)obj;
        [self refreshSetingShopView];
        
    } andSCallBack:^(id obj) {
        
        HUD.labelText = @"加载失败";
        [HUD hide:YES];
//        [DeliveryUtility showMessage:obj target:self];
    }];
}

- (void)refreshSetingShopView
{
    //店铺背景
    [self.shopCoverImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_PREFIX,self.storeModel.shop_logo]]];
    
    [self.shopCoverImage sizeToFit];
    
    //店铺logo
    [self.shopLogoImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,self.storeModel.shop_logo]] placeholderImage:[UIImage imageNamed:@"changShop_logo"]];
    self.imageName = self.storeModel.shop_logo;
    self.txtShopName.text = self.storeModel.shop_name;
    self.txtBossName.text = self.storeModel.shop_contact_person;
    self.txtPhoneNum.text = self.storeModel.shop_tel;
//    self.txtAddress.text = self.storeModel.shop_addr_detail;
    
    NSString * string = self.storeModel.spare_address;
    self.desAddress.text = self.storeModel.shop_addr_detail;
    NSArray * strArray = [string componentsSeparatedByString:@","];
    [_buttonView ChangeTitleWith:strArray];
    _buttonView.proID = self.storeModel.province_id;
    _buttonView.citID = self.storeModel.city_id;
    _buttonView.areID = self.storeModel.district_id;
    

    NSArray * arrCategory = [self.storeModel.category_id componentsSeparatedByString:@"3"];
    [self BtnTypeClick1WithArray:arrCategory];
    
    self.textViewDetail.text = self.storeModel.shop_desc;
    if ([self.storeModel.shop_desc isEqualToString:@"1"]) {
        self.verfiyLab.text = @"已认证";
    }
    else{
        self.verfiyLab.text = @"未认证";
    }

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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    NSLog(@"被点击的cell --> %zd,%zd",indexPath.section,indexPath.row);
    
    if (0 == indexPath.row) {

        _isLogo = NO;
        [self chooseImageFromCameraOrAblum];
    }
    else if(4 == indexPath.row) {
        
//        if ([self.storeModel.isVerify isEqualToString:@"1"]) {
        
//            [DeliveryUtility showMessage:@"您的店铺已经通过认证啦~" target:self];
//        }
//        else{
        
            MerchantCertificationViewController *certifyVC = [[MerchantCertificationViewController alloc] init];
            //certifyVC.viewTitle = @"认证店铺";
            [self.navigationController pushViewController:certifyVC animated:YES];
        }
        
//    }
}

- (void)settingViewKeyboardDown
{
    [self.view endEditing:YES];
    [self.tableView endEditing:YES];
}


#pragma mark - 店铺logo被点击
- (IBAction)tapStoreLogonImage:(id)sender
{
    _isLogo = YES;
    
    [self chooseImageFromCameraOrAblum];
}

- (void)chooseImageFromCameraOrAblum
{
    [self settingViewKeyboardDown];
    
    UIActionSheet *sheetView = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    [sheetView showInView:self.view];
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

#pragma mark - 图片选完代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        
        //如果选择的类型是图片
        if ([type isEqualToString:@"public.image"])
        {
            UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            [self requestSettingMineShopLogo:image];            
        }
    }
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        //如果选择的类型是图片
        if ([type isEqualToString:@"public.image"])
        {
            UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            [self requestSettingMineShopLogo:image];
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - 请求上传图片
- (void)requestSettingMineShopLogo:(UIImage *)originImage
{
    UIImage *postImage;
    if (_isLogo) {
        postImage = [DeliveryUtility imageWithImageSimple:originImage scaledToSize:CGSizeMake(1000, 1000)];
    }
    else{
        
        CGFloat imageW = screenWidth*0.95;
        CGFloat imageH = imageW * 0.53;
        
        postImage = [DeliveryUtility imageWithImageSimple:originImage scaledToSize:CGSizeMake(imageW, imageH)];
    }
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"上传图片";
    [HUD show:YES];
    
    NSData * imageData = UIImagePNGRepresentation(postImage);
    
    [UserDesModel GetUploadImageDictWithData:imageData WithType:@"1" With:^(NSString *string) {
        if ([string isEqualToString:@"F"]) {
            HUD.labelText = @"上传失败";
            [HUD hide:YES];
        }else{
            HUD.labelText = @"上传成功";
            self.imageName = string;
            self.shopLogoImage.image = postImage;
            [HUD hide:YES];
            
        }
    }];
    
    
}


#pragma mark - 监听输入的文字字数
- (void)storeSettingTextFiledEditChanged:(NSNotification *)noti
{
    NSInteger kMaxLength = 0;
    
    UITextField *textField = (UITextField *)noti.object;
    if (textField == self.txtBossName || textField == self.txtTransportation) {
        //掌柜名和交通
        kMaxLength = 10;
    }
    else if (textField == self.txtPhoneNum){
        //手机号
        kMaxLength = 11;
    }
    else if (textField == self.txtShopName)
    {
        //店铺名称
        kMaxLength = 20;
    }
    else if (textField == self.txtAddress){
        
        //地址
        kMaxLength = 30;
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

- (void)storeSettingTextViewEditChanged:(NSNotification *)noti
{
    NSInteger kMaxLength = 80;
    
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
