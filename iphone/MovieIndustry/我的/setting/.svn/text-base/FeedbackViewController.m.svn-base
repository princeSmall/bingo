//
//  FeedbackViewController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/12/18.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()<UIActionSheetDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UIImage *shopImage;
@property (nonatomic,strong) UIImagePickerController *imagePicker;
@property (nonatomic,copy) NSString *imageUrl;
@end

@implementation FeedbackViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"意见反馈"];
    self.imageUrl = @"";
    self.SuggestionsTextView.delegate = self;
    [self.feedbackImageButton setImage:[UIImage imageNamed:@"addPicture"] forState:UIControlStateNormal];
    [self.feedbackImageButton addTarget:self action:@selector(chooseShopMainImage:) forControlEvents:UIControlEventTouchUpInside];
    
     [self.phoneTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.SuggestionsTextView.delegate = self;
    
    [self.commitButton addTarget:self action:@selector(createFeedback) forControlEvents:UIControlEventTouchUpInside];
    
    //监听键盘的高度
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - 上传反馈信息
- (void)createFeedback
{
    
    
    
    
   if ([self.SuggestionsTextView.text isEqualToString:@"请输入您要反馈的具体问题..."]||[self.SuggestionsTextView.text isEqualToString:@""]) {
       [DeliveryUtility showMessage:@"请输入描述信息" target:nil];
   }else
    {
        
        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"正在提交";
        [hud show:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            hud.labelText = @"提交成功";
            [hud hide:YES afterDelay:1.0];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
//        NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[UserInfo uid],@"user_id",self.imageUrl,@"img",self.phoneTextField.text,@"mobile",self.SuggestionsTextView.text,@"content", nil];
//        [HttpRequestServers requestBaseUrl:@"http://kamefilm.uj345.net/index.php?ctl=api_fankui&act=index" withParams:userDict withRequestFinishBlock:^(id result) {
//            NSDictionary *dict = result;
//            @try {
//                if ([dict[@"status"] isEqualToString:@"f99"]) {
//                    
//                    [DeliveryUtility showMessage:@"感谢你的反馈，我们会尽快处理" target:nil];
//                }
//            }
//            @catch (NSException *exception) {
//                
//            }
//            @finally {
//                
//            }
//            
//            
//        } withFieldBlock:^{
//            
//        }];
//        
    }
//    
}


#pragma mark - 为店铺选择照片
- (void)chooseShopMainImage:(id)sender {
    
    NSLog(@"为店铺选择照片11111");
    
    [self creatShopKeyboardDown];
    
    UIActionSheet *sheetView = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    [sheetView showInView:self.view];
}

- (void)creatShopKeyboardDown
{
    [self.view endEditing:YES];
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
    //相机访问受限
//    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//    if (authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusRestricted) {
//        
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"相机访问受限" message:@"请在设备的'设置-隐私-相机'中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alertView show];
//        
//        return;
//    }
    
    
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
    //判断相册访问权限
//    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
//    if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusNotDetermined){
//        //无权限
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"相册访问受限" message:@"请在设备的'设置-隐私-相册'中允许访问相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alertView show];
//        
//        return;
//    }
    
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
     self.shopImage = originImage;
        [self.feedbackImageButton setImage:originImage forState:UIControlStateNormal];
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"请输入您要反馈的具体问题...";
        textView.textColor = [UIColor colorWithRed:0.694 green:0.690 blue:0.710 alpha:1.000];
    }
    
}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请输入您要反馈的具体问题..."]) {
         textView.text = @"";
    }
   
    textView.textColor = [UIColor blackColor];
    
}


#pragma mark - 限制输入框的字数
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.phoneTextField) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
   
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView == self.SuggestionsTextView) {
        if (textView.text.length > 100) {
            textView.text = [textView.text substringToIndex:100];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - 监听键盘高度调用的方法
//其次键盘的高度计算：
-(CGFloat)keyboardEndingFrameHeight:(NSDictionary *)userInfo//计算键盘的高度
{
    CGRect keyboardEndingUncorrectedFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGRect keyboardEndingFrame = [self.view convertRect:keyboardEndingUncorrectedFrame fromView:nil];
    return keyboardEndingFrame.size.height;
}


//传入的(NSDictionary *)userInfo用于存放键盘的各种信息，其中UIKeyboardFrameEndUserInfoKey对应的存放键盘的尺寸信息，以CGRect形式取出。

//最终返回的是键盘在当前视图中的高度。
//然后，根据键盘高度将当前视图向上滚动同样高度。
-(void)keyboardWillAppear:(NSNotification *)notification
{
    CGRect currentFrame = self.view.frame;
    
    
    //先恢复原位 //可能这个方法重复调用
    currentFrame.origin.y = 64;
    self.view.frame = currentFrame;
    
        CGFloat change = [self keyboardEndingFrameHeight:[notification userInfo]];
    
    
    if ([self.phoneTextField isFirstResponder])
    {
        currentFrame.origin.y = - change+64;
        self.view.frame = currentFrame;
        NSLog(@"%@",NSStringFromCGRect(currentFrame));
    }
    
}
//最后，当键盘消失后，视图需要恢复原状。
-(void)keyboardWillDisappear:(NSNotification *)notification
{
    //恢复原位
    CGRect currentFrame = self.view.frame;
    currentFrame.origin.y = 64;
    self.view.frame = currentFrame;
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
