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
    if ([self.SuggestionsTextView.text isEqualToString:@"请简要描述你的问题和意见"]||[self.SuggestionsTextView.text isEqualToString:@""]) {
        [PromptLabel custemAlertPromAddView:self.view text:@"请输入反馈内容"];
    }else
    {
        NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[UserInfo uid],@"user_id",self.imageUrl,@"img",self.phoneTextField.text,@"mobile",self.SuggestionsTextView.text,@"content", nil];
        [HttpRequestServers requestBaseUrl:@"http://kamefilm.uj345.net/index.php?ctl=api_fankui&act=index" withParams:userDict withRequestFinishBlock:^(id result) {
            NSDictionary *dict = result;
            @try {
                if ([dict[@"status"] isEqualToString:@"f99"]) {
                    
                    PromptLabel *prom = [[PromptLabel alloc] initWithString:@"感谢您的反馈！我们会尽快处理"];
                    prom.frame = CGRectMake(0, 0, 120, 50);
                    prom.center=CGPointMake(kViewWidth/2,kViewHeight*0.3);
                    
                    [self.view addSubview:prom];
                    [prom MyViewRemove];
                    
                }
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
            
            
        } withFieldBlock:^{
            
        }];
        
    }
    
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
    UIImage *postImage = [DeliveryUtility imageWithImageSimple:originImage scaledToSize:CGSizeMake(200, 150)];
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在上传图片";
    [HUD show:YES];
    
    [HttpRequestServers postImageRequest:Image_upload UIImage:postImage parameters:nil requestFinish:^(id result) {
        
        NSLog(@"上传图片成功 --> %@",result);
        
        NSDictionary *dict = (NSDictionary *)result;
        if ([dict[@"status"] isEqualToString:@"f99"]) {
            
            NSString *imagePath = [DeliveryUtility nullString:dict[@"image_url"]];
            
            self.imageUrl = imagePath;
            //设置图片
            self.feedbackImageView.image = postImage;
            [self.feedbackImageButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            self.shopImage = postImage;
            HUD.labelText = @"上传成功";
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


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.text = @"";
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
