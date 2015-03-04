//
//  MovieCreateMineShopViewController.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/21.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieCreateMineShopViewController.h"
#import "CommentHtmlViewController.h"
#import "JGButtonAreaView.h"

@interface MovieCreateMineShopViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

@property (nonatomic,strong) UIImagePickerController *imagePicker;
@property (strong, nonatomic) IBOutlet UIImageView *shopImage;
@property (strong, nonatomic) IBOutlet UITextField *txtShopName;
@property (strong, nonatomic) IBOutlet UITextField *txtIntroduce;
#warning 这里需要修改
@property (nonatomic,strong)JGButtonAreaView * buttonAreaView;
@property (strong, nonatomic) IBOutlet UITextField *txtCity;
@property (weak, nonatomic) IBOutlet UIView *myView;
@property (strong, nonatomic) IBOutlet UITextField *txtAddress;
@property (strong, nonatomic) IBOutlet UITextField *txtPhoneNum;
@property (strong, nonatomic) IBOutlet UITextField *txtContact;
@property (nonatomic,strong) UIButton *selectedBtn;
@property (nonatomic,strong) NSMutableDictionary *storeDict;
@property (strong, nonatomic) IBOutlet UIButton *readButton;


//人员 器材 场地按钮
@property (weak, nonatomic) IBOutlet UIButton *peopleBtn;

@property (weak, nonatomic) IBOutlet UIButton *thingsBtn;
@property (weak, nonatomic) IBOutlet UIButton *areaBtn;


@property (nonatomic,strong)NSString * imageName;
@end

@implementation MovieCreateMineShopViewController

- (NSMutableDictionary *)storeDict
{
    if (nil == _storeDict) {
        _storeDict = [NSMutableDictionary new];
    }
    return _storeDict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"开通店铺"];
    [self initCreateMineShopView];
    [self openStoreAddTextFieldNotification];
    JGButtonAreaView *buttonAreaView = [[JGButtonAreaView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40) WithController:self];
    [self.myView addSubview:buttonAreaView];
    
    self.buttonAreaView = buttonAreaView;
    
}


- (void)initCreateMineShopView
{
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}


#pragma mark - 添加监听文本输入框输入字数通知
- (void)openStoreAddTextFieldNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(openStoreTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtShopName];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(openStoreTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtIntroduce];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(openStoreTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtCity];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(openStoreTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtAddress];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(openStoreTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtPhoneNum];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(openStoreTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtContact];
}


