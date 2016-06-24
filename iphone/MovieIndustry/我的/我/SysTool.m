//
//  SysTool.m
//  SystemTool
//
//  Created by 童乐 on 16/1/25.
//  Copyright © 2016年 pengPL. All rights reserved.
//

#import "SysTool.h"
#import "AppDelegate.h"

@interface SysTool()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong)UIViewController * viewController;

@property (nonatomic,strong)ImageChoseEndBlock block;

@end

@implementation SysTool
//单类化
+ (instancetype)ShareTool{

    static SysTool *_tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tool = [[SysTool alloc]init];
    });
    return _tool;
}

//相机、相册
- (void)ShowActionSheetInViewController:(UIViewController*)ViewController AndChoseBlock:(ImageChoseEndBlock)block{
    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    sheet.delegate = self;
    self.viewController = ViewController;
    self.block = block;
    
    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [sheet showInView:ViewController.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self CreatePickerControllerWithType:@"0"];
            break;
        case 1:
            [self CreatePickerControllerWithType:@"1"];
            break;
        default:
            break;
    }
}
//传入type   type为0拍照   type为1相册
- (void)CreatePickerControllerWithType:(NSString *)type{
    UIImagePickerControllerSourceType soureType;
    if ([type isEqualToString:@"0"]) {
        soureType = UIImagePickerControllerSourceTypeCamera;
    }else{
        soureType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    if ([UIImagePickerController isSourceTypeAvailable:soureType]) {
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = soureType;
        [self.viewController presentViewController:picker animated:YES completion:nil];
    }
}
//这边调用后将值传出去
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage * image = info[@"UIImagePickerControllerEditedImage"];
    NSData * imageData = UIImageJPEGRepresentation(image, 1.0);
    [picker dismissViewControllerAnimated:YES completion:nil];
      self.block(image,imageData);
}
//打电话
+ (void)makePhoneCall:(NSString *)tel{
    NSString * urlStr = [NSString stringWithFormat:@"tel://%@",tel];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}
//发短信
+ (void)sendSMS:(NSString *)tel{
    NSString * str = [NSString stringWithFormat:@"sms://%@",tel];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
}
//获取屏幕截图的图片
+ (UIImage *)getCutImageFromViewRect:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.frame.size,NO,0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
//屏幕截图，并保存到相册
+ (void)saveImageFromToPhotosAlbum:(UIView *)view{
  UIImage * image = [SysTool getCutImageFromViewRect:view];
    UIImageWriteToSavedPhotosAlbum(image,self,NULL,NULL);
}

//获取文本size
+ (CGSize)caculateContentSizeWithContent:(NSString *)content AndWidth:(CGFloat)width andFont:(UIFont *)font{
    CGSize size = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return size;
}

+ (void)createLabelShowString:(NSString *)string WithView:(UIView*)view AndLabelYframe:(CGFloat)y{
    UILabel * label = [[UILabel alloc]init];
    label.text = string;
    label.numberOfLines = 0;
    CGSize size = [SysTool caculateContentSizeWithContent:string  AndWidth:view.frame.size.width-20 andFont:[UIFont systemFontOfSize:20]];
    label.frame = CGRectMake(0, 0, size.width+5, size.height+5);
    label.layer.cornerRadius = 5;
    label.layer.masksToBounds = YES;
    label.textAlignment =  NSTextAlignmentLeft;
    label.backgroundColor = [UIColor blackColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:18];
    label.center = view.center;
    CGRect rect = label.frame;
    rect.origin.y = y;
    label.frame = rect;
    [view addSubview:label];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [label removeFromSuperview];
    });
}




@end
