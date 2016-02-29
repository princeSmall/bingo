//
//  MoviePersonalInfoViewController.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/21.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MoviePersonalInfoViewController.h"
#import "MovieMineInfoModel.h"
#import "MerchantCertificationViewController.h"

#import "CorrelationTableViewController.h"


@interface MoviePersonalInfoViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate>


@property (nonatomic,strong) UIImagePickerController *imagePicker;

@property (strong, nonatomic) IBOutlet UIImageView *headerImg;//头像

@property (strong, nonatomic) IBOutlet UIButton *levelImg;//等级图标
@property (strong, nonatomic) IBOutlet UILabel *name;//名字

@property (strong, nonatomic) IBOutlet UILabel *mineStatue;//资深摄影师

@property (strong, nonatomic) IBOutlet UILabel *fans;//粉丝数量

@property (strong, nonatomic) IBOutlet UILabel *attention;//关注数量

@property (strong, nonatomic) IBOutlet UILabel *scringNum;//积分


@property (strong, nonatomic) IBOutlet UITextField *txtName;//姓名输入框

@property (strong, nonatomic) IBOutlet UILabel *certifyStatue;//认证状态

@property (strong, nonatomic) IBOutlet UITextField *txtCareer;//职业输入框

@property (strong, nonatomic) IBOutlet UITextField *txtAddress;//地址输入框


@property (strong, nonatomic) IBOutlet UITextField *txtPhoneNum;//手机号输入框

@property (strong, nonatomic) IBOutlet UITextField *txtSchoolName;//学校/单位输入框
@property (strong, nonatomic) IBOutlet UIView *whiteLine;


@property (strong, nonatomic) IBOutlet UIButton *boyBtn;
@property (strong, nonatomic) IBOutlet UIButton *girlBtn;

@property (nonatomic,strong)NSString * imagePath;

/** 性别被选中按钮 */
@property (nonatomic,retain) UIButton *selectedBtn;

/** 请求修改的数据源 */
@property (nonatomic,strong) NSMutableDictionary *infoDict;


@end

@implementation MoviePersonalInfoViewController

//关联按钮  点击事件  点击跳转 下个页面
- (IBAction)correlationClick:(id)sender {
    
    CorrelationTableViewController * correlation = [self.storyboard instantiateViewControllerWithIdentifier:@"CorrelationTableViewController"];
    [self.navigationController pushViewController:correlation animated:YES];
    
}

- (NSMutableDictionary *)infoDict
{
    if (nil == _infoDict) {
        _infoDict = [NSMutableDictionary new];
    }
    return _infoDict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTextFieldInputeNotification];
    [self setNavTabBar:@"个人信息"];
    [self initPersonalInfoView];
    self.imagePath = self.desModel.img;
}

- (void)setNavTabBar:(NSString *)title
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

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initPersonalInfoView
{
    self.headerImg.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseMineHeaderImage)];
    [self.headerImg addGestureRecognizer:tapGes];
    
    self.levelImg.clipsToBounds = YES;
    self.levelImg.layer.cornerRadius = 8.0f;
    
    self.view.backgroundColor = BGColor;
    self.tableView.backgroundColor = BGColor;
    [self.tableView setSeparatorColor:BGColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    
    if (self.desModel) {
        
        NSString *headerImgPath = self.desModel.img;
        NSString *nikeName = self.desModel.nickname;
        NSString *sex = self.desModel.sex;
//        NSString *profession = self.desModel.pr;
//        NSString *address = self.desModel.;
        NSString *phoneNum = self.desModel.mobile;
//        NSString *comeFrom = self.mineModel.comeFrom;
        
        [self.headerImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,headerImgPath]] placeholderImage:[UIImage imageNamed:@"defualt_headerImg"]];
                
        self.name.text = [nikeName asTrim];
//        self.mineStatue.text = [profession asTrim];
        
//        self.fans.text = [NSString stringWithFormat:@"粉丝: %@",self.mineModel.favedCount];
//        self.attention.text = [NSString stringWithFormat:@"关注: %@",self.mineModel.favCount];
//        self.scringNum.text = [NSString stringWithFormat:@"积分: %@",self.mineModel.point];
        
        //是否认证