- (void)openStoreTextFiledEditChanged:(NSNotification *)noti
{
    NSInteger kMaxLength = 0;
    
    UITextField *textField = (UITextField *)noti.object;
    if (textField == self.txtShopName || textField == self.txtCity || textField == self.txtContact) {
        //店铺名称,职业,联系人
        kMaxLength = 10;
    }
    else if (textField == self.txtPhoneNum){
        //手机号
        kMaxLength = 11;
    }
    else if (textField == self.txtAddress || textField == self.txtIntroduce){
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


#pragma mark - 选择开店类型 人员/器材/场地
- (IBAction)chooseShopTypeAction:(UIButton *)sender {
    
//    self.selectedBtn.selected = sender.selected;
    sender.selected = !sender.selected;
//    self.selectedBtn = sender;
}


#pragma mark - 确定开通店铺
- (IBAction)comfirmCreateMineShop:(UIButton *)sender {
    
    if ([self checkCreateMineStoreValid]) {
        
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"正在发布";
        [HUD show:YES];
        
        [MovieHttpRequest createOpenMineStoreWithInfo:self.storeDict CallBack:^(id obj) {
            
            HUD.labelText = @"保存发布";
            [HUD hide:YES];
            
            [self.view makeToastCenter:@"发布成功"];
            [self performSelector:@selector(openMineShopGoBack) withObject:nil afterDelay:0.25];
            
        } andSCallBack:^(id obj) {
            
            HUD.labelText = @"保存失败";
            [HUD hide:YES];
        }];
    }
    
    NSLog(@"确定开通店铺");
}


- (void)openMineShopGoBack
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"storeOpenSuccess" object:nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"createMineStoreSuccess" object:@"1"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (BOOL)checkCreateMineStoreValid
{
    NSString *shopNameStr = [self.txtShopName.text asTrim];
    NSString *briefStr = [self.txtIntroduce.text asTrim];
    NSString *cityStr ;
    NSString * proID;
    NSString * citID;
    NSString * areID;
    
    if (![self.buttonAreaView isAllAddress]) {
        cityStr = @"";
    }else{
      cityStr = [self.buttonAreaView getAddress];
        proID = [self.buttonAreaView getProID];
        citID = [self.buttonAreaView getCitID];
        areID = [self.buttonAreaView getAreID];
    }
    

    
    
    NSString *addressStr = [self.txtAddress.text asTrim];
    NSString *telStr = [self.txtPhoneNum.text asTrim];
    NSString *contectStr = [self.txtContact.text asTrim];
    
    //判断店铺名称
    if ([shopNameStr isEqualToString:@""]) {
        [DeliveryUtility showMessage:@"请填写店铺名称" target:self];
        return NO;
    }
    else if ([DeliveryUtility isNotLegal:shopNameStr]){
        [DeliveryUtility showMessage:@"店铺名称不可包含非法字符" target:self];
        return NO;
    }
    
    //判断店铺介绍
    if ([briefStr isEqualToString:@""]){
        [DeliveryUtility showMessage:@"请填写店铺介绍" target:self];
        return NO;
    }
//    else if ([DeliveryUtility isNotLegal:briefStr]){
//        [DeliveryUtility showMessage:@"店铺简介不可包含非法字符" target:self];
//        return NO;
//    }
    
    if ([cityStr isEqualToString:@""]){
        [DeliveryUtility showMessage:@"请确保地址信息完整" target:self];
        return NO;
    }
//    else if ([DeliveryUtility isNotLegal:cityStr]){
//        [DeliveryUtility showMessage:@"地址不可包含非法字符" target:self];
//        return NO;
//    }
    
    if (!self.imageName) {
        [DeliveryUtility showMessage:@"请选择店铺logo" target:self];
        return NO;
    }
    
    if ([addressStr isEqualToString:@""]){
        [DeliveryUtility showMessage:@"请填写详细地址" target:self];
        return NO;
    }
    else if ([DeliveryUtility isNotLegal:addressStr]){
        [DeliveryUtility showMessage:@"详细地址不可包含非法字符" target:self];
        return NO;
    }

    //判断联系电话
    if ([telStr isEqualToString:@""]){
        [DeliveryUtility showMessage:@"请填写电话号码" target:self];
        return NO;
    }
    else if ([DeliveryUtility isNotLegal:telStr]){
        [DeliveryUtility showMessage:@"电话号码不可包含非法字符" target:self];
        return NO;
    }
    
    if ([contectStr isEqualToString:@""]){
        [DeliveryUtility showMessage:@"请填写联系人信息" target:self];
        return NO;
    }
    else if ([DeliveryUtility isNotLegal:contectStr]){
        [DeliveryUtility showMessage:@"联系人信息不可包含非法字符" target:self];
        return NO;
    }    
    
    else if (!(self.peopleBtn.selected ==YES||self.thingsBtn.selected ==YES||self.areaBtn.selected ==YES)) {
        [DeliveryUtility showMessage:@"请选择店铺类型" target:self];
        return NO;
    }
    
    //判断是否勾选阅读开店须知
    if (!self.readButton.selected) {
        [DeliveryUtility showMessage:@"请勾选'我已阅读开店须知'" target:self];
        return NO;
    }
    
    [self.storeDict setObject:APP_DELEGATE.user_id forKey:@"user_id"];
    [self.storeDict setObject:shopNameStr forKey:@"shop_name"];
    [self.storeDict setObject:self.imageName forKey:@"shop_logo"];
    [self.storeDict setObject:self.txtIntroduce.text forKey:@"shop_desc"];
    
    [self.storeDict setObject:self.txtAddress.text forKey:@"shop_addr_detail"];
    [self.storeDict setObject:proID forKey:@"province_id"];
    [self.storeDict setObject:citID forKey:@"city_id"];
    [self.storeDict setObject:areID forKey:@"district_id"];
    [self.storeDict setObject:addressStr forKey:@"shop_addr_detail"];
//    [self.storeDict setObject:cityStr forKey:@"city_id"];
    [self.storeDict setObject:telStr forKey:@"shop_tel"];
    [self.storeDict setObject:contectStr forKey:@"shop_contact_person"];
    NSMutableString * category = [NSMutableString string];
    if (self.peopleBtn.selected) {
        [category appendString:@"13"];
    }else{
        [category appendString:@"03"];
    }
    
    if (self.thingsBtn.selected) {
       [category appendString:@"13"];
    }else{
        [category appendString:@"03"];
    }
    if (self.areaBtn.selected) {
        [category appendString:@"13"];
    }else{
        [category appendString:@"03"];
    }
    [self.storeDict setObject:category forKey:@"category_id"];
    [self.storeDict setObject:cityStr forKey:@"spare_address"];
    return YES;
}

#pragma mark - 勾选我已经阅读开店须知
- (IBAction)haveReadedCreateShopRules:(UIButton *)button
{
    button.selected = !button.selected;
}


#pragma mark - 进入查看开店须知
- (IBAction)gotoReferRules:(id)sender {
    
//    NSString *rulePath = OpenStore_Rule;
    
    CommentHtmlViewController *ruleView = [[CommentHtmlViewController alloc] init];
    ruleView.titleName = @"开店须知";
    ruleView.urlPath = OpenStore_Rule;
    [self.navigationController pushViewController:ruleView animated:YES];
}


#pragma mark - 为店铺选择照片
- (IBAction)chooseShopMainImage:(id)sender {
    
    NSLog(@"为店铺选择照片11111");
    
    [self creatShopKeyboardDown];
    
    UIActionSheet *sheetView = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    [sheetView showInView:self.view];
}


- (void)creatShopKeyboardDown
{
    [self.view endEditing:YES];
    [self.tableView endEditing:YES];
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
            [self uploadStoreLogoImage:image];
        }
    }
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        //如果选择的类型是图片
        if ([type isEqualToString:@"public.image"])
        {
            UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            [self uploadStoreLogoImage:image];
        }
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)uploadStoreLogoImage:(UIImage *)originImage
{
    UIImage *postImage = [DeliveryUtility imageWithImageSimple:originImage scaledToSize:CGSizeMake(200, 150)];
    
    NSData * imageData = UIImagePNGRepresentation(postImage);
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在上传图片";
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
        self.shopImage.image = postImage;
   } withFieldBlock:^{
       HUD.labelText = @"图片上传失败！";
      [HUD hide:YES];
   }];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (self.txtShopName == textField) {
        [self.txtShopName resignFirstResponder];
        [self.txtIntroduce becomeFirstResponder];
    }
    else if (self.txtIntroduce == textField){
        [self.txtIntroduce resignFirstResponder];
        [self.txtCity becomeFirstResponder];
    }
    else if (self.txtCity == textField){
        [self.txtCity resignFirstResponder];
        [self.txtAddress becomeFirstResponder];
    }
    else if (self.txtAddress == textField){
        [self.txtAddress resignFirstResponder];
        [self.txtPhoneNum becomeFirstResponder];
    }
    else if (self.txtPhoneNum == textField){
        [self.txtPhoneNum resignFirstResponder];
        [self.txtContact becomeFirstResponder];
    }
    else if (self.txtContact == textField){
        [self.txtContact resignFirstResponder];
    }
    
    return YES;
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self creatShopKeyboardDown];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