//        if ([self.mineModel.verify isEqualToString:@"1"]) {
            self.certifyStatue.text = @"未认证";
//        }else
//            self.certifyStatue.text = @"已认证";
//        
        
        // sex: -1未知  0女   1:男
        if ([self.desModel.sex isEqualToString:@"0"]) {
            self.girlBtn.selected = YES;
            self.selectedBtn = self.girlBtn;
        }
        else if ([self.desModel.sex isEqualToString:@"1"])
        {
            self.boyBtn.selected = YES;
            self.selectedBtn = self.boyBtn;
        }
        self.txtName.text = nikeName;
//        self.txtCareer.text = profession;
//        self.txtAddress.text = address;
        self.txtPhoneNum.text = phoneNum;
//        self.txtSchoolName.text = comeFrom;
        
        //等级
//        if (![self.mineModel.rank isEqualToString:@""]) {
//            
//            //用户等级
//            NSString *gradeLevel = [NSString stringWithFormat:@"V%@",self.mineModel.rank];
//            NSMutableAttributedString *levelAtt = [[NSMutableAttributedString alloc] initWithString:gradeLevel];
//            [levelAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15.0f] range:NSMakeRange(0,1)];
//            [levelAtt addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, gradeLevel.length)];
//            [self.levelImg setAttributedTitle:levelAtt forState:UIControlStateNormal];
//        }
//        else{
//            self.levelImg.hidden = YES;
//        }
        
////        [self.infoDict setObject:headerImgPath forKey:@"icon_img"];
//        [self.infoDict setObject:nikeName forKey:@"nikename"];
//        [self.infoDict setObject:sex forKey:@"sex"];
//        [self.infoDict setObject:profession forKey:@"profession"];
//        [self.infoDict setObject:address forKey:@"my_address"];
//        [self.infoDict setObject:comeFrom forKey:@"come_from"];
        if (!self.imagePath) {
            self.imagePath = @"";
        }
//        [self.infoDict setObject:self.imagePath forKey:@"img"];
        
        [self setPersonInfoNewFrame];
    }
    
    [self createBottomComfirmBtn];
}


#pragma mark - 根据文字内容设置frame
- (void)setPersonInfoNewFrame
{
    CGRect nameFrame = self.name.frame;
    nameFrame.size.width = [DeliveryUtility caculateContentSizeWithContent:self.desModel.nickname andHight:21.0f andWidth:((kViewWidth-110)/2) andFont:[UIFont systemFontOfSize:16.0f]].width;
    self.name.frame = nameFrame;
    
    CGRect lineFrame = self.whiteLine.frame;
    lineFrame.origin.x = CGRectGetMaxX(nameFrame)+10;
    self.whiteLine.frame = lineFrame;
    
    CGRect careerFrame = self.mineStatue.frame;
    careerFrame.origin.x = CGRectGetMaxX(lineFrame)+10;
    careerFrame.size.width = (kViewWidth-nameFrame.size.width - 150);
    self.mineStatue.frame = careerFrame;
    
    NSString *fansStr = [NSString stringWithFormat:@"粉丝: %@",self.mineModel.favedCount];
    CGRect fansFrame = self.fans.frame;
    fansFrame.size.width = [DeliveryUtility caculateContentSizeWithContent:fansStr andHight:21.0f andWidth:((kViewWidth-100)/2) andFont:[UIFont systemFontOfSize:13.0f]].width;
    self.fans.frame = fansFrame;
    
    CGRect concernFrame = self.attention.frame;
    concernFrame.origin.x = CGRectGetMaxX(fansFrame)+20;
    self.attention.frame = concernFrame;
}


#pragma mark - 添加监听文本输入框输入字数通知
- (void)addTextFieldInputeNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(personInfoTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtName];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(personInfoTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtCareer];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(personInfoTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtPhoneNum];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(personInfoTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtAddress];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(personInfoTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtSchoolName];
}

- (void)personInfoTextFiledEditChanged:(NSNotification *)noti
{
    NSInteger kMaxLength = 0;
    
    UITextField *textField = (UITextField *)noti.object;
    if (textField == self.txtName || textField == self.txtCareer) {
        //姓名和职业
        kMaxLength = 10;
    }
    else if (textField == self.txtPhoneNum){
        //手机号
        kMaxLength = 11;
    }
    else if (textField == self.txtAddress || textField == self.txtSchoolName){
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


#pragma mark - 创建底部确定按钮
- (void)createBottomComfirmBtn
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 80)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *comfirmBtn = [DeliveryUtility createBtnFrame:CGRectMake(20,-30,kViewWidth-40,50) title:@"确认" andFont:[UIFont systemFontOfSize:17.0f] target:self action:@selector(comfirmSetingMineInfo:)];
    comfirmBtn.backgroundColor = [UIColor whiteColor];
    [comfirmBtn setTitleColor:RGBColor(38, 38, 38, 1) forState:UIControlStateNormal];
    comfirmBtn.clipsToBounds = YES;
    comfirmBtn.layer.cornerRadius = 5.0f;
    [footerView addSubview:comfirmBtn];
    
    self.tableView.tableFooterView = footerView;
    self.tableView.tableFooterView.userInteractionEnabled = YES;
}



#pragma mark - 确认按钮点击
- (void)comfirmSetingMineInfo:(id)sender
{
    NSLog(@"确认按钮点击");
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"正在保存";
        [HUD show:YES];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"user_id"] = APP_DELEGATE.user_id;
    dict[@"nickname"] = self.txtName.text;
    
    NSString * sex;
    if (self.boyBtn.selected) {
        sex = @"1";
    }else if (self.girlBtn.selected){
        sex = @"0";
    }
    dict[@"sex"] = sex;
    dict[@"mobile"] = self.txtPhoneNum.text;
    
    if (!self.imagePath) {
        self.imagePath = @" ";
    }
    dict[@"img"] = self.imagePath;
       [HttpRequestServers requestBaseUrl:TIPerson_UpdateUser withParams:dict withRequestFinishBlock:^(id result) {
           NSDictionary * dict = result;
           if ([dict[@"code"] intValue] == 0) {
               HUD.labelText = @"保存成功";
               [HUD hide:YES];
               [self.navigationController popViewControllerAnimated:YES];
           }
       } withFieldBlock:^{
           HUD.labelText = @"保存失败";
           [HUD hide:YES];
       }];
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (BOOL)checkModifyInfoValid
{
    NSString *nikeName = [self.txtName.text asTrim];
    NSString *profession = [self.txtCareer.text asTrim];
    NSString *address = [self.txtAddress.text asTrim];
    NSString *comeFrom = [self.txtSchoolName.text asTrim];
    NSString *phoneNum = [self.txtPhoneNum.text asTrim];
    //性别
    NSString *sex = (200==self.selectedBtn.tag)?@"0":@"1";
    
    //判断姓名
    if ([nikeName isEqualToString:@""]) {
        [DeliveryUtility showMessage:@"请填写您的昵称" target:self];
        return NO;
    }
//    else if ([DeliveryUtility isNotLegal:nikeName]){
//        [DeliveryUtility showMessage:@"昵称不可包含非法字符" target:self];
//        return NO;
//    }
    
    //性别
    if (!self.selectedBtn) {
        [DeliveryUtility showMessage:@"请选择性别" target:self];
        return NO;
    }
    
    //职业
    if ([profession isEqualToString:@""]) {
        [DeliveryUtility showMessage:@"请输入您的职业" target:self];
        return NO;
    }
//    else if ([DeliveryUtility isNotLegal:profession]){
//        [DeliveryUtility showMessage:@"职业不可包含非法字符" target:self];
//        return NO;
//    }
    
    //地址
    if ([address isEqualToString:@""]) {
        [DeliveryUtility showMessage:@"请输入您的地址" target:self];
        return NO;
    }
//    else if ([DeliveryUtility isNotLegal:address]){
//        [DeliveryUtility showMessage:@"地址不可包含非法字符" target:self];
//        return NO;
//    }
    
    //手机号
    if ([phoneNum isEqualToString:@""]) {
        [DeliveryUtility showMessage:@"请输入手机号" target:self];
        return NO;
    }
    else if (![DeliveryUtility isPureInt:phoneNum] || [DeliveryUtility isNotLegal:phoneNum] || phoneNum.length!=11) {
        [DeliveryUtility showMessage:@"手机号格式不正确,请重新输入" target:self];
        return NO;
    }
    
    //来自 (学校/单位)
    if ([comeFrom isEqualToString:@""]) {
        [DeliveryUtility showMessage:@"请输入学校或单位内容" target:self];
        return NO;
    }
//    else if([DeliveryUtility isNotLegal:comeFrom])
//    {
//        [DeliveryUtility showMessage:@"学校或单位内容不可包含非法字符" target:self];
//        return NO;
//    }
    
    if (![nikeName isEqualToString:@""]) {
        [self.infoDict setObject:nikeName forKey:@"nikename"];
    }
    
    if (![sex isEqualToString:@""]) {
        [self.infoDict setObject:sex forKey:@"sex"];
    }
    
    if (![profession isEqualToString:@""]) {
        [self.infoDict setObject:profession forKey:@"profession"];
    }
    
    if (![address isEqualToString:@""]) {
        [self.infoDict setObject:address forKey:@"my_address"];
    }
    
    if (![comeFrom isEqualToString:@""]) {
        [self.infoDict setObject:comeFrom forKey:@"come_from"];
    }
    
    return YES;
}



#pragma mark - 回收键盘
- (void)personalInfoKeyboardDown
{
    [self.view endEditing:YES];
    [self.tableView endEditing:YES];
}


- (IBAction)chooseSexStatueAction:(UIButton *)sender {
    
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
}

#pragma mark - UITableViewDelegate


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self personalInfoKeyboardDown];
    
     if (3 == indexPath.section) {
         
         if ([self.mineModel.verify isEqualToString:@"1"]) {
             [DeliveryUtility showMessage:@"您的身份已经认证啦~" target:self];
             return;
         }
         else{
             MerchantCertificationViewController *certifyVC = [[MerchantCertificationViewController alloc] init];
             //certifyVC.viewTitle = @"认证会员";
             [self.navigationController pushViewController:certifyVC animated:YES];
         }
    }
}


- (void)personInfoKeyboardDown
{
    [self.view endEditing:YES];
    [self.tableView endEditing:YES];
}


#pragma mark - 选择我的头像
- (void)chooseMineHeaderImage
{
    [self personInfoKeyboardDown];
    
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

#pragma mark - 上传图片
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        
        //如果选择的类型是图片
        if ([type isEqualToString:@"public.image"])
        {
            UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
            [self postImageRequestWith:image];
        }
    }
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        //如果选择的类型是图片
        if ([type isEqualToString:@"public.image"])
        {
            UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            [self postImageRequestWith:image];
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 上传用户头像
- (void)postImageRequestWith:(UIImage *)originImage
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在上传头像";
    [HUD show:YES];
       UIImage *postImage = [DeliveryUtility imageWithImageSimple:originImage scaledToSize:CGSizeMake(700,700)];
    self.headerImg.image = postImage;
    NSData * imageData = UIImagePNGRepresentation(postImage);
    [UserDesModel GetUploadImageDictWithData:imageData WithType:@"1" With:^(NSString *string) {
        if ([string isEqualToString:@"F"]) {
            HUD.labelText = @"上传失败";
            [HUD hide:YES afterDelay:0.25];
        }else{
            HUD.labelText = @"上传成功";
            [HUD hide:YES afterDelay:0.25];
            self.imagePath = string;
            
        }
    }];
 }



#pragma mark - UITextViewDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.txtName) {
        [self.txtName resignFirstResponder];
        [self.txtCareer becomeFirstResponder];
    }
    else if (textField == self.txtCareer){
        [self.txtCareer resignFirstResponder];
        [self.txtAddress becomeFirstResponder];
    }
    else if (textField == self.txtAddress){
        [self.txtAddress resignFirstResponder];
        [self.txtPhoneNum becomeFirstResponder];
    }
    else if (textField == self.txtPhoneNum){
        [self.txtPhoneNum resignFirstResponder];
        [self.txtSchoolName becomeFirstResponder];
    }
    else if (textField == self.txtSchoolName){
        [self.txtSchoolName resignFirstResponder];
        [self.tableView endEditing:YES];
    }
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //    MoviePersonalInfoViewController *movie = [uis];
    // Dispose of any resources that can be recreated.
}


@end
